import 'package:taggify/framework/repository.dart';
import 'package:taggify/model/song_tag.dart';
import 'package:taggify/model/tag.dart';
import '../framework/json_database.dart';
import 'song.dart';

class SongTagRepository {
  static const _entityName   = 'song_tag' ;
  static const _entityPKName = 'id' ;

  final Repository _repository ;

  SongTagRepository( final JsonDb db ) :
    _repository = Repository(
      db: db,
      entityName: _entityName,
      entityPkName: _entityPKName
    ) ;

  Future< SongTag > save( SongTag songTag ) async {
    final data = await _repository.save( songTag.dump ) ;
    return SongTag.populate( data ) ;
  }

  Future<bool> delete( EntityData entity ) async {
    return false ;
  }

  Future< List< SongTag > > loadAllForSong( final Song song ) async {
    return ( await _repository.loadCollection(
      filter: ( e ) => e[ 'song_id' ]! == song.id!
    ) ).map( ( data ) => SongTag.populate( data ) )
       .toList() ;
  }

  Future< List< SongTag > > loadAllForTag( final Tag tag ) async {
    return ( await _repository.loadCollection(
      filter: ( e ) => e[ 'tag_id' ]! == tag.id!
    ) ).map( ( data ) => SongTag.populate( data ) )
       .toList() ;
  }
}
