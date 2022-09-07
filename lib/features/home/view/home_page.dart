import 'package:choobietalker/features/default_stt/bloc/default_stt_bloc.dart';
import 'package:choobietalker/features/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;
    final targetPlatform = Theme.of(context).platform;

    if (targetPlatform == TargetPlatform.android ||
        targetPlatform == TargetPlatform.iOS ||
        screenWidth <= 600) {
      return const HomeNarrowView();
    } else {
      return const HomeWideView();
    }
  }
}
