import 'package:taggify/framework/json_database.dart';
import 'package:taggify/framework/repository.dart';
import 'package:taggify/model/song.dart';
import 'package:taggify/model/song_tag_repository.dart';
import 'package:taggify/model/tag.dart';

class TagRepository {
  static const _entityName   = 'tags' ;
  static const _entityPKName = 'id' ;

  final JsonDb     _db ;
  final Repository _repository ;

  TagRepository( final JsonDb db ) :
    _db         = db,
    _repository = Repository(
      db: db,
      entityName: _entityName,
      entityPkName: _entityPKName
    ) ;

  Future< Tag? > loadFromId( final String id ) async {
      final data = await _repository.loadFromId( id ) ;
      if ( data == null ) {
        return null ;
      }
      return Tag.populate( data ) ;
  }

  Future< List< Tag > > loadAllForTag( final Song song ) async {
    final songTagRepository = SongTagRepository( _db ) ;
    final allSongTags = await songTagRepository.loadAllForSong( song ) ;
    return < Tag >[
      for ( final songTag in allSongTags )
        await songTag.getTag( repository: this )
    ] ;
  }

  Future< List< Tag > > loadAll( {
    bool Function( Tag ) filter = Repository.dontFilter,
  } ) async {
    final col = await _repository.loadCollection(
      filter: ( EntityData data ) => filter( Tag.populate( data ) ),
    ) ;
    return col.map( (e) => Tag.populate( e ) ).toList() ;
  }

  Future< Tag > save( Tag tag ) async {
    final data = await _repository.save( tag.dump ) ;
    return Tag.populate( data ) ;
  }

  Future<bool> delete( EntityData entity ) async {
    return false ;
  }
}
