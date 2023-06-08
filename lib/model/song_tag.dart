import 'package:taggify/model/song.dart';
import 'package:taggify/model/song_repository.dart';
import 'package:taggify/model/tag.dart';
import 'package:taggify/model/tag_repository.dart';

class SongTag {
  String? id ;
  String songId, tagId ;

  SongTag( {
    required final Song song,
    required final Tag tag
  } ) :
    songId = song.id!,
    tagId  = tag.id! ;

  SongTag.populate( Map< String, dynamic > data ) :
    id     = data[ 'id' ] as String,
    songId = data[ 'song_id' ]! as String,
    tagId  = data[ 'tag_id' ]! as String ;

  Map< String, dynamic > get dump => {
    'id':      id,
    'song_id': songId,
    'tagId':   tagId,
  } ;

  Future<Song> getSong( { required SongRepository repository } ) async {
    return ( await repository.loadFromId( songId ) )! ;
  }

  Future<Tag> getTag( { required TagRepository repository } ) async {
    return ( await repository.loadFromId( tagId ) )! ;
  }
}
