import 'package:choobietalker/features/aws_polly/bloc/aws_polly_bloc.dart';
import 'package:choobietalker/features/default_stt/bloc/default_stt_bloc.dart';
import 'package:choobietalker/features/default_stt/default_stt.dart';
import 'package:choobietalker/features/home/cubit/home_cubit.dart';
import 'package:choobietalker/features/subtitle/bloc/subtitle_bloc.dart';
import 'package:choobietalker/features/translator/bloc/translator_bloc.dart';
import 'package:choobietalker/shared/repository/translator_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/repository/aws_polly_repo.dart';
import '../../aws_polly/aws_polly.dart';
import '../../default_tts/bloc/default_tts_bloc.dart';
import '../../subtitle/subtitle.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AwsPollyApiRepo(),
        ),
        RepositoryProvider(
          create: (context) => TranslatorRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeCubit(),
          ),
          BlocProvider(
            create: (context) => TranslatorBloc(),
          ),
          BlocProvider(
            create: (context) =>
                DefaultTtsBloc()..add(const DefaultTtsInitialize()),
            lazy: false,
          ),
          BlocProvider(
            create: (context) => AwsPollyBloc(
              awsPollyApiRepo: context.read<AwsPollyApiRepo>(),
            ),
            // ..add(const AwsPollyInitial()),
            lazy: false,
          ),
          BlocProvider(
            create: (context) => SubtitleBloc(
              awsPollyBloc: context.read<AwsPollyBloc>(),
              translatorRepository: context.read<TranslatorRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => DefaultSttBloc(
              homeCubit: context.read<HomeCubit>(),
              subtitleBloc: context.read<SubtitleBloc>(),
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
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Choobie Speech'),
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
                // const SubtitleSettings(),
                const SubtitlePage(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
          SizedBox(
            height: 24.0,
          ),
          SubtitleSettings(),
        ],
      ),
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
