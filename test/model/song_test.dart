import 'package:taggify/model/song.dart';
import 'package:test/test.dart';

void main() {
  group('Song', () {
    test('populate', () {
      const id = 'song id' ;
      const name = 'song name' ;
      const src = 'path/to/song' ;

      final song = Song.populate( { 'id': id, 'name': name, 'src': src } ) ;

      expect( song.id,   id ) ;
      expect( song.name, name ) ;
      expect( song.src,  src ) ;
    } ) ;
  } ) ;
}
