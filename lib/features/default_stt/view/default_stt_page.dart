import 'package:choobietalker/features/default_stt/bloc/default_stt_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/widgets/custom_container.dart';

class DefaultSttMic extends StatelessWidget {
  const DefaultSttMic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 48.0,
      onPressed: () {
        context.watch<DefaultSttBloc>().state.status ==
                DefaultSttStatus.listening
            ? context.read<DefaultSttBloc>().add(const StopListening())
            : context.read<DefaultSttBloc>().add(const StartListening());
      },
      icon: Icon(
        Icons.mic,
        color: context.watch<DefaultSttBloc>().state.status ==
                DefaultSttStatus.listening
            ? Colors.redAccent
            : null,
      ),
    );

    // return Column(
    //   children: [
    //     SizedBox(
    //       height: 8.0,
    //     ),
    //     SizedBox(
    //       height: 8.0,
    //     ),
    //     IconButton(
    //       onPressed: () {
    //         state.status == DefaultSttStatus.listening
    //             ? context.read<DefaultSttBloc>().add(const StopListening())
    //             : context.read<DefaultSttBloc>().add(const StartListening());
    //       },
    //       icon: Icon(
    //         Icons.mic,
    //         color: state.status == DefaultSttStatus.listening
    //             ? Colors.redAccent
    //             : null,
    //       ),
    //     ),
    //   ],
    // );
  }
}

class DefaultSttSettings extends StatelessWidget {
  const DefaultSttSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DefaultSttBloc>().state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SPEECH TO TEXT',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        Divider(
          thickness: 3.0,
        ),
        SizedBox(
          height: 8.0,
        ),
        Row(
          children: [
            Text(' Pause Time '),
            Tooltip(
              child: CustomContainer(
                radius: 0.0,
                boxShape: BoxShape.circle,
                child: Text(
                  '!',
                  // style: TextStyle(color: Colors.redAccent),
                ),
              ),
              message:
                  'Sets the maximum duration of a pause in speech with no words detected, after that it automatically restart the listener.',
            ),
          ],
        ),
        Row(
          children: [
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
            Text(state.pauseTime.toStringAsFixed(1)),
          ],
        ),
        // SizedBox(
        //   height: 8.0,
        // ),
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: Colors.white,
                ),
              ),
              child: Text('Text to Speech'),
            ),
            Switch(
              value: state.linkTts,
              onChanged: (value) {
                context.read<DefaultSttBloc>().add(const ToggleLinkTts());
              },
            ),
            state.linkTts ? const Text('ON') : const Text('OFF'),
          ],
        ),
        SizedBox(
          height: 8.0,
        ),
      ],
    );
  }
}
