import 'package:taggify/json_database.dart';
import 'package:taggify/model/song.dart';
import 'package:taggify/model/song_repository.dart';

void main() {
  final db = JsonDb.fromString( ''' {
    "entities": {
      "songs": [
        {
          "id": "123",
          "name": "Bad Wolves Zombie",
          "src": "/path/to/brains"
        },
        {
          "id": "1234",
          "name": "Legends never die",
          "src": "/path/to/obesity"
        }
      ]
    }
  } ''' ) ;

  final repo = SongRepository( db ) ;
  logState( repo ) ;
  var song = Song( 'Silence is golden', '/path/to/reservations' ) ;
  song = repo.save( song ) ;
  print( song.dump() ) ;
  logState( repo ) ;
}

void logState( SongRepository repo ) {
  print( repo.loadCollection()
             .map( ( song ) => song.dump() )
             .toList() ) ;
}
