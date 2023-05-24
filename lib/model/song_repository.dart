import 'song.dart';

class SongRepository {
  static const _entity_name = 'songs' ;
  final dynamic db ;

  const SongRepository( this.db ) ;

  Song? loadFromId( final String id ) {
    final element = db.getCollection( _entity_name )
      .find( ( element ) => element.getString( 'id' ) == id ) ;
    if ( element == null )
      return null ;

    return Song.populate( element ) ;
  }

  Song save( final Song song ) {
    return song ;
  }

  bool delete( final Song song ) {
    return false ;
  }
}