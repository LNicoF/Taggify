import 'package:uuid/uuid.dart';

import '../framework/json_database.dart';

class Repository {
  final _entityName ;
  final _entityPKName = 'id' ;

  JsonDb _db ; // implement

  static bool dontFilter( element ) => true ;

  Repository( {
    required JsonDb db,
    required entityName
  }) : _db = db, _entityName = entityName;

  Song? loadFromId( final String id ) {
    var songs = _db.getEntitySet( _entityName ) ;
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
    return _db.getEntitySet( _entityName )
             .map( Song.populate )
             .where( filter )
             .toList() ;
  }

  Song save( Song song ) {
    song.id ??= ( const Uuid() ).v4() ;
    bool ok = _db.saveEntity(
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
