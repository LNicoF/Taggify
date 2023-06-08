import 'package:taggify/model/song.dart';
import 'package:taggify/model/song_tag.dart';
import 'package:taggify/model/song_tag_repository.dart';

class Tag {
  String? id ;
  late String name ;

  Tag( { required this.name } ) ;

  Tag.populate( Map< String, dynamic > data ) {
    id =   data[ 'id' ] as String ;
    name = data[ 'name' ] as String ;
  }

  Map< String, dynamic > get dump => {
    "id":   id,
    "name": name,
  } ;

  Future< void > addTag( Song song, { required SongTagRepository repository } ) async {
    var newSongTag = SongTag( tag: this, song: song ) ;
    repository.save( newSongTag ) ;
  }
}
