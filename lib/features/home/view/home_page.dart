import 'package:choobietalker/features/aws_polly/bloc/aws_polly_bloc.dart';
import 'package:choobietalker/features/default_stt/bloc/default_stt_bloc.dart';
import 'package:choobietalker/features/default_stt/default_stt.dart';
import 'package:choobietalker/features/home/cubit/home_cubit.dart';
import 'package:choobietalker/features/subtitle/bloc/subtitle_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../aws_polly/aws_polly.dart';
import '../../subtitle/subtitle.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomeView();
    // return MultiRepositoryProvider(
    //   providers: [
    //     RepositoryProvider(
    //       create: (context) => AwsPollyApiRepo(),
    //     ),
    //     RepositoryProvider(
    //       create: (context) => TranslatorRepository(),
    //     ),
    //   ],
    //   child: MultiBlocProvider(
    //     providers: [
    //       BlocProvider(
    //         create: (context) => HomeCubit(),
    //       ),
    //       BlocProvider(
    //         create: (context) => TranslatorBloc(),
    //       ),
    //       BlocProvider(
    //         create: (context) =>
    //             DefaultTtsBloc()..add(const DefaultTtsInitialize()),
    //         lazy: false,
    //       ),
    //       BlocProvider(
    //         create: (context) => AwsPollyBloc(
    //             awsPollyApiRepo: context.read<AwsPollyApiRepo>(),
    //             translatorRepository: context.read<TranslatorRepository>()),
    //         // ..add(const AwsPollyInitial()),
    //         lazy: false,
    //       ),
    //       BlocProvider(
    //         create: (context) => SubtitleBloc(
    //           awsPollyBloc: context.read<AwsPollyBloc>(),
    //           translatorRepository: context.read<TranslatorRepository>(),
    //         ),
    //       ),
    //       BlocProvider(
    //         create: (context) => DefaultSttBloc(
    //           homeCubit: context.read<HomeCubit>(),
    //           subtitleBloc: context.read<SubtitleBloc>(),
    //           awsPollyBloc: context.read<AwsPollyBloc>(),
    //         )..add(const DefaultSttInitialize()),
    //       ),
    //     ],
    //     child: const HomeView(),
    //   ),
    // );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: state.showSubtitleOnly
              ? null
              : AppBar(
                  title: const Text('Choobie Speech'),
                  centerTitle: true,
                ),
          body: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                if (state.showSubtitleOnly == false)
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
                Stack(children: [
                  const SubtitlePage(),
                  Positioned(
                    right: 0.0,
                    top: 0.0,
                    child: IconButton(
                      color: Colors.white,
                      iconSize: 60.0,
                      icon: state.showSubtitleOnly
                          ? const Icon(Icons.keyboard_arrow_down)
                          : const Icon(Icons.keyboard_arrow_up),
                      tooltip: 'Tap to show subtitle only',
                      onPressed: () {
                        context.read<HomeCubit>().toggleShowSubtitleOnly();
                      },
                    ),
                  ),
                ]),
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
    final ScrollController scrollController = ScrollController();
    return Scrollbar(
      thumbVisibility: true,
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            Text(
              'SETTINGS',
              style: TextStyle(fontSize: 24.0),
            ),
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
      ),
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: BlocBuilder<DefaultSttBloc, DefaultSttState>(
                  builder: (context, state) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 16.0, right: 16.0),
                      padding: EdgeInsets.all(8.0),
                      constraints: BoxConstraints.expand(),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Speech to Text Log'),
                            Divider(),
                            SizedBox(
                              height: 8.0,
                            ),
                            ...List.generate(
                              state.textlogs.length,
                              (index) => Text(state.textlogs[index].toString()),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    BlocBuilder<AwsPollyBloc, AwsPollyState>(
                      builder: (context, state) {
                        return Expanded(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 8.0),
                            padding: EdgeInsets.all(8.0),
                            constraints: BoxConstraints.expand(),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: Colors.white,
                              ),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Text to Speech Log'),
                                  Divider(),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  ...List.generate(
                                    state.textlogs.length,
                                    (index) =>
                                        Text(state.textlogs[index].toString()),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    BlocBuilder<SubtitleBloc, SubtitleState>(
                      builder: (context, state) {
                        return Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 8.0, bottom: 16.0),
                            padding: EdgeInsets.all(8.0),
                            constraints: BoxConstraints.expand(),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: Colors.white,
                              ),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('SubtitleLog'),
                                  Divider(),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  ...List.generate(
                                    state.textlogs.length,
                                    (index) =>
                                        Text(state.textlogs[index].toString()),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Row(
        //   children: [
        //     Expanded(
        //       child: BlocBuilder<DefaultSttBloc, DefaultSttState>(
        //         builder: (context, state) {
        //           return Expanded(
        //             child: Container(
        //               margin: EdgeInsets.only(bottom: 16.0, right: 16.0),
        //               padding: EdgeInsets.all(8.0),
        //               constraints: BoxConstraints.expand(),
        //               decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(8.0),
        //                 border: Border.all(
        //                   color: Colors.white,
        //                 ),
        //               ),
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Text('Speech to Text Log'),
        //                   Divider(),
        //                   SizedBox(
        //                     height: 8.0,
        //                   ),
        //                   ...List.generate(
        //                     state.textlogs.length,
        //                     (index) => Text(state.textlogs[index].toString()),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           );
        //         },
        //       ),
        //     ),
        // Expanded(
        //   child: Column(
        //     children: [
        //       BlocBuilder<AwsPollyBloc, AwsPollyState>(
        //         builder: (context, state) {
        //           return Expanded(
        //             child: Container(
        //               margin: EdgeInsets.only(bottom: 8.0),
        //               padding: EdgeInsets.all(8.0),
        //               constraints: BoxConstraints.expand(),
        //               decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(8.0),
        //                 border: Border.all(
        //                   color: Colors.white,
        //                 ),
        //               ),
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Text('Text to Speech Log'),
        //                   Divider(),
        //                   SizedBox(
        //                     height: 8.0,
        //                   ),
        //                   ...List.generate(
        //                     state.textlogs.length,
        //                     (index) =>
        //                         Text(state.textlogs[index].toString()),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           );
        //         },
        //       ),
        //       BlocBuilder<SubtitleBloc, SubtitleState>(
        //         builder: (context, state) {
        //           return Expanded(
        //             child: Container(
        //               margin: EdgeInsets.only(top: 8.0),
        //               padding: EdgeInsets.all(8.0),
        //               constraints: BoxConstraints.expand(),
        //               decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(8.0),
        //                 border: Border.all(
        //                   color: Colors.white,
        //                 ),
        //               ),
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Text('SubtitleLog'),
        //                   Divider(),
        //                   SizedBox(
        //                     height: 8.0,
        //                   ),
        //                   ...List.generate(
        //                     state.textlogs.length,
        //                     (index) =>
        //                         Text(state.textlogs[index].toString()),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           );
        //         },
        //       ),
        //     ],
        //   ),
        // ),
        //   ],
        // ),
        BlocBuilder<DefaultSttBloc, DefaultSttState>(
          builder: (context, state) {
            return IconButton(
              iconSize: 48.0,
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
            );
          },
        ),
      ],
    );
  }
}
