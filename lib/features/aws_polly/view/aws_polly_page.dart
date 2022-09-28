import 'package:aws_polly_api/polly-2016-06-10.dart';
import 'package:choobietalker/features/aws_polly/bloc/aws_polly_bloc.dart';
import 'package:choobietalker/features/aws_polly/view/voices_dropdownbutton.dart';
import 'package:choobietalker/shared/widgets/custom_dropdownbutton.dart';
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
                'TEXT TO SPEECH (AWS Polly)',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              Divider(),
              SizedBox(
                height: 8.0,
              ),
              Text('Voices Filter'),
              Row(
                children: [
                  Radio<Gender>(
                      value: Gender.male,
                      groupValue: state.filter.gender,
                      onChanged: (newValue) {
                        context.read<AwsPollyBloc>().add(
                              AwsPollyChangedFilter(
                                filter: state.filter.copyWith(gender: newValue),
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
                                filter: state.filter.copyWith(gender: newValue),
                              ),
                            );
                      }),
                  Text('Female'),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              CustomDropdownButton(
                value: state.selectedVoice,
                items: [
                  for (Voice voice in state.filteredVoices)
                    DropdownMenuItem(
                        value: voice,
                        child: Text('${voice.name} (${voice.languageName})'))
                ],
                onChanged: (newValue) {
                  context.read<AwsPollyBloc>().add(
                      AwsPollyChangedSelectedVoice(voice: newValue as Voice));
                },
                text: 'Voice: ',
              ),
              // Row(
              //   children: [
              //     Text('Select Voice'),
              //     VoicesDropdownButton(
              //       value: state.selectedVoice,
              //       items: state.filteredVoices,
              //       onChanged: (newValue) {
              //         context
              //             .read<AwsPollyBloc>()
              //             .add(AwsPollyChangedSelectedVoice(voice: newValue));
              //       },
              //     ),
              //   ],
              // ),
              SizedBox(
                height: 8.0,
              ),
              Text('Sample Rate'),
              Row(
                children: [
                  Radio<String>(
                    value: '8000',
                    groupValue: state.sampleRate,
                    onChanged: (newValue) {
                      context.read<AwsPollyBloc>().add(
                          AwsPollyChangedSampleRate(sampleRate: newValue!));
                    },
                  ),
                  Text('8000'),
                  Radio<String>(
                    value: '16000',
                    groupValue: state.sampleRate,
                    onChanged: (newValue) {
                      context.read<AwsPollyBloc>().add(
                          AwsPollyChangedSampleRate(sampleRate: newValue!));
                    },
                  ),
                  Text('16000'),
                  Radio<String>(
                    value: '22050',
                    groupValue: state.sampleRate,
                    onChanged: (newValue) {
                      context.read<AwsPollyBloc>().add(
                          AwsPollyChangedSampleRate(sampleRate: newValue!));
                    },
                  ),
                  Text('22050'),
                  Radio<String>(
                    value: '24000',
                    groupValue: state.sampleRate,
                    onChanged: (newValue) {
                      context.read<AwsPollyBloc>().add(
                          AwsPollyChangedSampleRate(sampleRate: newValue!));
                    },
                  ),
                  Text('24000'),
                ],
              ),
              Row(
                children: [
                  Text('Pitch'),
                  Slider(
                    value: state.pitch,
                    onChanged: (value) {
                      context
                          .read<AwsPollyBloc>()
                          .add(AwsPollyChangedPitch(value));
                    },
                    min: -100,
                    max: 100,
                  ),
                  Text('${state.pitch.toInt()}%'),
                ],
              ),
              Text('Note: Voice and Translation language should be the same to increase accuracy of the output'),
              SizedBox(height: 8.0,),
              Row(
                children: [
                  CustomDropdownButton(
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
