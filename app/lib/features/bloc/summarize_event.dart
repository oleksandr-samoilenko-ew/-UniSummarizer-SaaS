part of 'summarize_bloc.dart';

sealed class SummarizeEvent extends Equatable {

  const SummarizeEvent();
}

class SendYoutubeUrl extends SummarizeEvent {
  final String text;

  const SendYoutubeUrl(this.text);

  @override
  List<Object> get props => [text];
}
