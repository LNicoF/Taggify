import 'package:taggify/model/song_tag.dart';
import 'package:taggify/model/song_tag_repository.dart';
import 'package:taggify/model/tag.dart';

class Song {
  String? id ;
  String name, src ;

  Song( this.name, this.src ) ;

  Song.populate( Map< String, dynamic > data ) :
    id   = data[ 'id' ] as String,
    name = data[ 'name' ] as String,
    src  = data[ 'src' ] as String ;

  Map< String, dynamic > get dump => {
    'id':   id,
    'name': name,
    'src':  src,
  } ;

  Future< void > addTag( Tag tag, { required SongTagRepository repository } ) async {
    var newSongTag = SongTag( tag: tag, song: this ) ;
    repository.save( newSongTag ) ;
  }
}
