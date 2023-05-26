import 'package:uuid/uuid.dart';

import '../json_database.dart';
import 'song.dart';

class SongRepository {
  static const _entityName   = 'songs' ;
  static const _entityPKName = 'id' ;

  JsonDb db ; // implement

  static bool dontFilter( element ) => true ;

  SongRepository( this.db ) ;

  Song? loadFromId( final String id ) {
    var songs = db.getEntitySet( _entityName ) ;
    var songWasntFound = false ;
    var song = songs.firstWhere(
      ( song ) => ( song[ 'id' ] as String ) == id,
      orElse: () {
        songWasntFound = true ;
        return songs.first ;
      }
    ) ;
    if ( songWasntFound ) {
      return null ;
    }

    return Song.populate( song ) ;
  }

  List< Song > loadCollection( {
    bool Function( Song ) filter = dontFilter,
  } ) {
    return db.getEntitySet( _entityName )
             .map( Song.populate )
             .where( filter )
             .toList() ;
  }

  Song save( Song song ) {
    song.id ??= ( const Uuid() ).v4() ;
    bool ok = db.saveEntity(
      entityName: _entityName,
      pkName:     _entityPKName,
      data:       song.dump()
    ) ;
    if ( !ok ) {
      song.id = null ;
    }
    return song ;
  }

  bool delete( Song song ) {
    return false ;
  }
}
