part of 'summarize_bloc.dart';

sealed class SummarizeEvent extends Equatable {

  const SummarizeEvent();
}

class SendUrl extends SummarizeEvent {
  final String text;
  final String apiKey;

  const SendUrl({required this.text, required this.apiKey});

  @override
  List<Object> get props => [text, apiKey];
}
