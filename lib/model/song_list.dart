import 'song.dart';

class SongList {
  var songs = < Song >[
  ] ;

  int getIndex( final Song song ) {
    for ( var i = 0 ; i < songs.length ; ++i ) {
      if ( songs[ i ].name == song.name ) {
        return i ;
      }
    }
    return -1 ;
  }

  void pushSong( final Song song ) {
    songs.add( song ) ;
  }

  void updateSongAtIndex( song, index ) {
    songs[ index ] = song ;
  }

  void saveSong( final Song song ) {
    final songIndex = getIndex( song ) ;
    if ( songIndex == -1 ) {
      pushSong( song ) ;
    } else {
      updateSongAtIndex( song, songIndex ) ;
    }
  }
}
