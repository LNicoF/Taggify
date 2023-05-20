import 'package:flutter/material.dart';

import 'song_form_dialog.dart';
import 'model/song.dart';
import 'model/song_list.dart';

class SongListPage extends StatefulWidget {
  const SongListPage({super.key});

  @override
  State<SongListPage> createState() => _SongListPageState();
}

class _SongListPageState extends State<SongListPage> {
  final songList = SongList();

  void saveSong( final Song song ) {
    setState(() {
      songList.saveSong( song ) ;
    });
  }

  @override
  Widget build(BuildContext context)
    => Scaffold(
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
          for ( final song in songList.songs )
            ListTile(
              leading: IconButton(
                onPressed: () {},
                icon: const Icon( Icons.play_arrow ),
              ),

              title: Text( song.name ),
              subtitle: Text( song.src ),
            )
        ],
      ),
    ) ;
}
