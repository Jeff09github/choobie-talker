import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/aws_polly/bloc/aws_polly_bloc.dart';
import 'features/default_stt/bloc/default_stt_bloc.dart';
import 'features/default_tts/bloc/default_tts_bloc.dart';
import 'features/home/cubit/home_cubit.dart';
import 'features/home/home.dart';
import 'features/subtitle/bloc/subtitle_bloc.dart';
import 'features/translator/bloc/translator_bloc.dart';
import 'shared/repository/aws_polly_repo.dart';
import 'shared/repository/translator_repo.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

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
                translatorRepository: context.read<TranslatorRepository>())
              ..add(const AwsPollyInitial())
              ,
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
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
