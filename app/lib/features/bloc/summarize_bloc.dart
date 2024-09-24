import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../services/api_service.dart';

part 'summarize_event.dart';
part 'summarize_state.dart';

class SummarizeBloc extends Bloc<SummarizeEvent, SummarizeState> {
  final ApiService _apiService = GetIt.I<ApiService>();

  SummarizeBloc() : super(SummarizeInitial()) {
    on<SendYoutubeUrl>(_onYoutubeUrlSend);
  }

  _onYoutubeUrlSend(SendYoutubeUrl event, Emitter<SummarizeState> emit) async {
    try {
      emit(SummarizeLoading());
      final summarize = await _apiService.fetchSubtitles(event.text);
      print('SummarizeBloc: $summarize');
      emit(SummarizeLoaded(summarize));
    } catch (e) {
      emit(SummarizeError(e.toString()));
    }
  }
}
