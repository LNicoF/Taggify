import 'package:taggify/framework/repository.dart';
import 'package:taggify/model/song_tag_repository.dart';
import 'package:taggify/model/tag.dart';
import '../framework/json_database.dart';
import 'song.dart';

class SongRepository {
  static const _entityName   = 'songs' ;
  static const _entityPKName = 'id' ;

  final JsonDb     _db ;
  final Repository _repository ;

  SongRepository( final JsonDb db ) :
    _db         = db,
    _repository = Repository(
      db: db,
      entityName: _entityName,
      entityPkName: _entityPKName
    ) ;

  Future< Song? > loadFromId( final String id ) async {
      final data = await _repository.loadFromId( id ) ;
      if ( data == null ) {
        return null ;
      }
      return Song.populate( data ) ;
  }

  Future< List< Song > > loadAllForTag( final Tag tag ) async {
    final songTagRepository = SongTagRepository( _db ) ;
    final allSongTags = await songTagRepository.loadAllForTag( tag ) ;
    return < Song >[
      for ( final songTag in allSongTags )
        await songTag.getSong( repository: this )
    ] ;
  }

  Future< List< Song > > loadAll( {
    bool Function( Song ) filter = Repository.dontFilter,
  } ) async {
    final col = await _repository.loadCollection(
      filter: ( EntityData data ) => filter( Song.populate( data ) ),
    ) ;
    return col.map( (e) => Song.populate( e ) ).toList() ;
  }

  Future< Song > save( Song song ) async {
    final data = await _repository.save( song.dump ) ;
    return Song.populate( data ) ;
  }

  Future<bool> delete( EntityData entity ) async {
    return false ;
  }
}
