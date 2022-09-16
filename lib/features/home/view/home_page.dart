import 'package:choobietalker/features/aws_polly/bloc/aws_polly_bloc.dart';
import 'package:choobietalker/features/default_stt/bloc/default_stt_bloc.dart';
import 'package:choobietalker/features/default_stt/default_stt.dart';
import 'package:choobietalker/features/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/repository/aws_polly_repo.dart';
import '../../aws_polly/aws_polly.dart';
import '../../default_tts/bloc/default_tts_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AwsPollyApiRepo(),
        ),
      ],
      child: MultiBlocProvider(
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
            create: (context) => AwsPollyBloc(
              awsPollyApiRepo: context.read<AwsPollyApiRepo>(),
            )..add(const AwsPollyInitial()),
            lazy: false,
          ),
          BlocProvider(
            create: (context) => DefaultSttBloc(
              homeCubit: context.read<HomeCubit>(),
              awsPollyBloc: context.read<AwsPollyBloc>(),
            )..add(const DefaultSttInitialize()),
          ),
        ],
        child: const HomeView(),
      ),
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
              color: Colors.green,
              child: TextFormField(
                textAlign: TextAlign.center,
                enabled: false,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: context.watch<DefaultSttBloc>().state.lastHeard,
                  hintStyle: TextStyle(fontSize: 24.0, color: Colors.white),
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
