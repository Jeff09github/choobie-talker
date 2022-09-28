import 'package:intl/intl.dart';

class TextLog {
  TextLog({required this.text, required this.createdAt});
  final String text;
  final DateTime createdAt;

  @override
  String toString() {
    return '${DateFormat.Hm().format(createdAt).toString()} - $text';
  }
}
