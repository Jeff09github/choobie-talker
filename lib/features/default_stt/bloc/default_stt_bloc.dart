import 'dart:async';

import 'package:choobietalker/features/aws_polly/bloc/aws_polly_bloc.dart';
import 'package:choobietalker/features/home/cubit/home_cubit.dart';
import 'package:choobietalker/features/subtitle/bloc/subtitle_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../shared/model/text_log.dart';

part 'default_stt_event.dart';
part 'default_stt_state.dart';

class DefaultSttBloc extends Bloc<DefaultSttEvent, DefaultSttState> {
  DefaultSttBloc({
    required this.awsPollyBloc,
    required this.subtitleBloc,
    required this.homeCubit,
  }) : super(const DefaultSttState()) {
    on<DefaultSttInitialize>(_onDefaultSttInitialize);
    on<StartListening>(_onStartListening);
    on<StopListening>(_onStopListening);
    on<ChangedPauseTime>(_onChangedPauseTime);
    on<ToggleLinkTts>(_onToggleLinkTts);
    on<AddTextLog>(_onAddTextLog);
  }

  final AwsPollyBloc awsPollyBloc;
  final SubtitleBloc subtitleBloc;

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

    //////not implemented because it always return 0
    // final localNames = await speechToText.locales();
    // print(localNames.length);

    emit(
      state.copyWith(
        isAvailable: isAvailable,
        speechToText: speechToText,
        // localNames: localNames,
        status: DefaultSttStatus.notListening,
      ),
    );
  }

  FutureOr<void> _onStartListening(
      StartListening event, Emitter<DefaultSttState> emit) async {
    if (state.isAvailable) {
      homeCubit.changeStatus(status: HomeStatus.disabled);
      await state.speechToText!.listen(
        listenMode: ListenMode.dictation,
        onResult: (result) {
          if (result.finalResult) {
            final textLog = TextLog(
                text: result.recognizedWords, createdAt: DateTime.now());
            add(AddTextLog(textLog: textLog));
            if (state.linkTts) {
              awsPollyBloc
                  .add(AwsPollySynthesizeSpeech(text: result.recognizedWords));
            }

            subtitleBloc.add(ChangedSubtitleText(text: result.recognizedWords));
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

  FutureOr<void> _onChangedPauseTime(
      ChangedPauseTime event, Emitter<DefaultSttState> emit) async {
    if (state.status != DefaultSttStatus.listening) {
      emit(state.copyWith(pauseTime: event.value));
    }
  }

  @override
  Future<void> close() async {
    await state.speechToText!.stop();
    return super.close();
  }

  FutureOr<void> _onToggleLinkTts(
      ToggleLinkTts event, Emitter<DefaultSttState> emit) {
    emit(state.copyWith(linkTts: !state.linkTts));
  }

  FutureOr<void> _onAddTextLog(
      AddTextLog event, Emitter<DefaultSttState> emit) {
    emit(
      state.copyWith(
        textlogs: [...state.textlogs, event.textLog],
      ),
    );
  }
}
