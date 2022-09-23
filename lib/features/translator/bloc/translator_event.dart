part of 'translator_bloc.dart';

abstract class TranslatorEvent extends Equatable {
  const TranslatorEvent();

  @override
  List<Object> get props => [];
}

class TranslateText extends TranslatorEvent {
  const TranslateText({required this.text, required this.to});
  final String text;
  final String to;
  @override
  List<Object> get props => [text, to];
}
