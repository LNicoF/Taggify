import 'package:flutter/material.dart';

import 'model/song.dart';

class SongFormDialog extends StatelessWidget {
  final void Function( Song ) saveSong ;

  const SongFormDialog( {
    super.key,
    required this.saveSong,
  } );

  @override
  Widget build(BuildContext context) {
    var song = Song( "", "" ) ;

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all( 25 ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add new song',
              style: Theme.of( context ).textTheme.headlineSmall,
            ),
            const SizedBox( height: 30 ),

            TextInputField(
              label: const Text( 'Song title' ),
              onChanged: ( textInput ) {
                song.name = textInput ;
              }
            ),
            const SizedBox( height: 15 ),

            TextInputField(
              label: const Text( 'Src' ),
              onChanged: ( inputText ) {
                song.src = inputText ;
              },
            ),

            const Expanded(
              child: SizedBox()
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop( context ) ;
                  },
                  style: TextButton.styleFrom(
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.all( 2 ),
                  ),
                  child: const Text( 'Cancel' ),
                ),
                const SizedBox( width: 10 ),

                FilledButton(
                  onPressed: () {
                    if ( song.name.isEmpty ) {
                      return ;
                    }
                    saveSong( song ) ;
                    Navigator.pop( context ) ;
                  },
                  child: const Text( 'Save' ),
                ),
              ],
            ),
          ],
        ),
      ),
    ) ;
  }
}

class TextInputField extends StatelessWidget {
  final Widget label;
  final Function( String )? onChanged;

  const TextInputField({
    super.key,
    required this.label,
    this.onChanged,
  } );

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        label: label,
        border: const OutlineInputBorder(),
      ),
      onChanged: onChanged,
    );
  }
}
