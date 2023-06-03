import 'dart:io';

import 'package:taggify/json_database.dart';
import 'package:taggify/model/song.dart';
import 'package:taggify/model/song_repository.dart';

void main() async {
  var jsonFile = File( '/home/clnico/Documents/dart/flutter/taggify/00/taggify/test/model/db_example.json' ) ;
  final db = JsonDb.fromString( await jsonFile.readAsString() ) ;

  final repo = SongRepository( db ) ;
  logState( repo ) ;
  var song = Song( 'Silence is golden', '/path/to/reservations' ) ;
  song = repo.save( song ) ;
  print( song.dump() ) ;
  logState( repo ) ;

  jsonFile = await jsonFile.writeAsString( await db.dump() ) ;
}

void logState( SongRepository repo ) {
  print( repo.loadCollection()
             .map( ( song ) => song.dump() )
             .toList() ) ;
}
