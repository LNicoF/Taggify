import '../json_database.dart';

import 'song.dart';

class SongRepository {
  static const _entityName = 'songs' ;
  final JsonDb db ; // implement

  static bool dontFilter( element ) => true ;

  const SongRepository( this.db ) ;

  Song? loadFromId( final String id ) {
    final songs = db.getEntitySet( _entityName ) ;
    final song  = songs.firstWhere( ( song ) )
    final element  = elements.firstWhere( ( element ) => element.getString( 'id' ) == id ) ;
    if ( element == null ) {
      return null ;
    }

    return Song.populate( element ) ;
  }

  List< Song > loadCollection( {
    bool Function( Song ) filter = dontFilter,
  } ) {
    return db.getEntitySet( _entityName ).where( filter ) ;
  }

  Song save( final Song song ) {
    return song ;
  }

  bool delete( final Song song ) {
    return false ;
  }
}
