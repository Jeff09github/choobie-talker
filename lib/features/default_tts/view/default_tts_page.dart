import 'package:choobietalker/features/default_tts/bloc/default_tts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DefaultTtsMain extends StatefulWidget {
  const DefaultTtsMain({Key? key}) : super(key: key);

  @override
  State<DefaultTtsMain> createState() => _DefaultTtsMainState();
}

class _DefaultTtsMainState extends State<DefaultTtsMain> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.read<DefaultTtsBloc>().state;
    return Column(
      children: [
        SizedBox(
          height: 8.0,
        ),
        TextFormField(
          // controller: _controller,
          maxLines: 8,
          decoration: InputDecoration(
            hintText: 'enter a sentence',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            context.read<DefaultTtsBloc>().add(ChangedVoiceText(value: value));
          },
        ),
        SizedBox(
          height: 8.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                print(context.read<DefaultTtsBloc>().state.voiceText);
                context.read<DefaultTtsBloc>().add(const PlayButtonTap());
              },
              icon: Icon(Icons.play_arrow),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.pause),
            ),
            IconButton(
              onPressed: () {
                context.read<DefaultTtsBloc>().add(const StopButtonTap());
              },
              icon: Icon(Icons.stop),
            )
          ],
        ),
      ],
    );
  }
}

class DefaultTtsSettings extends StatelessWidget {
  const DefaultTtsSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final state = context.read<DefaultTtsBloc>().state;
    // final language = context.watch<DefaultTtsBloc>().state.language;

    return BlocBuilder<DefaultTtsBloc, DefaultTtsState>(
      builder: (context, state) {
        return Column(
          children: [
            Text(
              'SETTINGS',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 8.0,
            ),
            Row(
              children: [
                Text('Language: '),
                DropdownButton(
                  value: state.language,
                  items: dropDrownMenuItems(state.languages),
                  onChanged: (value) {
                    context
                        .read<DefaultTtsBloc>()
                        .add(ChangedLanguage(language: value as String));
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text('Volume: '),
                Slider(
                  value: state.volume,
                  min: 0.0,
                  max: 1.0,
                  divisions: 10,
                  onChanged: (value) {
                    context
                        .read<DefaultTtsBloc>()
                        .add(ChangedVolume(value: value));
                  },
                ),
                Text(' ${state.volume}'),
              ],
            ),
            Row(
              children: [
                Text('Pitch: '),
                Slider(
                  value: state.pitch,
                  min: 0.5,
                  max: 2.0,
                  divisions: 15,
                  onChanged: (value) {
                    context
                        .read<DefaultTtsBloc>()
                        .add(ChangedPitch(value: value));
                  },
                ),
                Text(' ${state.pitch.toStringAsFixed(1)}'),
              ],
            ),
            Row(
              children: [
                Text('Speech Rate: '),
                Slider(
                  value: state.rate,
                  min: 0.0,
                  max: 1.0,
                  divisions: 10,
                  onChanged: (value) {
                    context
                        .read<DefaultTtsBloc>()
                        .add(ChangedRate(value: value));
                  },
                ),
                Text(' ${state.rate}'),
              ],
            )
          ],
        );
      },
    );
  }

  List<DropdownMenuItem<String>> dropDrownMenuItems(dynamic languages) {
    final items = <DropdownMenuItem<String>>[];

    for (dynamic item in languages) {
      items.add(
        DropdownMenuItem(
          value: item as String?,
          child: Text(
            item as String,
          ),
        ),
      );
    }
    return items;
  }
}
