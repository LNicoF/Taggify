import 'dart:convert' show jsonEncode, jsonDecode;

import 'package:taggify/framework/json_database.dart';
import 'package:test/test.dart';

void main() {
  group('JsonDb', () {
    late JsonDb jsonDb;
    const testContent = '{"entities":{}}';

    setUp(() {
      jsonDb = JsonDb.fromString(testContent);
    });

    test('dump() returns valid JSON string', () async {
      expect(await jsonDb.dump(), equals(
        jsonDecode(jsonEncode(testContent))
      ));
    });

    test('getEntitySet() returns an empty set for a non-existing entity', () {
      final entitySet = jsonDb.getEntitySet('non_existing_entity');
      expect(entitySet, isEmpty);
    });

    group( 'saveEntity', () {
      test('saveEntity() adds a new entity to the database', () {
        const entityName = 'test_entity';
        const pkName = 'id';
        final data = {pkName: 1, 'name': 'Test Entity'};
        final result = jsonDb.saveEntity(entityName: entityName, pkName: pkName, data: data);
        expect(result, isTrue);

        final entitySet = jsonDb.getEntitySet(entityName);
        expect(entitySet, hasLength(1));
        expect(entitySet.first, equals(data));
      });

      test('saveEntity() returns false if not given a pk', () {
        const entityName = 'test_entity';
        const pkName = 'id';
        final data = {'name': 'Test Entity'};
        final result = jsonDb.saveEntity(entityName: entityName, pkName: pkName, data: data);
        expect(result, isFalse);
      }) ;

      test('saveEntity() updates an entity if it already exists', () {
        const entityName = 'test_entity';
        const pkName = 'id';
        final data = { pkName: 2, 'name': 'New entity', 'test': 1};
        var result = jsonDb.saveEntity(entityName: entityName, pkName: pkName, data: data);
        expect( result, isTrue ) ;
        final newData = { pkName: 2, 'name2': 'Updated Entity', 'test': 2 } ;
        result = jsonDb.saveEntity(
          entityName: entityName, pkName: pkName,
          data: newData
        ) ;
        expect( result, isTrue ) ;
        final entity = jsonDb.findEntity( entityName: entityName,
          attrName: pkName, attrValue: data[ pkName ],
        ) ;
        expect( entity, isNotNull ) ;
        final finalData = {
          pkName: data[ pkName ],
          'name': data[ 'name' ],
          'name2': newData[ 'name2' ],
          'test': newData[ 'test' ],
        } ;
        expect( entity, equals( finalData ) ) ;
      }) ;
    } ) ;

    group('findEntity()', () {
      test('findEntity() returns the correct entity', () {
        const entityName = 'test_entity';
        const pkName = 'id';
        final data = {pkName: 1, 'name': 'Test Entity'};
        jsonDb.saveEntity(entityName: entityName, pkName: pkName, data: data);

        final foundEntity = jsonDb.findEntity(entityName: entityName, attrName: pkName, attrValue: 1);
        expect(foundEntity, equals(data));
      });

      test('findEntity() returns null if entity does not exists', () {
        const entityName = 'test_entity';
        const pkName = 'id';
        final data = {pkName: 1, 'name': 'Test Entity'};
        jsonDb.saveEntity(entityName: entityName, pkName: pkName, data: data);

        final notFoundEntity = jsonDb.findEntity(entityName: entityName, attrName: pkName, attrValue: 2);
        expect( notFoundEntity, isNull ) ;
      });
    });

    group( 'deleteEntity()', () {
      test('deleteEntity() deletes the correct entity', () {
        const entityName = 'test_entity';
        const pkName = 'id';
        final data = {pkName: 1, 'name': 'Test Entity'};
        jsonDb.saveEntity(entityName: entityName, pkName: pkName, data: data);

        final result = jsonDb.deleteEntity(entityName: entityName, attrName: pkName, attrValue: 1);
        expect(result, isTrue);

        final entitySet = jsonDb.getEntitySet(entityName);
        expect(entitySet, isEmpty);
      });

      test('deleteEntity() returns false if entity does not exists', () {
        const entityName = 'test_entity';
        const pkName = 'id';
        final data = {pkName: 1, 'name': 'Test Entity'};
        jsonDb.saveEntity(entityName: entityName, pkName: pkName, data: data);

        final result = jsonDb.deleteEntity(entityName: entityName, attrName: pkName, attrValue: 2);
        expect(result, isFalse);
      });
    }) ;
  });
}
