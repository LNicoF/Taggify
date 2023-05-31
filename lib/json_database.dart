import 'dart:convert' show jsonEncode, jsonDecode;
import 'dart:io';

typedef JsonObject = Map<String, dynamic>;

class JsonDb {
  JsonObject content = {};

  JsonDb();

  JsonDb.fromString(final String initialContent) {
    content = jsonDecode(initialContent) as JsonObject;
  }

  JsonDb.fromFile(File file) {
    throw UnimplementedError;
  }

  Future<String> dump() async {
    throw UnimplementedError;
  }

  void dumpIntoFile(File file) async {
    throw UnimplementedError;
  }

  /// Returns the [entityName] entity set
  Set<JsonObject> getEntitySet(final String entityName) {
    return _DbOperation(content: content, entityName: entityName)
        .getEntitySet();
  }

  /// Saves the data in [data] into the entity set
  /// [entityName], which's primary key is [pkName]
  bool saveEntity({
    required String entityName,
    required String pkName,
    required JsonObject data,
  }) {
    if (data[pkName] == null) {
      return false;
    }

    var entity = _findEntity(
      entityName: entityName,
      attrName: pkName,
      attrValue: data[pkName] as String,
    );

    if (entity == null) {
      return _DbOperation(
        content: content, entityName: entityName
      ).insert( data, pkName: pkName) ;
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
  JsonObject? _findEntity({
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
}

class _DbOperation {
  JsonObject content;
  final String entityName;

  List< JsonObject > get entityList
    => (['entities'] as JsonObject)[entityName] as List< JsonObject > ;

  _DbOperation({
    required this.content,
    required this.entityName,
  });

  JsonObject? findEntity({
    required String attrName,
    required String attrValue,
  }) {
    var entityAlreadyExists = true;

    var entityFound =
        entityList.firstWhere((row) => row[attrName] == attrValue, orElse: () {
      entityAlreadyExists = false;
      return entityList.first;
    });

    return entityAlreadyExists ? entityFound : null;
  }

  bool insert( JsonObject data, { required String pkName } ) {
    if ( entityList.where( ( element ) => element[ pkName ] )
                   .isNotEmpty ) {
      return false ;
    }

    entityList.add( data ) ;
    return true ;
  }
}
