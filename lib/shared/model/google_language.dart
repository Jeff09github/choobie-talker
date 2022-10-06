class GoogleLanguage {
  GoogleLanguage({required this.name, required this.code});
  final String name;
  final String code;

  factory GoogleLanguage.fromJson(Map<String, String> json) {
    return GoogleLanguage(name: json['name']!, code: json['code']!);
  }
}
