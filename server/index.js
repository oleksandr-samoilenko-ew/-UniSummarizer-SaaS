const express = require('express');
const youtubedl = require('youtube-dl-exec');
const axios = require('axios');
const xml2js = require('xml2js');
const fs = require('fs');
const cheerio = require('cheerio'); // Import cheerio for HTML parsing
const GroqClient = require('groq-sdk'); // Import Groq AI SDK
const app = express();
const port = 3000;

app.use(express.json());

app.get('/', (req, res) => {
    res.send('Backend for Flutter app!');
});

app.post('/fetch-subtitles', async (req, res) => {
    const { url, apiKey } = req.body;
    // Initialize Groq AI Client
    const groqClient = new GroqClient({
        apiKey: apiKey,
    });
    if (!url) {
        return res.status(400).json({ error: 'URL is required' });
    }

    try {
        const output = await youtubedl(url, {
            dumpSingleJson: true,
            noCheckCertificates: true,
            noWarnings: true,
            preferFreeFormats: true,
            subLang: 'en',
            writeAutoSub: true,
            addHeader: ['referer:youtube.com', 'user-agent:googlebot'],
        });

        const captions = output.automatic_captions.en;
        const srv1Caption = captions.find((caption) => caption.ext === 'srv1');

        if (!srv1Caption) {
            return res.status(404).json({ error: 'srv1 caption not found' });
        }

        const response = await axios.get(srv1Caption.url);
        const xmlData = response.data;

        // Write the XML data to a local file
        const filePath = './srv1_caption.xml';
        fs.writeFileSync(filePath, xmlData);

        // Read and parse the local file
        const fileData = fs.readFileSync(filePath, 'utf8');
        xml2js.parseString(fileData, async (err, result) => {
            if (err) {
                return res.status(500).json({ error: 'Failed to parse XML' });
            }

            const texts = result.transcript.text
                .map((text) => text._)
                .join(' ');

            const question = 'Create short summary of the following text:';

            // Summarize texts using Groq AI
            try {
                const chatCompletion = await groqClient.chat.completions.create(
                    {
                        messages: [
                            {
                                role: 'system',
                                content: 'You are a helpful assistant.',
                            },
                            {
                                role: 'user',
                                content: `${question}: ${texts}`,
                            },
                        ],
                        model: 'llama3-8b-8192',
                    }
                );

                const summary = chatCompletion.choices[0].message.content;
                res.json({ summary });
                console.log('Summary:', summary);
            } catch (summarizeError) {
                console.error(summarizeError);
                res.status(500).json({ error: 'Failed to summarize texts' });
            }
        });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Failed to fetch subtitles' });
    }
});
app.post('/summarize-website', async (req, res) => {
    const { url, apiKey } = req.body;
    // Initialize Groq AI Client
    const groqClient = new GroqClient({
        apiKey: apiKey,
    });
    if (!url) {
        return res.status(400).json({ error: 'URL is required' });
    }

    try {
        const response = await axios.get(url);
        const html = response.data;

        // Load HTML into cheerio
        const $ = cheerio.load(html);

        // Extract text content from the website
        let texts = $('body').text().replace(/\s+/g, ' ').trim();

        // Truncate text to a manageable length
        const maxLength = 2000; // Adjust this value as needed
        if (texts.length > maxLength) {
            texts = texts.substring(0, maxLength) + '...';
        }

        const question = 'Create short summary of the following text:';

        // Summarize texts using Groq AI
        try {
            const chatCompletion = await groqClient.chat.completions.create({
                messages: [
                    {
                        role: 'system',
                        content: 'You are a helpful assistant.',
                    },
                    {
                        role: 'user',
                        content: `${question}: ${texts}`,
                    },
                ],
                model: 'llama3-8b-8192',
            });

            const summary = chatCompletion.choices[0].message.content;
            res.json({ summary });
            console.log('Summary:', summary);
        } catch (summarizeError) {
            console.error(summarizeError);
            res.status(500).json({
                error: 'Failed to summarize website content',
            });
        }
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Failed to fetch website content' });
    }
});

app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
