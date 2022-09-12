import 'package:choobietalker/features/default_stt/bloc/default_stt_bloc.dart';
import 'package:choobietalker/features/default_stt/default_stt.dart';
import 'package:choobietalker/features/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../aws_polly/aws_polly.dart';
import '../../default_tts/bloc/default_tts_bloc.dart';
import 'home_narrow_view.dart';
import 'home_wide_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) =>
              DefaultTtsBloc()..add(const DefaultTtsInitialize()),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => DefaultSttBloc(
            homeCubit: context.read<HomeCubit>(),
            defaultTtsBloc: context.read<DefaultTtsBloc>(),
          )..add(const DefaultSttInitialize()),
        ),
      ],
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choobie Talker'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: MainView(),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Card(
                      child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: SettingsView()),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              child: TextFormField(
                textAlign: TextAlign.center,
                enabled: false,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Subtitle',
                  hintStyle: TextStyle(fontSize: 24.0),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DefaultSttBloc>().state;
    return Column(
      children: [
        Text('SETTINGS'),
        SizedBox(
          height: 24.0,
        ),
        DefaultSttSettings(),
        SizedBox(
          height: 24.0,
        ),
        AwsPollySettings(),
      ],
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultSttMain();
  }
}
