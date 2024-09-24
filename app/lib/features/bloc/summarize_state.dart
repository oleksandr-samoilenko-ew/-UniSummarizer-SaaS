part of 'summarize_bloc.dart';

sealed class SummarizeState extends Equatable {
  const SummarizeState();
}

class SummarizeInitial extends SummarizeState {
  @override
  List<Object> get props => [];
}

class SummarizeLoading extends SummarizeState {
  @override
  List<Object> get props => [];
}

class SummarizeLoaded extends SummarizeState {
  final String summarize;

  const SummarizeLoaded(this.summarize);

  @override
  List<Object> get props => [summarize];
}

class SummarizeError extends SummarizeState {
  final String message;

  const SummarizeError(this.message);

  @override
  List<Object> get props => [message];
}
