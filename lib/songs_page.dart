import 'package:flutter/material.dart';
import 'package:taggify/model/song.dart';
import 'package:taggify/model/song_repository.dart';
import 'package:taggify/song_form_dialog.dart';
import 'package:taggify/song_list_tile.dart';

class SongsPage extends StatefulWidget {
  final SongRepository songRepository ;
  final NavigationBar? navigationBar ;

  static const tab = NavigationDestination(
    label: 'Songs',
    icon: Icon(Icons.music_note),
  ) ;

  const SongsPage( {
    super.key,
    required this.songRepository,
    this.navigationBar,
  } ) ;

  @override
  State<SongsPage> createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage> {
  late final SongRepository _songRepository = widget.songRepository ;
  late final NavigationBar? _navigationBar = widget.navigationBar ;

  Future< List< Song > > _songs = Future.value( [] ) ;

  @override
  void initState() {
    super.initState() ;
    _reloadList() ;
  }

  void _reloadList() {
    _songs = _songRepository.loadAll() ;
  }

  void _saveSong( Song song ) {
    ( () async {
      song = await _songRepository.save( song ) ;
      setState(() {
        _reloadList() ;
      });
    } )() ;
  }

  void _deleteSong( Song song ) {
    ( () async {
      await _songRepository.delete( song.id! ) ;
      setState(() {
        _reloadList() ;
      });
    } )() ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _navigationBar,

      floatingActionButton: FloatingActionButton.extended(
        label: const Text( 'Add songg' ),
        icon: const Icon( Icons.add ),
        onPressed: () {
          showDialog(
            context: context,
            builder: ( cotext ) => SongFormDialog( saveSong: _saveSong )
          ) ;
        },
      ),

      body: SongListBuilder(
        songs: _songs,
        deleteSong: ( song ) => _deleteSong( song ),
      ),
    ) ;
  }
}

class SongListBuilder extends StatelessWidget {
  const SongListBuilder({
    super.key,
    required this.songs,
    required this.deleteSong,
  }) ;

  final Future<List<Song>> songs;
  final void Function( Song song ) deleteSong ;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: songs,
      builder: ( context, songListSnapshot ) {
        if ( songListSnapshot.hasData ) {
          return buildListView( songListSnapshot.data! ) ;
        }
        return const Center(child: Text( 'No songs found' ) ) ;
      },
    );
  }

  ListView buildListView( List< Song > songList ) {
    return ListView(
      children: [
        for ( final song in songList )
          SongListTile(
            song: song,
            deleteSong: deleteSong,
          ),
      ],
    );
  }
}
