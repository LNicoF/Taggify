import 'package:flutter/material.dart';
import 'package:taggify/model/song_repository.dart';

import 'song_form_dialog.dart';
import 'model/song.dart';

class SongListPage extends StatefulWidget {
  final SongRepository songRepository ;

  const SongListPage( {
    super.key,
    required this.songRepository
  } ) ;

  @override
  State<SongListPage> createState() => _SongListPageState();
}

class _SongListPageState extends State<SongListPage> {
  late Future< List< Song > > _songList ;

  @override
  void initState() {
    super.initState();
    reloadList() ;
  }

  void saveSong( Song song ) {
    ( () async {
      song = await widget.songRepository.save( song ) ;
      setState(() {
        reloadList() ;
      });
    } )() ;
  }

  void reloadList() {
    _songList = widget.songRepository.loadAll() ;
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
      body: FutureBuilder(
        future: _songList,
        builder: ( context, songListSnapshot ) {
          if ( songListSnapshot.hasData ) {
            return buildListView( songListSnapshot.data! ) ;
          }
          return const Center(
            child: Text( 'not loaded' ),
          ) ;
        },
      ),
    ) ;
  }

  ListView buildListView( List< Song > songList ) {
    return ListView(
      children: [
        ListTile(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon( Icons.play_arrow ),
          ),
          title: const Text( 'Example song' ),
          subtitle: const Text( 'path/of/file' ),
        ),
        for ( final song in songList )
          ListTile(
            leading: IconButton(
              onPressed: () {},
              icon: const Icon( Icons.play_arrow ),
            ),

            title: Text( song.name ),
            subtitle: Text( song.src ),
          ),
      ],
    );
  }
}
