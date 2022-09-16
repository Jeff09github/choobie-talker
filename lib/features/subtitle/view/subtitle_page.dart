import 'package:choobietalker/features/subtitle/bloc/subtitle_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SubtitlePage extends StatelessWidget {
  const SubtitlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubtitleBloc, SubtitleState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
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
                    context
                        .read<SubtitleBloc>()
                        .add(ChangedFontSize(size: newValue));
                  },
                ),
              ],
            ),
            Card(
              color: Colors.green,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                height: state.containerHeight,
                alignment: Alignment.center,
                child: Text(
                  state.text,
                  style: GoogleFonts.getFont('Roboto').copyWith(
                    color: state.color,
                    fontWeight: state.fontWeight,
                    fontSize: state.fontSize,
                  ),
                ),
              ),
              // child: TextFormField(
              //   textAlign: TextAlign.center,
              //   enabled: false,
              //   maxLines: 5,
              //   decoration: InputDecoration(
              //     // hintText: context.watch<DefaultSttBloc>().state.lastHeard,
              //     hintText: 'TEST THE SUBTITLE FONT',
              //     // hintStyle: const TextStyle(
              //     //   fontSize: 24.0,
              //     //   color: Colors.white,
              //     // ),
              //     hintStyle: GoogleFonts.getFont('Roboto').copyWith(
              //       fontSize: 24.0,
              //       color: Colors.white,
              //       fontWeight: FontWeight.bold,
              //     ),
              //     border: const OutlineInputBorder(),
              //   ),
              // ),
            ),
          ],
        );
      },
    );
  }
}
