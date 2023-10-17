import 'package:taggify/framework/json_database.dart';
import 'package:taggify/framework/repository.dart';
import 'package:test/test.dart';

void main() {
  group( 'Repository', () {
    const entity = 'tests' ;
    var db = JsonDb.fromString('''{
      "entities": {
          "$entity": [
            { "id": 0, "test": "foo" }
          ]
      }
    }''') ;
    var repo = Repository( db: db, entityName: entity ) ;

    test( 'Load From Id', () async {
      var entity = await repo.loadFromId( 0 ) ;
      var nonexistent = await repo.loadFromId( 1 ) ;
      expect( entity, isNotNull ) ;
      expect( entity![ 'id' ], 0 ) ;
      expect( entity[ 'test' ], 'foo' ) ;
      expect( nonexistent, null ) ;
    } ) ;

    test('Load Collection', () async {
      final collection = await repo.loadCollection();
      expect(collection.length, 1);
      expect(collection.any((element) => false), anyElement( ( e ) {
        return e[ 'id' ] == 0 && e[ 'test' ] == 'foo' ;
      } ) ) ;
    });

    test( 'Save', () async {
      var oldEntity = await repo.loadFromId( 0 ) ;
      var newEntity   = < String, dynamic >{ 'test': 'bar' };

      try {
        newEntity = await repo.save(newEntity);
        expect( newEntity[ 'id' ], isNotNull ) ;
      } catch (e) {
        expect( newEntity[ 'id' ], null ) ;
      }

      try {
        oldEntity = await repo.save( oldEntity! ) ;
        expect( true, false ) ; // Should throw
      } finally {}
      expect( oldEntity[ 'id' ], 0 ) ;
    } ) ;
    test('Delete', () async {
      var newEntity = < String, dynamic >{ 'test': 'baz' };
      newEntity = await repo.save(newEntity);

      final result = await repo.delete( newEntity['id'] );
      expect(result, isTrue);

      final loadedEntity = await repo.loadFromId(newEntity['id']);
      expect(loadedEntity, isNull);
    });
  } ) ;
}