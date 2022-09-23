import 'package:choobietalker/features/subtitle/bloc/subtitle_bloc.dart';
import 'package:choobietalker/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';

class SubtitlePage extends StatelessWidget {
  const SubtitlePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubtitleBloc, SubtitleState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              color: state.backgroundColor,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                height: state.containerHeight,
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Text(
                      state.text,
                      style: GoogleFonts.getFont(state.fontFamily).copyWith(
                        fontWeight: state.fontWeight,
                        fontSize: state.fontSize,
                        foreground: Paint()
                          ..color = state.strokeColor
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = state.strokeWidth,
                      ),
                    ),
                    Text(
                      state.text,
                      style: GoogleFonts.getFont(state.fontFamily).copyWith(
                        color: state.fontColor,
                        fontWeight: state.fontWeight,
                        fontSize: state.fontSize,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class SubtitleSettings extends StatelessWidget {
  const SubtitleSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SubtitleBloc>().state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('SUBTITLE'),
        Divider(),
        SizedBox(
          height: 8.0,
        ),
        Text('Font Family'),
        DropdownButton(
          value: state.fontFamily,
          items: Constant()
              .fonts
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ),
              )
              .toList(),
          onChanged: (newValue) {
            context
                .read<SubtitleBloc>()
                .add(ChangedFontFamily(fontFamily: newValue as String));
          },
        ),
        SizedBox(
          width: 16.0,
        ),
        Text('Font Weight'),
        DropdownButton(
          value: state.fontWeight,
          items: Constant()
              .fontWeights
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e.toString().replaceAll('FontWeight.', '')),
                ),
              )
              .toList(),
          onChanged: (newValue) {
            context
                .read<SubtitleBloc>()
                .add(ChangedFontWeight(fontWeight: newValue as FontWeight));
          },
        ),
        SizedBox(
          width: 16.0,
        ),
        Text('Height'),
        Slider(
          min: 50.0,
          max: 200.0,
          value: state.containerHeight,
          onChanged: (newValue) {
            context
                .read<SubtitleBloc>()
                .add(ChangedContainerHeight(height: newValue));
          },
        ),
        Text('Font Size'),
        Slider(
          min: 12.0,
          max: 48.0,
          value: state.fontSize,
          onChanged: (newValue) {
            context.read<SubtitleBloc>().add(ChangedFontSize(size: newValue));
          },
        ),
        Text('Stroke Width'),
        Slider(
          min: 2.0,
          max: 10.0,
          value: state.strokeWidth,
          onChanged: (newValue) {
            context
                .read<SubtitleBloc>()
                .add(ChangedStrokeWidth(strokeWidth: newValue));
          },
        ),
        Text('Font Color'),
        GestureDetector(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            width: 50.0,
            height: 25.0,
            color: state.fontColor,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  content: SingleChildScrollView(
                    child: ColorPicker(
                      pickerColor: state.fontColor,
                      onColorChanged: (newValue) {
                        print('fontchange');
                        context
                            .read<SubtitleBloc>()
                            .add(ChangedFontColor(fontColor: newValue));
                      },
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      child: const Text('Got it'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
        SizedBox(
          width: 16.0,
        ),
        Text('Stroke Color'),
        GestureDetector(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            width: 50.0,
            height: 25.0,
            color: state.strokeColor,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  content: SingleChildScrollView(
                    child: ColorPicker(
                        pickerColor: state.strokeColor,
                        onColorChanged: (newValue) {
                          context
                              .read<SubtitleBloc>()
                              .add(ChangedStrokeColor(strokeColor: newValue));
                        }),
                  ),
                  actions: [
                    ElevatedButton(
                      child: const Text('Got it'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
        SizedBox(
          width: 16.0,
        ),
        Text('Background Color'),
        GestureDetector(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            width: 50.0,
            height: 25.0,
            color: state.backgroundColor,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  content: SingleChildScrollView(
                    child: ColorPicker(
                      pickerColor: state.backgroundColor,
                      onColorChanged: (newValue) {
                        context.read<SubtitleBloc>().add(
                            ChangedBackgroundColor(backgroundColor: newValue));
                      },
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      child: const Text('Got it'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
        Row(
          children: [
            Text('Translate to'),
            DropdownButton(
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
                context
                    .read<SubtitleBloc>()
                    .add(ChangedTranslateTo(code: newValue as String));
              },
            ),
            Switch(
              value: state.translateOn,
              onChanged: (newValue) {
                context.read<SubtitleBloc>().add(const ToggleTranstionOn());
              },
            ),
          ],
        ),
      ],
    );
    // return Column(
    //   children: [
    //     Row(
    //       children: [
    //         Text('Font Family'),
    //         SizedBox(
    //           width: 16.0,
    //         ),
    //         DropdownButton(
    //           value: state.fontFamily,
    //           items: Constant()
    //               .fonts
    //               .map(
    //                 (e) => DropdownMenuItem(
    //                   value: e,
    //                   child: Text(e),
    //                 ),
    //               )
    //               .toList(),
    //           onChanged: (newValue) {
    //             context
    //                 .read<SubtitleBloc>()
    //                 .add(ChangedFontFamily(fontFamily: newValue as String));
    //           },
    //         ),
    //         SizedBox(
    //           width: 16.0,
    //         ),
    //         Text('Font Weight'),
    //         SizedBox(
    //           width: 16.0,
    //         ),
    //         DropdownButton(
    //           value: state.fontWeight,
    //           items: Constant()
    //               .fontWeights
    //               .map(
    //                 (e) => DropdownMenuItem(
    //                   value: e,
    //                   child: Text(e.toString().replaceAll('FontWeight.', '')),
    //                 ),
    //               )
    //               .toList(),
    //           onChanged: (newValue) {
    //             context
    //                 .read<SubtitleBloc>()
    //                 .add(ChangedFontWeight(fontWeight: newValue as FontWeight));
    //           },
    //         ),
    //         SizedBox(
    //           width: 16.0,
    //         ),
    //         Text('Height'),
    //         Slider(
    //           min: 50.0,
    //           max: 200.0,
    //           value: state.containerHeight,
    //           onChanged: (newValue) {
    //             context
    //                 .read<SubtitleBloc>()
    //                 .add(ChangedContainerHeight(height: newValue));
    //           },
    //         ),
    //         Text('Font Size'),
    //         Slider(
    //           min: 12.0,
    //           max: 48.0,
    //           value: state.fontSize,
    //           onChanged: (newValue) {
    //             context
    //                 .read<SubtitleBloc>()
    //                 .add(ChangedFontSize(size: newValue));
    //           },
    //         ),
    //         Text('Stroke Width'),
    //         Slider(
    //           min: 2.0,
    //           max: 10.0,
    //           value: state.strokeWidth,
    //           onChanged: (newValue) {
    //             context
    //                 .read<SubtitleBloc>()
    //                 .add(ChangedStrokeWidth(strokeWidth: newValue));
    //           },
    //         ),
    //         Text('Font Color'),
    //         GestureDetector(
    //           child: Container(
    //             margin: EdgeInsets.symmetric(horizontal: 8.0),
    //             width: 50.0,
    //             height: 25.0,
    //             color: state.fontColor,
    //           ),
    //           onTap: () {
    //             showDialog(
    //               context: context,
    //               builder: (_) {
    //                 return AlertDialog(
    //                   content: SingleChildScrollView(
    //                     child: ColorPicker(
    //                       pickerColor: state.fontColor,
    //                       onColorChanged: (newValue) {
    //                         print('fontchange');
    //                         context
    //                             .read<SubtitleBloc>()
    //                             .add(ChangedFontColor(fontColor: newValue));
    //                       },
    //                     ),
    //                   ),
    //                   actions: [
    //                     ElevatedButton(
    //                       child: const Text('Got it'),
    //                       onPressed: () {
    //                         Navigator.of(context).pop();
    //                       },
    //                     ),
    //                   ],
    //                 );
    //               },
    //             );
    //           },
    //         ),
    //         SizedBox(
    //           width: 16.0,
    //         ),
    //         Text('Stroke Color'),
    //         GestureDetector(
    //           child: Container(
    //             margin: EdgeInsets.symmetric(horizontal: 8.0),
    //             width: 50.0,
    //             height: 25.0,
    //             color: state.strokeColor,
    //           ),
    //           onTap: () {
    //             showDialog(
    //               context: context,
    //               builder: (_) {
    //                 return AlertDialog(
    //                   content: SingleChildScrollView(
    //                     child: ColorPicker(
    //                         pickerColor: state.strokeColor,
    //                         onColorChanged: (newValue) {
    //                           context.read<SubtitleBloc>().add(
    //                               ChangedStrokeColor(strokeColor: newValue));
    //                         }),
    //                   ),
    //                   actions: [
    //                     ElevatedButton(
    //                       child: const Text('Got it'),
    //                       onPressed: () {
    //                         Navigator.of(context).pop();
    //                       },
    //                     ),
    //                   ],
    //                 );
    //               },
    //             );
    //           },
    //         ),
    //         SizedBox(
    //           width: 16.0,
    //         ),
    //         Text('Background Color'),
    //         GestureDetector(
    //           child: Container(
    //             margin: EdgeInsets.symmetric(horizontal: 8.0),
    //             width: 50.0,
    //             height: 25.0,
    //             color: state.backgroundColor,
    //           ),
    //           onTap: () {
    //             showDialog(
    //               context: context,
    //               builder: (_) {
    //                 return AlertDialog(
    //                   content: SingleChildScrollView(
    //                     child: ColorPicker(
    //                       pickerColor: state.backgroundColor,
    //                       onColorChanged: (newValue) {
    //                         context.read<SubtitleBloc>().add(
    //                             ChangedBackgroundColor(
    //                                 backgroundColor: newValue));
    //                       },
    //                     ),
    //                   ),
    //                   actions: [
    //                     ElevatedButton(
    //                       child: const Text('Got it'),
    //                       onPressed: () {
    //                         Navigator.of(context).pop();
    //                       },
    //                     ),
    //                   ],
    //                 );
    //               },
    //             );
    //           },
    //         ),
    //       ],
    //     ),
    //   ],
    // );
  }
}
