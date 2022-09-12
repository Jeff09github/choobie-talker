import 'dart:typed_data';
import 'package:just_audio/just_audio.dart';

class MyByteSource extends StreamAudioSource {
  MyByteSource({required this.buffer});

  final Uint8List buffer;

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    return StreamAudioResponse(
      sourceLength: buffer.length,
      contentLength: (start ?? 0) - (end ?? buffer.length),
      offset: start ?? 0,
      stream: Stream.fromIterable([buffer.sublist(start ?? 0, end)]),
      contentType: 'audio/mpeg',
    );
  }
}
