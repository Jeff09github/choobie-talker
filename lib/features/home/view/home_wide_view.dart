import 'package:choobietalker/features/default_stt/bloc/default_stt_bloc.dart';
import 'package:choobietalker/features/default_tts/view/default_tts_page.dart';
import 'package:choobietalker/features/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../default_stt/view/default_stt_page.dart';

class HomeWideView extends StatelessWidget {
  const HomeWideView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choobie Talker'),
        centerTitle: true,
      ),
      body: Row(
        children: [
          SelectionView(),
          MainView(),
        ],
      ),
    );
  }

  Widget _btnSection({required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonColumn(
            Colors.green, Colors.greenAccent, Icons.play_arrow, 'PLAY', () {
          // context.read<TextToSpeechBloc>().add(const Speak(
          //     text:
          //         'Please Read This: The End User License Agreement does not allow for commercial use or distribution of audio created using the Ivona™ voices. Please contact support@textaloud.com if you need this.'));
        }),
        _buildButtonColumn(Colors.red, Colors.redAccent, Icons.stop, 'STOP',
            () {
          // context.read<TextToSpeechBloc>().add(const Stop());
        }),
        _buildButtonColumn(
            Colors.blue, Colors.blueAccent, Icons.pause, 'PAUSE', () {}),
      ],
    );
  }

  Column _buildButtonColumn(Color color, Color splashColor, IconData icon,
      String label, Function func) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            icon: Icon(icon),
            color: color,
            splashColor: splashColor,
            onPressed: () => func()),
        Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: Text(label,
                style: TextStyle(
                    fontSize: 12.0, fontWeight: FontWeight.w400, color: color)))
      ],
    );
  }
}

class SelectionView extends StatelessWidget {
  const SelectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.white24,
        child: Column(
          children: [
            ListTile(
              title: Text(
                'Default',
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              title: Text('Default STT'),
              tileColor: context.watch<HomeCubit>().state.selected ==
                      Selected.defaultStt
                  ? Colors.white24
                  : null,
              onTap: () {
                context.read<HomeCubit>().changeSelected(Selected.defaultStt);
              },
            ),
            ListTile(
              title: Text('Default TTS'),
              tileColor: context.watch<HomeCubit>().state.selected ==
                      Selected.defaultTts
                  ? Colors.white24
                  : null,
              onTap:
                  context.watch<HomeCubit>().state.status == HomeStatus.disabled
                      ? null
                      : () {
                          context
                              .read<HomeCubit>()
                              .changeSelected(Selected.defaultTts);
                        },
            ),
            ListTile(
              title: Text(
                'Amazon Polly',
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              title: Text('Amazon Polly STT'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Amazon Polly TTS'),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Google',
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              title: Text('Google STT'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Google TTS'),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Alan',
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              title: Text('Alan STT'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Alan TTS'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.selected == Selected.defaultStt) {
            return const MainViewWidget(
              content: DefaultSttMain(),
              settings: DefaultSttSettings(),
            );
          } else if (state.selected == Selected.defaultTts) {
            return const MainViewWidget(
              content: DefaultTtsMain(),
              settings: DefaultTtsSettings(),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class MainViewWidget extends StatelessWidget {
  const MainViewWidget(
      {Key? key, required this.content, required this.settings})
      : super(key: key);

  final Widget content;
  final Widget settings;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.fromLTRB(8.0, 8.0, 4.0, 8.0),
            padding: EdgeInsets.all(16.0),
            color: Colors.white24,
            child: content,
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            margin: EdgeInsets.fromLTRB(4.0, 8.0, 8.0, 8.0),
            padding: EdgeInsets.all(16.0),
            color: Colors.white24,
            child: settings,
          ),
        ),
      ],
    );
  }
}
