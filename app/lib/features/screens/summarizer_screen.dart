import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/summarize_bloc.dart';

class SummarizerScreen extends StatefulWidget {
  const SummarizerScreen({super.key});

  @override
  State<SummarizerScreen> createState() => _SummarizerScreenState();
}

class _SummarizerScreenState extends State<SummarizerScreen> {
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _apiKeyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('YouTube Summarizer'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: _urlController,
                decoration: const InputDecoration(labelText: 'URL'),
                onSubmitted: (value) {},
              ),
              TextField(
                controller: _apiKeyController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'YouTube Groq API Key'),
                onSubmitted: (value) {},
              ),
              TextButton(
                onPressed: () {
                  context.read<SummarizeBloc>().add(SendUrl(
                        text: _urlController.text,
                        apiKey: _apiKeyController.text,
                      ));
                },
                child: const Text('Summarize'),
              ),
              BlocBuilder<SummarizeBloc, SummarizeState>(builder: (context, state) {
                if (state is SummarizeLoading) {
                  return const CircularProgressIndicator();
                } else if (state is SummarizeLoaded) {
                  return Text(state.summarize);
                } else if (state is SummarizeError) {
                  return const Text('Failed to fetch subtitles');
                } else {
                  return const Text('Enter a YouTube or Website URL and Groq API Key');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
