import 'dart:async';
import 'dart:typed_data';

import 'package:aws_polly_api/polly-2016-06-10.dart';
import 'package:choobietalker/shared/repository/aws_polly_repo.dart';
import 'package:choobietalker/shared/repository/translator_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import '../../../shared/byte_source.dart';
import '../../../shared/model/text_log.dart';

part 'aws_polly_event.dart';
part 'aws_polly_state.dart';

class AwsPollyBloc extends Bloc<AwsPollyEvent, AwsPollyState> {
  AwsPollyBloc(
      {required this.awsPollyApiRepo, required this.translatorRepository})
      : super(AwsPollyState(filter: Filter(gender: Gender.male))) {
    on<AwsPollyInitial>(_onAwsPollyInitial);
    on<AwsPollyChangedSelectedVoice>(_onAwsPollyChangedSelectedVoice);
    on<AwsPollyChangedFilter>(_onAwsPollyChangedFilter);
    on<AwsPollyChangedAudioFrequency>(_onAwsPollyChangedAudioFrequency);
    on<AwsPollySynthesizeSpeech>(_onAwsPollySynthesizeSpeech);
    on<AwsPollySpeech>(_onAwsPollySpeech);
    on<AwsPollyChangedPitch>(_onAwsPollyChangedPitch);
    on<AwsPollyChangedTranslation>(_onAwsPollyChangedTranslation);
    on<AwsPollyToggleTranstionOn>(_onAwsPollyToggleTranslationOn);
    on<AwsPollyAddTextLog>(_onAwsPollyAddTextLog);
    on<AwsPollyChangedVoiceVolume>(_onAwsPollyChangedVoiceVolume);
    on<AwsPollyChangedSpeechRate>(_onAwsPollyChangedSpeechRate);
    on<AwsPollyChangedTimbre>(_onAwsPollyChangedTimbre);
  }

  final AwsPollyApiRepo awsPollyApiRepo;
  final TranslatorRepository translatorRepository;

  FutureOr<void> _onAwsPollyInitial(
      AwsPollyInitial event, Emitter<AwsPollyState> emit) async {
    emit(state.copyWith(status: AwsPollyStatus.loading));
    await awsPollyApiRepo.init();
    final voices = await awsPollyApiRepo.getVoices();

    final voice = voices.firstWhere((element) => element.name == 'Justin');
    emit(
      state.copyWith(
          status: AwsPollyStatus.success,
          voices: voices,
          selectedVoice: voice,
          filteredVoices: voices),
    );
  }

  FutureOr<void> _onAwsPollyChangedSelectedVoice(
      AwsPollyChangedSelectedVoice event, Emitter<AwsPollyState> emit) {
    emit(state.copyWith(selectedVoice: event.voice));
  }

  FutureOr<void> _onAwsPollyChangedFilter(
      AwsPollyChangedFilter event, Emitter<AwsPollyState> emit) {
    emit(state.copyWith(status: AwsPollyStatus.loading));
    final filteredVoices = state.voices
        .where((voice) => voice.gender == event.filter.gender)
        .toList();
    emit(state.copyWith(
        filter: event.filter,
        selectedVoice: filteredVoices[0],
        filteredVoices: filteredVoices,
        status: AwsPollyStatus.success));
  }

  FutureOr<void> _onAwsPollyChangedAudioFrequency(
      AwsPollyChangedAudioFrequency event, Emitter<AwsPollyState> emit) {
    emit(state.copyWith(audioFrequency: event.audioFrequency));
  }

  FutureOr<void> _onAwsPollySynthesizeSpeech(
      AwsPollySynthesizeSpeech event, Emitter<AwsPollyState> emit) async {
    String text = event.text;
    if (state.selectedVoice == null) return;
    if (state.translationOn) {
      text = await translatorRepository.translate(
          text: text, languageCode: state.translateTo);
    }
    final String volume = state.voiceVolume >= 0
        ? '+${state.voiceVolume}dB'
        : '${state.voiceVolume}dB';

    String timbre = '';

    if (state.timbre != 0 || state.timbre != -0) {
      timbre = state.timbre > 0
          ? 'vocal-tract-length="+${state.timbre}%"'
          : 'vocal-tract-length="${state.timbre}%"';
    }

    final result = await awsPollyApiRepo.synthesizeSpeech(
      text:
          '<speak><prosody pitch="${state.pitch}%" rate="${state.speechRate}%" volume="$volume"><amazon:effect phonation="soft"  $timbre>$text..</amazon:effect></prosody></speak>',
      voice: state.selectedVoice!,
      sampleRate: state.audioFrequency,
    );
    if (result == null) return;
    final textLog = TextLog(text: text, createdAt: DateTime.now());
    add(AwsPollySpeech(uint8list: result));
    add(AwsPollyAddTextLog(textLog: textLog));
  }

  FutureOr<void> _onAwsPollySpeech(
      AwsPollySpeech event, Emitter<AwsPollyState> emit) async {
    final player = AudioPlayer();
    await player.setAudioSource(MyByteSource(buffer: event.uint8list));
    await player.play();
  }

  FutureOr<void> _onAwsPollyChangedPitch(
      AwsPollyChangedPitch event, Emitter<AwsPollyState> emit) {
    emit(state.copyWith(pitch: event.pitch));
  }

  FutureOr<void> _onAwsPollyChangedTranslation(
      AwsPollyChangedTranslation event, Emitter<AwsPollyState> emit) {
    emit(state.copyWith(translateTo: event.languageCode));
  }

  FutureOr<void> _onAwsPollyToggleTranslationOn(
      AwsPollyToggleTranstionOn event, Emitter<AwsPollyState> emit) {
    emit(state.copyWith(translationOn: !state.translationOn));
  }

  FutureOr<void> _onAwsPollyAddTextLog(
      AwsPollyAddTextLog event, Emitter<AwsPollyState> emit) {
    emit(
      state.copyWith(
        textlogs: [...state.textlogs, event.textLog],
      ),
    );
  }

  FutureOr<void> _onAwsPollyChangedVoiceVolume(
      AwsPollyChangedVoiceVolume event, Emitter<AwsPollyState> emit) {
    emit(state.copyWith(voiceVolume: event.voiceVolume));
  }

  FutureOr<void> _onAwsPollyChangedSpeechRate(
      AwsPollyChangedSpeechRate event, Emitter<AwsPollyState> emit) {
    emit(state.copyWith(speechRate: event.speechRate));
  }

  FutureOr<void> _onAwsPollyChangedTimbre(
      AwsPollyChangedTimbre event, Emitter<AwsPollyState> emit) {
    emit(state.copyWith(timbre: event.timbre));
  }
}
