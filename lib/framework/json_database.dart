import 'dart:convert' show jsonEncode, jsonDecode;
import 'dart:io';

typedef JsonObject = Map<String, dynamic>;

class JsonDb {
  JsonObject content = {};

  JsonDb();

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
  /// Pre: entityName.length > 0 and exists content['entities'][entityName]
  /// Post: returns content[ 'entities' ][ entityName ]
  Set<JsonObject> getEntitySet(final String entityName) {
    if ( entityName.isEmpty || content[ 'entities' ]?[ entityName ] == null ) {
      throw new Exception( 'Entity name cannot be empty') ;
    }
    final operation = _DbOperation(content: content, entityName: entityName) ;
    return Set.of( operation.entityList.map((e) => e as JsonObject)) ;
  }

  /// Saves the data in [data] into the entity set
  /// [entityName], which's primary key is [pkName]
  /// Pre: entityName.length > 0
  ///      and exists content['entities'][entityName]
  ///      and exists data[ pkName ]
  /// Post: content[ 'entities' ][ entityName ] contains data
  ///       returns true
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
      attrValue: data[pkName] as String,
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
  /// Pre: entityName.length > 0 and attrName.length > 0
  JsonObject? findEntity({
    required String entityName,
    required String attrName,
    required String attrValue,
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
  /// Pre: entityName.length > 0 and attrName.length > 0
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

/// Inv: content[ 'entities'][ entityName ] exists
class _DbOperation {
  JsonObject content;
  final String entityName;

  void _checkInv() => assert( content[ 'entities' ]?[ entityName ] != null ) ;

  List get entityList
    => ( (content['entities'] as JsonObject)[entityName] as List ) ;

  _DbOperation({
    required this.content,
    required this.entityName,
  }) {
    _checkInv() ;
  };

  JsonObject? findEntity({
    required String attrName,
    required String attrValue,
  }) {
    _checkInv()
    var entityAlreadyExists = true;

    var entityFound =
        entityList.firstWhere((row) => row[attrName] == attrValue, orElse: () {
      entityAlreadyExists = false;
      return entityList.first;
    });

    _checkInv()
    return entityAlreadyExists ? entityFound : null;
  }

  bool insert( JsonObject data, { required String pkName } ) {
    _checkInv()
    if ( entityList.where(
      ( element ) => element[ pkName ] == data[ pkName ]
    ).isNotEmpty ) {
      return false ;
    }

    entityList.add( data ) ;
    _checkInv()
    return true ;
  }
}
