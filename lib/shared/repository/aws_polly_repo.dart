import 'dart:async';
import 'dart:typed_data';

import 'package:aws_polly_api/polly-2016-06-10.dart';

class AwsPollyApiRepo {
  late Polly _polly;

  FutureOr<void> init() {
    _polly = Polly(
      region: 'ap-southeast-1',
      credentials: AwsClientCredentials(
        accessKey: 'AKIASLQQZUY6MHZAOAEJ',
        secretKey: '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',
      ),
    );
  }

  Future<List<Voice>> getVoices() async {
    final voices = await _polly.describeVoices(
      engine: Engine.standard,
    );
    return voices.voices ?? [];
  }

  Future<Uint8List?> synthesizeSpeech(
      {required String text, required Voice voice, String? sampleRate}) async {
    final output = await _polly.synthesizeSpeech(
      outputFormat: OutputFormat.mp3,
      text: text,
      sampleRate: sampleRate,
      voiceId: voice.id!,
    );
    return output.audioStream;
  }

}
