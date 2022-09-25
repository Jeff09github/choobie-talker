import 'dart:async';
import 'dart:typed_data';

import 'package:aws_polly_api/polly-2016-06-10.dart';
import 'package:choobietalker/shared/repository/aws_polly_repo.dart';
import 'package:choobietalker/shared/repository/translator_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import '../../../shared/byte_source.dart';

part 'aws_polly_event.dart';
part 'aws_polly_state.dart';

class AwsPollyBloc extends Bloc<AwsPollyEvent, AwsPollyState> {
  AwsPollyBloc(
      {required this.awsPollyApiRepo, required this.translatorRepository})
      : super(AwsPollyState(filter: Filter(gender: Gender.male))) {
    on<AwsPollyInitial>(_onAwsPollyInitial);
    on<AwsPollyChangedSelectedVoice>(_onAwsPollyChangedSelectedVoice);
    on<AwsPollyChangedFilter>(_onAwsPollyChangedFilter);
    on<AwsPollyChangedSampleRate>(_onAwsPollyChangedSampleRate);
    on<AwsPollySynthesizeSpeech>(_onAwsPollySynthesizeSpeech);
    on<AwsPollySpeech>(_onAwsPollySpeech);
    on<AwsPollyChangedPitch>(_onAwsPollyChangedPitch);
    on<AwsPollyChangedTranslation>(_onAwsPollyChangedTranslation);
    on<AwsPollyToggleTranstionOn>(_onAwsPollyToggleTranslationOn);
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

  FutureOr<void> _onAwsPollyChangedSampleRate(
      AwsPollyChangedSampleRate event, Emitter<AwsPollyState> emit) {
    emit(state.copyWith(sampleRate: event.sampleRate));
  }

  FutureOr<void> _onAwsPollySynthesizeSpeech(
      AwsPollySynthesizeSpeech event, Emitter<AwsPollyState> emit) async {
    String text = event.text;
    if (state.selectedVoice == null) return;
    if (state.translationOn) {
      text = await translatorRepository.translate(
          text: text, languageCode: state.translateTo);
    }
    final result = await awsPollyApiRepo.synthesizeSpeech(
      text:
          '<speak><prosody pitch="${state.pitch}%">$text.</prosody></speak>',
      voice: state.selectedVoice!,
      sampleRate: state.sampleRate,
    );
    if (result == null) return;
    add(AwsPollySpeech(uint8list: result));
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
}
