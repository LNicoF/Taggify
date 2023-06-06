import 'package:flutter/material.dart';
import 'package:taggify/model/song_repository.dart';

import 'song_form_dialog.dart';
import 'model/song.dart';

class SongListPage extends StatelessWidget {
  final SongRepository songRepository ;

  const SongListPage( {
    super.key,
    required this.songRepository
  } ) ;

  void saveSong( final Song song ) {
  }

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          label: const Text( 'Add song' ),
          icon: const Icon( Icons.add ),
          onPressed: () => showDialog(
            context: context,
            builder: ( context ) => SongFormDialog( saveSong: saveSong ),
          ),
        ),
        body: ListView(
          children: [
            ListTile(
              leading: IconButton(
                onPressed: () {},
                icon: const Icon( Icons.play_arrow ),
              ),
              title: const Text( 'Example song' ),
              subtitle: const Text( 'path/of/file' ),
            ),
            for ( final song in songRepository.loadCollection() )
              ListTile(
                leading: IconButton(
                  onPressed: () {},
                  icon: const Icon( Icons.play_arrow ),
                ),

                title: Text( song.name ),
                subtitle: Text( song.src ),
              ),
          ],
        ),
      ) ;
    }
}
