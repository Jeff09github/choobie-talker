import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/translator.dart';

part 'translator_event.dart';
part 'translator_state.dart';

class TranslatorBloc extends Bloc<TranslatorEvent, TranslatorState> {
  TranslatorBloc() : super(const TranslatorState()) {
    on<TranslateText>(_onTranslateText);
  }

  FutureOr<void> _onTranslateText(
      TranslateText event, Emitter<TranslatorState> emit) async {
    final translator = GoogleTranslator();
    final translation = await translator.translate(event.text, to: event.to);
    emit(state.copyWith(translatedText: translation.text));
  }
}
