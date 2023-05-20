import 'package:file_picker/file_picker.dart';
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
        onPressed: () async {
          String? src ;

          src = await pickSongFile() ;

          print( src ) ;
          print( 'flag' ) ;

          if ( src == null ) {
            return ;
          }

          () sync* {
            showDialog(
              context: context,
              builder: ( context ) => SongFormDialog(
                saveSong: saveSong,
                initialSrc: src,
              ) ,
            );
          }() ;
        },
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

Future< String? > pickSongFile() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowMultiple: false,
    allowedExtensions: [ 'mp3' ],
  ) ;

  if ( result == null ) {
    return null ;
  }

  return result.files.single.path ;
}
