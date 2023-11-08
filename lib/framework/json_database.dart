import 'dart:convert' show jsonEncode, jsonDecode;
import 'dart:io';

typedef JsonObject = Map<String, dynamic>;

class JsonDb {
  JsonObject content = {};

  JsonDb.fromString(final String initialContent) {
    content = jsonDecode(initialContent) as JsonObject;
  }

  Future<String> dump() async {
    return jsonEncode( content ) ;
  }

  void dumpIntoFile(File file) async {
    throw UnimplementedError;
  }

  /// Returns the [entityName] entity set
  Set<JsonObject> getEntitySet(final String entityName) {
    final operation = _DbOperation(content: content, entityName: entityName) ;
    return Set.of( operation.entityList?.map((e) => e as JsonObject) ?? [] ) ;
  }

  /// Saves the [data] into the entity set
  /// [entityName], with the primary key [pkName]
  bool saveEntity({
    required String     entityName,
    required String     pkName,
    required JsonObject data,
  }) {
    if (data[pkName] == null) {
      return false;
    }

    var entity = findEntity(
      entityName: entityName,
      attrName: pkName,
      attrValue: data[pkName],
    );

    if (entity == null) {
      final res = _DbOperation(
        content: content, entityName: entityName
      ).insert( data, pkName: pkName) ;
      return res ;
    }
    return _updateEntity(entity: entity, newData: data);
  }

  /// Updates the JsonObject [entity] with the data
  /// in [newData]
  bool _updateEntity({
    required JsonObject entity,
    required JsonObject newData,
  }) {
    entity.addAll(newData);
    return true;
  }

  /// If the entity with the attribute named [attrName]
  /// and value [attrValue] exists, returns the entity JsonObject;
  /// otherwise, returns null
  JsonObject? findEntity({
    required String entityName,
    required String attrName,
    required dynamic attrValue,
  }) {
    return _DbOperation(
      content: content,
      entityName: entityName
    ).findEntity(
      attrName: attrName,
      attrValue: attrValue
    );
  }

  /// Deletes the entity where [attrName] equals [attrValue]
  /// and returns true if the operation succeds
  bool deleteEntity( {
    required String entityName,
    required attrName,
    required attrValue,
  } ) {
    final entity = findEntity(
      entityName: entityName,
      attrName:   attrName,
      attrValue:  attrValue,
    ) ;

    if ( entity == null ) {
      return false ;
    }

    return ( ( content[ 'entities' ] as JsonObject )
      [ entityName ] as List )
      .remove( entity ) ;
  }
}

class _DbOperation {
  JsonObject content;
  final String entityName;

  List? get entityList
    => ( (content['entities'] as JsonObject)[entityName] as List? ) ;

  _DbOperation({
    required this.content,
    required this.entityName,
  });

  JsonObject? findEntity({
    required String attrName,
    required dynamic attrValue,
  }) {
    var entityAlreadyExists = true;

    var entityFound =
        entityList?.firstWhere((row) => row[attrName] == attrValue, orElse: () {
      entityAlreadyExists = false;
      return null;
    });

    return entityAlreadyExists ? entityFound : null;
  }

  bool insert( JsonObject data, { required String pkName } ) {
    if ( entityList == null ) {
      return false ;
    }

    if ( entityList!.where(
      ( element ) => element[ pkName ] == data[ pkName ]
    ).isNotEmpty ) {
      return false ;
    }

    entityList!.add( data ) ;
    return true ;
  }
}
