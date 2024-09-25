import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../services/api_service.dart';

part 'summarize_event.dart';
part 'summarize_state.dart';

class SummarizeBloc extends Bloc<SummarizeEvent, SummarizeState> {
  final ApiService _apiService = GetIt.I<ApiService>();

  SummarizeBloc() : super(SummarizeInitial()) {
    on<SendUrl>(_onUrlSend);
  }

  _onUrlSend(SendUrl event, Emitter<SummarizeState> emit) async {
    try {
      String summarize = '';
      emit(SummarizeLoading());
      if (event.text.contains('youtube.com')) {
        summarize = await _apiService.summarizeYoutube(url: event.text, apiKey: event.apiKey);
      } else {
        summarize = await _apiService.summarizeWebsite(url: event.text, apiKey: event.apiKey);
      }
      emit(SummarizeLoaded(summarize));
    } catch (e) {
      emit(SummarizeError(e.toString()));
    }
  }
}
