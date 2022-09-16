import 'package:choobietalker/features/default_stt/bloc/default_stt_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DefaultSttMain extends StatelessWidget {
  const DefaultSttMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DefaultSttBloc>().state;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            SizedBox(
              height: 8.0,
            ),
            TextFormField(
              maxLines: 15,
              readOnly: true,
              decoration: InputDecoration(
                hintText: context
                    .watch<DefaultSttBloc>()
                    .state
                    .recognizedWords
                    .toString(),
                hintStyle: TextStyle(fontSize: 8.0),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            IconButton(
              onPressed: () {
                state.status == DefaultSttStatus.listening
                    ? context.read<DefaultSttBloc>().add(const StopListening())
                    : context
                        .read<DefaultSttBloc>()
                        .add(const StartListening());
              },
              icon: Icon(
                Icons.mic,
                color: state.status == DefaultSttStatus.listening
                    ? Colors.redAccent
                    : null,
              ),
            ),
          ],
        ),
        // state.isSubtitleOn
        //     ? Container(
        //         padding: EdgeInsets.all(8.0),
        //         height: 130.0,
        //         color: Colors.green,
        //         alignment: Alignment.center,
        //         child: Text(
        //           state.lastHeard,
        //           textAlign: TextAlign.center,
        //           style: TextStyle(
        //             fontSize: 24.0,
        //           ),
        //         ),
        //       )
        //     : SizedBox(),
      ],
    );
  }
}

class DefaultSttSettings extends StatelessWidget {
  const DefaultSttSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DefaultSttBloc>().state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('SPEECH TO TEXT'),
        Divider(),
        SizedBox(
          height: 8.0,
        ),
        Text(
            'Note: sets the maximum duration of a pause in speech with no words detected, after that it automatically restart the listener.'),
        Row(
          children: [
            Text('Pause Time'),
            Slider(
              value: state.pauseTime,
              onChanged: (value) {
                context
                    .read<DefaultSttBloc>()
                    .add(ChangedPauseTime(value: value));
              },
              min: 1,
              max: 3,
            ),
            Text(' ${state.pauseTime.toStringAsFixed(1)}'),
          ],
        ),
        SizedBox(
          height: 8.0,
        ),
        // Row(
        //   children: [
        //     Text('Select Locale'),
        //     SizedBox(
        //       width: 8.0,
        //     ),
        //     DropdownButton(
        //         items: state.localNames
        //             .map(
        //               (e) => DropdownMenuItem(
        //                 value: e,
        //                 child: Text(e.name),
        //               ),
        //             )
        //             .toList(),
        //         onChanged: (newValue) {}),
        //   ],
        // ),
        Row(
          children: [
            Text('TTS to Link'),
            SizedBox(
              width: 8.0,
            ),
            DropdownButton(
                value: 'AWS Polly',
                items: <String>['AWS Polly']
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ),
                    )
                    .toList(),
                onChanged: (value) {}),
          ],
        ),
        Row(
          children: [
            Text('Enable Link TTS'),
            Switch(value: true, onChanged: (value) {}),
          ],
        ),
      ],
    );
  }
}
