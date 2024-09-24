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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('YouTube Summarizer'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _urlController,
            decoration: const InputDecoration(labelText: 'YouTube URL'),
            onSubmitted: (value) {},
          ),
          TextButton(
            onPressed: () {
              context.read<SummarizeBloc>().add(SendYoutubeUrl(_urlController.text));
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
              return const Text('Enter a YouTube URL');
            }
          }),
        ],
      ),
    );
  }
}