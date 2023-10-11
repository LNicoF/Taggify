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

    test( 'Load From Id', () {
      var entity = repo.loadFromId( 0 ) ;
      var nonexistent = repo.loadFromId( 1 ) ;
      expect( entity != null, true ) ;
      expect( entity[ 'id' ], 0 ) ;
      expect( entity[ 'test' ], 'foo' ) ;
    } ) ;
  } ) ;
}