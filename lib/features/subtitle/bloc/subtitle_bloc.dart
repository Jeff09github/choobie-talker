import 'dart:async';
import 'package:choobietalker/features/aws_polly/bloc/aws_polly_bloc.dart';
import 'package:choobietalker/features/translator/bloc/translator_bloc.dart';
import 'package:choobietalker/shared/model/google_language.dart';
import 'package:choobietalker/shared/repository/translator_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'subtitle_event.dart';
part 'subtitle_state.dart';

class SubtitleBloc extends Bloc<SubtitleEvent, SubtitleState> {
  SubtitleBloc({required this.awsPollyBloc, required this.translatorRepository})
      : super(const SubtitleState()) {
    on<ChangedContainerHeight>(_onChangedContainerHeight);
    on<ChangedFontFamily>(_onChangedFontFamily);
    on<ChangedFontWeight>(_onChangedFontWeight);
    on<ChangedFontSize>(_onChangedFontSize);
    on<ChangedFontColor>(_onChangedFontColor);
    on<ChangedStrokeColor>(_onChangedStrokeColor);
    on<ChangedBackgroundColor>(_onChangedBackgroundColor);
    on<ChangedStrokeWidth>(_onChangedStrokeWidth);
    on<ChangedSubtitleText>(_onChangedSubtitleText);
    on<ChangedTranslateTo>(_onChangedTranslationTo);
    on<ToggleTranstionOn>(_onToggleTranslationOn);
  }

  final AwsPollyBloc awsPollyBloc;

  final TranslatorRepository translatorRepository;

  FutureOr<void> _onChangedContainerHeight(
      ChangedContainerHeight event, Emitter<SubtitleState> emit) {
    emit(state.copyWith(containerHeight: event.height));
  }

  FutureOr<void> _onChangedFontSize(
      ChangedFontSize event, Emitter<SubtitleState> emit) {
    emit(state.copyWith(fontSize: event.size));
  }

  FutureOr<void> _onChangedSubtitleText(
      ChangedSubtitleText event, Emitter<SubtitleState> emit) async {
    String text = event.text;

    if (state.translateOn) {
      text = await translatorRepository.translate(
          text: text, languageCode: state.translateTo);
    }
    emit(state.copyWith(text: text));
  }

  FutureOr<void> _onChangedFontColor(
      ChangedFontColor event, Emitter<SubtitleState> emit) {
    emit(state.copyWith(fontColor: event.fontColor));
  }

  FutureOr<void> _onChangedStrokeColor(
      ChangedStrokeColor event, Emitter<SubtitleState> emit) {
    emit(state.copyWith(strokeColor: event.strokeColor));
  }

  FutureOr<void> _onChangedStrokeWidth(
      ChangedStrokeWidth event, Emitter<SubtitleState> emit) {
    emit(state.copyWith(strokeWidth: event.strokeWidth));
  }

  FutureOr<void> _onChangedBackgroundColor(
      ChangedBackgroundColor event, Emitter<SubtitleState> emit) {
    emit(state.copyWith(backgroundColor: event.backgroundColor));
  }

  FutureOr<void> _onChangedFontFamily(
      ChangedFontFamily event, Emitter<SubtitleState> emit) {
    emit(state.copyWith(fontFamily: event.fontFamily));
  }

  FutureOr<void> _onChangedFontWeight(
      ChangedFontWeight event, Emitter<SubtitleState> emit) {
    emit(state.copyWith(fontWeight: event.fontWeight));
  }

  FutureOr<void> _onChangedTranslationTo(
      ChangedTranslateTo event, Emitter<SubtitleState> emit) {
    emit(state.copyWith(translateTo: event.code));
  }

  FutureOr<void> _onToggleTranslationOn(
      ToggleTranstionOn event, Emitter<SubtitleState> emit) {
    emit(state.copyWith(translateOn: !state.translateOn));
  }
}
