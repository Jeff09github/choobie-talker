import 'package:choobietalker/features/subtitle/bloc/subtitle_bloc.dart';
import 'package:choobietalker/shared/constant.dart';
import 'package:choobietalker/shared/widgets/custom_dropdownbutton.dart';
import 'package:choobietalker/shared/widgets/widgets.dart';
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
        Text(
          'SUBTITLE',
          style: TextStyle(fontSize: 16.0),
        ),
        Divider(),
        SizedBox(
          height: 8.0,
        ),
        CustomDropdownButton(
          text: 'Font Family',
          value: state.fontFamily,
          items: [
            for (String font in Constant().fonts)
              DropdownMenuItem(
                value: font,
                child: Text(
                  font,
                ),
              )
          ],
          onChanged: (newValue) {
            context
                .read<SubtitleBloc>()
                .add(ChangedFontFamily(fontFamily: newValue as String));
          },
        ),
        SizedBox(
          height: 8.0,
        ),
        CustomDropdownButton(
          text: 'Font Weight',
          value: state.fontWeight,
          items: [
            for (var fontWeight in Constant().fontWeights)
              DropdownMenuItem(
                value: fontWeight,
                child: Text(
                  fontWeight.toString().replaceAll('FontWeight.w', ''),
                ),
              )
          ],
          onChanged: (newValue) {
            context
                .read<SubtitleBloc>()
                .add(ChangedFontWeight(fontWeight: newValue as FontWeight));
          },
        ),
        SizedBox(
          height: 8.0,
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
        Row(
          children: [
            CustomColorPicker(
              text: 'Font Color',
              color: state.fontColor,
              onColorChanged: (newValue) {
                context
                    .read<SubtitleBloc>()
                    .add(ChangedFontColor(fontColor: newValue));
              },
            ),
            CustomColorPicker(
              text: 'Stroke Color',
              color: state.strokeColor,
              onColorChanged: (newValue) {
                context
                    .read<SubtitleBloc>()
                    .add(ChangedStrokeColor(strokeColor: newValue));
              },
            ),
          ],
        ),
        SizedBox(
          height: 8.0,
        ),
        CustomColorPicker(
          text: 'Background Color',
          color: state.backgroundColor,
          onColorChanged: (newValue) {
            context
                .read<SubtitleBloc>()
                .add(ChangedBackgroundColor(backgroundColor: newValue));
          },
        ),
        SizedBox(
          height: 8.0,
        ),
        Row(
          children: [
            CustomDropdownButton(
              text: 'Translate Subtitle to',
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
            state.translateOn ? const Text('ON') : const Text('OFF'),
          ],
        ),
      ],
    );
  }
}
