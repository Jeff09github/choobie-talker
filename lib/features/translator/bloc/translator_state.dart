part of 'translator_bloc.dart';

class TranslatorState extends Equatable {
  const TranslatorState({
    this.translatedText = '',
  });

  final String translatedText;

  TranslatorState copyWith({String? translatedText}) => TranslatorState(
        translatedText: translatedText ?? this.translatedText,
      );

  @override
  List<Object> get props => [translatedText];
}
