import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'subtitle_event.dart';
part 'subtitle_state.dart';

class SubtitleBloc extends Bloc<SubtitleEvent, SubtitleState> {
  SubtitleBloc() : super(const SubtitleState()) {
    on<ChangedContainerHeight>(_onChangedContainerHeight);
    on<ChangedFontSize>(_onChangedFontSize);
  }

  FutureOr<void> _onChangedContainerHeight(
      ChangedContainerHeight event, Emitter<SubtitleState> emit) {
    emit(state.copyWith(containerHeight: event.height));
  }

  FutureOr<void> _onChangedFontSize(
      ChangedFontSize event, Emitter<SubtitleState> emit) {
    emit(state.copyWith(fontSize: event.size));
  }
}
