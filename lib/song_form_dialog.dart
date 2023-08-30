import 'package:flutter/material.dart';
import 'package:taggify/text_input_field.dart';

import 'model/song.dart';

class SongFormDialog extends StatefulWidget {
  final void Function( Song ) saveSong ;
  final Song? fromSong ;

  const SongFormDialog( {
    super.key,
    required this.saveSong,
    this.fromSong,
  } ) ;

  @override
  State<SongFormDialog> createState() => _SongFormDialogState();
}

class _SongFormDialogState extends State<SongFormDialog> {
  late Song song ;
  late bool enabled ;

  bool get canSave => song.name.isNotEmpty && song.src.isNotEmpty ;

  void updateState() {
    if ( enabled != canSave ) {
      setState(() {
        enabled = !enabled ;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    song = widget.fromSong ?? Song.blank() ;
    enabled = canSave ;
  }

  @override
  Widget build(BuildContext context) {
    final saveSong = widget.saveSong ;

    return AlertDialog(
      title: const Text( 'Add new song' ),

      content: SingleChildScrollView(
        child: Column(
          children: [
            TextInputField(
              label: const Text( 'Song title' ),
              initialText: song.name,

              onChanged: ( textInput ) {
                song.name = textInput ;
                updateState() ;
              }
            ),
            const SizedBox( height: 16 ),

            TextInputField(
              label: const Text( 'Src' ),
              initialText: song.src,

              onChanged: ( inputText ) {
                song.src = inputText ;
                updateState() ;
              },
            ),
          ],
        ),
      ),

      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop( context ) ;
          },

          child: const Text( 'Cancel',
            textAlign: TextAlign.end,
          ),
        ),

        TextButton(
          onPressed: canSave ? () {
            saveSong( song ) ;
            Navigator.pop( context ) ;
          } : null,

          child: const Text( 'Save',
            textAlign: TextAlign.end,
          ),
        ),
      ],
    ) ;
  }
}
