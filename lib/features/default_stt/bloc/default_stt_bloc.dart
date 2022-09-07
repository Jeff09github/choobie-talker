import 'dart:async';

import 'package:choobietalker/features/home/cubit/home_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../default_tts/bloc/default_tts_bloc.dart';

part 'default_stt_event.dart';
part 'default_stt_state.dart';

class DefaultSttBloc extends Bloc<DefaultSttEvent, DefaultSttState> {
  DefaultSttBloc({
    required this.defaultTtsBloc,
    required this.homeCubit,
  }) : super(const DefaultSttState()) {
    on<DefaultSttInitialize>(_onDefaultSttInitialize);
    on<StartListening>(_onStartListening);
    on<StopListening>(_onStopListening);
    on<LastHeardChanged>(_onLastHeardChanged);
    on<ChangedSubtitleIsOn>(_onChangedSubtitleIsOn);
    on<ChangedPauseTime>(_onChangedPauseTime);
    on<ChangedRecognizedWords>(_onChangeRecognizedWords);
  }

  final DefaultTtsBloc defaultTtsBloc;

  ///// Changed => UpdateStatus ? so i need one event for all changed value

  final HomeCubit homeCubit;

  FutureOr<void> _onDefaultSttInitialize(
      DefaultSttInitialize event, Emitter<DefaultSttState> emit) async {
    print('on default initialize');
    SpeechToText? speechToText = state.speechToText;
    speechToText ??= SpeechToText();

    emit(state.copyWith(status: DefaultSttStatus.loading));

    final isAvailable = await speechToText.initialize(
      onStatus: (status) {
        if (status == 'done' && state.status != DefaultSttStatus.off) {
          add(const StartListening());
        }
      },
      onError: ((errorNotification) {
        print(errorNotification.errorMsg);
        emit(state.copyWith(status: DefaultSttStatus.error));
      }),
      debugLogging: true,
    );

    emit(state.copyWith(
      isAvailable: isAvailable,
      speechToText: speechToText,
      status: DefaultSttStatus.notListening,
    ));
  }

  FutureOr<void> _onStartListening(
      StartListening event, Emitter<DefaultSttState> emit) async {
    if (state.isAvailable) {
      homeCubit.changeStatus(status: HomeStatus.disabled);
      await state.speechToText!.listen(
        onResult: (result) {
          add(ChangedRecognizedWords(words: result.recognizedWords));
          if (result.finalResult) {
            add(LastHeardChanged(lastHeard: result.recognizedWords));
            defaultTtsBloc
                .add(PlayButtonTap(voiceText: result.recognizedWords));
          }
        },
        pauseFor: Duration(milliseconds: (state.pauseTime * 1000).round()),
        cancelOnError: true,
      );
      emit(state.copyWith(status: DefaultSttStatus.listening));
    } else {
      emit(state.copyWith(status: DefaultSttStatus.off));
    }
  }

  FutureOr<void> _onStopListening(
      StopListening event, Emitter<DefaultSttState> emit) async {
    await state.speechToText!.cancel();
    homeCubit.changeStatus(status: HomeStatus.success);
    emit(state.copyWith(status: DefaultSttStatus.off));
  }

  FutureOr<void> _onLastHeardChanged(
      LastHeardChanged event, Emitter<DefaultSttState> emit) {
    emit(state.copyWith(
      status: DefaultSttStatus.done,
      lastHeard: event.lastHeard,
      recognizedWords: 'Speech Log',
    ));
  }

  FutureOr<void> _onChangeRecognizedWords(
      ChangedRecognizedWords event, Emitter<DefaultSttState> emit) {
    StringBuffer totalHeard = StringBuffer();
    totalHeard.write(state.recognizedWords);
    totalHeard.write('\n');
    totalHeard.write(event.words);

    emit(state.copyWith(recognizedWords: totalHeard.toString()));
  }

  FutureOr<void> _onChangedSubtitleIsOn(
      ChangedSubtitleIsOn event, Emitter<DefaultSttState> emit) {
    emit(state.copyWith(isSubtitleOn: event.value));
  }

  FutureOr<void> _onChangedPauseTime(
      ChangedPauseTime event, Emitter<DefaultSttState> emit) async {
    emit(state.copyWith(pauseTime: event.value));
  }

  @override
  Future<void> close() async {
    print('default stt bloc close call');
    await state.speechToText!.stop();
    return super.close();
  }
}
