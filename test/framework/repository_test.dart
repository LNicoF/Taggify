import 'package:test/test.dart';
import 'package:taggify/framework/json_database.dart';
import 'package:taggify/framework/repository.dart';


void main() {
  group('Repository', () {
    JsonDb jsonDb;
    late Repository repository;
    const entityName = 'test_entity';
    const entityPKName = 'id';

    setUp(() {
      jsonDb = JsonDb.fromString('{"entities": {}}');
      repository = Repository(db: jsonDb, entityName: entityName, entityPkName: entityPKName);
    });

    group( 'loadFromId()', (){
      test('loadFromId() returns null for non-existing entity', () async {
        final result = await repository.loadFromId( 10 );
        expect(result, isNull);
      });

      test('loadFromId() returns the correct entity', () async {
        var entity = <String, dynamic>{'name': 'Test Entity'};
        entity = await repository.save(entity);

        final result = await repository.loadFromId(entity[ entityPKName ]);
        expect(result, equals(entity));
      });
    }) ;

    group( 'loadCollection()', (){
      test('loadCollection() returns all entities when no filter is provided', () async {
        var e1 = <String, dynamic>{'name': 'Entity 1'};
        var e2 = <String, dynamic>{'name': 'Entity 2'};
        e1 = await repository.save(e1);
        e1 = await repository.save(e2);

        final collection = await repository.loadCollection();
        expect(collection, contains(e1));
        expect(collection, contains(e2));
      });

      test('loadCollection() returns a subset when given a filter', () async {
        var e1 = await repository.save( { 'name': 'e1', 'type': 1 } ) ;
        var e2 = await repository.save( { 'name': 'e2', 'type': 2 } ) ;
        var e3 = await repository.save( { 'name': 'e3', 'type': 1 } ) ;

        final collection = await repository.loadCollection(
          filter: ( e ) => e[ 'type' ] == 1,
        ) ;
        expect( collection, hasLength( 2 ) ) ;
        expect( collection, containsAll( [ e1, e3 ] ) ) ;
        expect( collection, isNot( contains( e2 ) ) ) ;
      }) ;
    });

    group( 'save()', (){
      test('save() gives generates a pk if the entity does not have one', () async {
        final entity = {'name': 'New Entity'};
        final result = await repository.save(entity);

        expect(result[entityPKName], isNotNull);
        expect(result, equals(entity));

        final loadedEntity = await repository.loadFromId(result[entityPKName]);
        expect(loadedEntity, equals(entity));
      });

      test('save() uses the existing pk if given one', () async {
        const pk = '1234' ;
        final data = {entityPKName: pk, 'name': 'Entity with pk'};
        final result = await repository.save(data);

        expect(result['id'], equals(pk));
        expect(result, equals(data));

        final loadedEntity = await repository.loadFromId(result[entityPKName]);
        expect(loadedEntity, equals(result));
      });

      test('save() updates an existing entity if given an existing pk', () async {
        var entity = await repository.save({ 'name': 'stays', 'type': 1 }) ;
        entity = await repository.save({
          entityPKName: entity[ entity ],
          'type': 2,
          'newField': 'foo',
        }) ;
        expect( entity, equals({
          entityPKName: entity[ entityPKName ],
          'name': 'stays',
          'type': 2,
          'newField': 'foo',
        }) ) ;
      }) ;
    } ) ;

    group( 'delete()', (){
      test('delete() deletes an existing entity', () async {
        var entity = await repository.save({'name': 'Entity to be deleted'});

        final result = await repository.delete(entity[entityPKName]);
        expect(result, isTrue);

        final loadedEntity = await repository.loadFromId(entity[entityPKName]);
        expect(loadedEntity, isNull);
      });

      test('delete() returns false when the entty does not exists', () async {
        await repository.save({'name': 'Should stay'});

        final result = await repository.delete( '123' );
        expect(result, false);

        final collection = await repository.loadCollection() ;
        expect( collection, hasLength( 1 ) ) ;
      });
    } ) ;
  });
}

