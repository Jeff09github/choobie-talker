import 'package:aws_polly_api/polly-2016-06-10.dart';
import 'package:choobietalker/features/aws_polly/bloc/aws_polly_bloc.dart';
import 'package:choobietalker/shared/widgets/custom_container.dart';
import 'package:choobietalker/shared/widgets/custom_dropdownbutton.dart';
import 'package:choobietalker/shared/widgets/custom_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/constant.dart';

class AwsPollyPage extends StatelessWidget {
  const AwsPollyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

class AwsPollySettings extends StatelessWidget {
  const AwsPollySettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AwsPollyBloc, AwsPollyState>(
      builder: (context, state) {
        if (state.status == AwsPollyStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status == AwsPollyStatus.success) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TEXT TO SPEECH',
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
              CustomContainer(
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Radio<Gender>(
                            value: Gender.male,
                            groupValue: state.filter.gender,
                            onChanged: (newValue) {
                              context.read<AwsPollyBloc>().add(
                                    AwsPollyChangedFilter(
                                      filter: state.filter
                                          .copyWith(gender: newValue),
                                    ),
                                  );
                            }),
                        Text('Male'),
                        Radio<Gender>(
                            value: Gender.female,
                            groupValue: state.filter.gender,
                            onChanged: (newValue) {
                              context.read<AwsPollyBloc>().add(
                                    AwsPollyChangedFilter(
                                      filter: state.filter
                                          .copyWith(gender: newValue),
                                    ),
                                  );
                            }),
                        Text('Female'),
                      ],
                    ),
                    CustomDropdownButton(
                      tooltip: Tooltip(
                        child: CustomContainer(
                          radius: 0.0,
                          boxShape: BoxShape.circle,
                          child: Text(
                            '!',
                            // style: TextStyle(color: Colors.redAccent),
                          ),
                        ),
                        message:
                            'Voice Output and Voice Translation language should be the same if you will use both to increase output accuracy.\n     example:\n          Voice Output: Mizuki(Japanese)\n          Translate voice to: Japanese',
                      ),
                      value: state.selectedVoice,
                      items: [
                        for (Voice voice in state.filteredVoices)
                          DropdownMenuItem(
                              value: voice,
                              child:
                                  Text('${voice.name} (${voice.languageName})'))
                      ],
                      onChanged: (newValue) {
                        context.read<AwsPollyBloc>().add(
                            AwsPollyChangedSelectedVoice(
                                voice: newValue as Voice));
                      },
                      text: 'Voice Output',
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Row(
                children: [
                  CustomContainer(
                    child: CustomDropdownButton(
                      text: 'Translate Voice to',
                      value: state.translateTo,
                      items: Constant()
                          .googleLanguages
                          .map(
                            (e) => DropdownMenuItem(
                              value: e.code,
                              child: Text(e.name),
                            ),
                          )
                          .toList(),
                      onChanged: (newValue) {
                        context.read<AwsPollyBloc>().add(
                            AwsPollyChangedTranslation(
                                languageCode: newValue as String));
                      },
                    ),
                  ),
                  Switch(
                    value: state.translationOn,
                    onChanged: (newValue) {
                      context
                          .read<AwsPollyBloc>()
                          .add(const AwsPollyToggleTranstionOn());
                    },
                  ),
                  state.translationOn ? const Text('ON') : const Text('OFF'),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              CustomContainer(
                  child: Column(
                children: [
                  Text('Audio Frequency'),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Radio<String>(
                        value: '8000',
                        groupValue: state.audioFrequency,
                        onChanged: (newValue) {
                          context.read<AwsPollyBloc>().add(
                              AwsPollyChangedAudioFrequency(
                                  audioFrequency: newValue!));
                        },
                      ),
                      Text('8000'),
                      Radio<String>(
                        value: '16000',
                        groupValue: state.audioFrequency,
                        onChanged: (newValue) {
                          context.read<AwsPollyBloc>().add(
                              AwsPollyChangedAudioFrequency(
                                  audioFrequency: newValue!));
                        },
                      ),
                      Text('16000'),
                      Radio<String>(
                        value: '22050',
                        groupValue: state.audioFrequency,
                        onChanged: (newValue) {
                          context.read<AwsPollyBloc>().add(
                              AwsPollyChangedAudioFrequency(
                                  audioFrequency: newValue!));
                        },
                      ),
                      Text('22050'),
                      Radio<String>(
                        value: '24000',
                        groupValue: state.audioFrequency,
                        onChanged: (newValue) {
                          context.read<AwsPollyBloc>().add(
                              AwsPollyChangedAudioFrequency(
                                  audioFrequency: newValue!));
                        },
                      ),
                      Text('24000'),
                    ],
                  ),
                ],
              )),
              SizedBox(
                height: 16.0,
              ),
              Text('Voice Volume'),
              CustomSlider(
                value: state.voiceVolume.toDouble(),
                min: -18.0,
                max: 18.0,
                onChanged: (value) {
                  context
                      .read<AwsPollyBloc>()
                      .add(AwsPollyChangedVoiceVolume(value.toInt()));
                },
                text: state.voiceVolume >= 0
                    ? '+${state.voiceVolume}dB'
                    : '${state.voiceVolume}dB',
              ),
              Text('Speech Rate'),
              Row(
                children: [
                  Slider(
                    value: state.speechRate.toDouble(),
                    onChanged: (value) {
                      context
                          .read<AwsPollyBloc>()
                          .add(AwsPollyChangedSpeechRate(value.toInt()));
                    },
                    min: 20.0,
                    max: 200.0,
                  ),
                  Text('${state.speechRate}%'),
                ],
              ),
              Text('Pitch'),
              Row(
                children: [
                  Slider(
                    value: state.pitch.toDouble(),
                    onChanged: (value) {
                      context
                          .read<AwsPollyBloc>()
                          .add(AwsPollyChangedPitch(value.toInt()));
                    },
                    min: -50.0,
                    max: 50.0,
                  ),
                  Text('${state.pitch}%')
                ],
              ),
              Text('Timbre'),
              Row(
                children: [
                  Slider(
                    value: state.timbre.toDouble(),
                    onChanged: (value) {
                      context
                          .read<AwsPollyBloc>()
                          .add(AwsPollyChangedTimbre(value.toInt()));
                    },
                    min: -50.0,
                    max: 100.0,
                  ),
                  Text('${state.timbre}%')
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
            ],
          );
        } else if (state.status == AwsPollyStatus.failure) {
          return const Center(
            child: Text('Status Failed!'),
          );
        } else {
          return const Center(
            child: Text('Invalid Status!'),
          );
        }
      },
    );
  }
}
