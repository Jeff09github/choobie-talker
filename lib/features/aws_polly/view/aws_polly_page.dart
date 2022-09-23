import 'package:aws_polly_api/polly-2016-06-10.dart';
import 'package:choobietalker/features/aws_polly/bloc/aws_polly_bloc.dart';
import 'package:choobietalker/features/aws_polly/view/voices_dropdownbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('AWS POLLY'),
              Divider(),
              SizedBox(
                height: 8.0,
              ),
              Text('Filter'),
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
              Row(
                children: [
                  Text('Select Voice'),
                  VoicesDropdownButton(
                    value: state.selectedVoice,
                    items: state.filteredVoices,
                    onChanged: (newValue) {
                      context
                          .read<AwsPollyBloc>()
                          .add(AwsPollyChangedSelectedVoice(voice: newValue));
                    },
                  ),
                ],
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
