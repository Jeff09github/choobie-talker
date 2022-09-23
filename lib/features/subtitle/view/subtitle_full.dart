import 'package:choobietalker/features/subtitle/bloc/subtitle_bloc.dart';
import 'package:choobietalker/features/subtitle/subtitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubtitleFull extends StatelessWidget {
  const SubtitleFull({Key? key, required this.contextWithBloc})
      : super(key: key);

  final BuildContext contextWithBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => contextWithBloc.read<SubtitleBloc>(),
      child: const Scaffold(
        body: SubtitlePage(),
      ),
    );
  }
}
