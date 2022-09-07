import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';

part 'default_tts_event.dart';
part 'default_tts_state.dart';

class DefaultTtsBloc extends Bloc<DefaultTtsEvent, DefaultTtsState> {
  DefaultTtsBloc() : super(const DefaultTtsState()) {
    on<DefaultTtsInitialize>(_onDefaultTtsInitialize);
    on<PlayButtonTap>(_onPlayButtonTap);
    on<StopButtonTap>(_onStopButtonTap);
    on<ChangedLanguage>(_onChangedLanguage);
    on<ChangedVolume>(_onChangedVolume);
    on<ChangedPitch>(_onChangedPitch);
    on<ChangedRate>(_onChangedRate);
    on<ChangedVoiceText>(_onChangeVoiceText);
  }

  FutureOr<void> _onDefaultTtsInitialize(
      DefaultTtsInitialize event, Emitter<DefaultTtsState> emit) async {
    FlutterTts? flutterTts = state.fluterTts;
    flutterTts ??= FlutterTts();

    // await flutterTts.setLanguage(state.language);
    final languages = await flutterTts.getLanguages;
    final language = languages[0] as String;
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.setPitch(state.pitch);
    await flutterTts.setVolume(state.volume);
    await flutterTts.setSpeechRate(state.rate);

    emit(state.copyWith(
        fluterTts: flutterTts,
        languages: languages,
        language: language,
        status: DefaultTtsStatus.stopped));
  }

  FutureOr<void> _onPlayButtonTap(
      PlayButtonTap event, Emitter<DefaultTtsState> emit) async {
    emit(state.copyWith(status: DefaultTtsStatus.playing));
    await state.fluterTts!.speak(event.voiceText ?? state.voiceText ?? '');
    emit(state.copyWith(status: DefaultTtsStatus.stopped));
  }

  FutureOr<void> _onStopButtonTap(
      StopButtonTap event, Emitter<DefaultTtsState> emit) async {
    await state.fluterTts!.stop();
    emit(state.copyWith(status: DefaultTtsStatus.stopped));
  }

  FutureOr<void> _onChangedLanguage(
      ChangedLanguage event, Emitter<DefaultTtsState> emit) async {
    if (state.status == DefaultTtsStatus.stopped) {
      await state.fluterTts!.setLanguage(event.language);
      emit(state.copyWith(language: event.language));
    }
  }

  FutureOr<void> _onChangedVolume(
      ChangedVolume event, Emitter<DefaultTtsState> emit) async {
    if (state.status == DefaultTtsStatus.stopped) {
      await state.fluterTts!.setVolume(event.value);
      emit(state.copyWith(volume: event.value));
    }
  }

  FutureOr<void> _onChangedPitch(
      ChangedPitch event, Emitter<DefaultTtsState> emit) async {
    if (state.status == DefaultTtsStatus.stopped) {
      await state.fluterTts!.setPitch(event.value);
      emit(state.copyWith(pitch: event.value));
    }
  }

  FutureOr<void> _onChangedRate(
      ChangedRate event, Emitter<DefaultTtsState> emit) async {
    if (state.status == DefaultTtsStatus.stopped) {
      await state.fluterTts!.setSpeechRate(event.value);
      emit(state.copyWith(rate: event.value));
    }
  }

  FutureOr<void> _onChangeVoiceText(
      ChangedVoiceText event, Emitter<DefaultTtsState> emit) async {
    emit(state.copyWith(voiceText: event.value));
  }
}
