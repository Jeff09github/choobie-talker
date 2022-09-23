import 'package:translator/translator.dart';

class TranslatorRepository {
  Future<String> translate({required String text,required String languageCode}) async {
    final translator = GoogleTranslator();
    final translation = await translator.translate(text, to: languageCode);
    return translation.text;
  }
}
