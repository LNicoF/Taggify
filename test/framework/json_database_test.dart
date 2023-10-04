import 'package:taggify/framework/json_database.dart';
import 'package:test/test.dart';

void main() {
  group('Example db', () {
    const entity = 'tests' ;
    var db = JsonDb.fromString('''{
      "entities": {
        "$entity": [
          { "id": 0, "test": "foo" }
        ]
      }
    }''') ;

    test('Get entity set', () {
      final set = db.getEntitySet( entity ) ;

      expect( set.length, 1 ) ;
      expect( set.any( (element) {
        return element[ 'id' ] == 0
          && element[ 'test' ] == 'foo';
      }), true ) ;
    });

    test( 'Find entity', () {
      expect(db.findEntity( entityName: 'nonexistent',
        attrName: 'id', attrValue: 0,
      ), null) ;

      {
        final e = db.findEntity( entityName: entity,
          attrName: 'id', attrValue: 0
        ) ;
        expect( e != null, true ) ;
        expect( e?[ 'id' ], 0 ) ;
        expect( e?[ 'test' ], 'foo' ) ;
      }
    } ) ;

    test( 'Delete entity', () {
      expect( db.deleteEntity( entityName: 'nonexistent',
        attrName: 'id', attrValue: 0,
      ), false ) ;

      expect( db.deleteEntity( entityName: entity,
        attrName: 'id', attrValue: 1,
      ), false ) ;

      expect( db.deleteEntity( entityName: entity,
        attrName: 'id', attrValue: 0,
      ), true ) ;

      expect( db.findEntity( entityName: entity,
        attrName: 'id', attrValue: 0,
      ), null ) ;
    } ) ;

    test( 'Save new entity', () {
      expect( db.saveEntity(entityName: entity,
        pkName: 'id', data: { 'test': 'bar' }
      ), false ) ;

      expect( db.saveEntity(
        entityName: entity, pkName: 'id',
        data: { 'id': 1, 'test': 'bar' }
      ), true ) ;

      expect( db.saveEntity(entityName: entity,
        pkName: 'id', data: { 'test': 'bar' }
      ), false ) ;

      {
        final e = db.findEntity( entityName: entity,
          attrName: 'id', attrValue: 1
        ) ;
        expect( e != null, true ) ;
        expect( e?[ 'id' ], 1 ) ;
        expect( e?[ 'test' ], 'bar' ) ;
      }
    }) ;
  }) ;
}
