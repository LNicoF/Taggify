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
  late var song = widget.fromSong ?? Song.blank() ;
  var _canSave = false ;

  void enableSaving() {
    if ( song.name == '' || song.src == '' ) {
      if ( _canSave ) {
        setState( () => _canSave = false );
      }
    } else {
      setState( () => _canSave = true );
    }
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
              onChanged: ( textInput ) {
                song.name = textInput ;
                enableSaving() ;
              }
            ),
            const SizedBox( height: 16 ),

            TextInputField(
              label: const Text( 'Src' ),
              onChanged: ( inputText ) {
                song.src = inputText ;
                enableSaving() ;
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
          onPressed: _canSave ? () {
            if ( song.name.isEmpty ) {
              return ;
            }
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
