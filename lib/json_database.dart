import 'dart:convert' show jsonEncode, jsonDecode ;
import 'dart:io';

typedef JsonObject = Map< String, dynamic > ;

class JsonDb {
  JsonObject content = {} ;

  JsonDb() ;

  JsonDb.fromString( final String initialContent ) {
    content = jsonDecode( initialContent ) as JsonObject ;
  }

  JsonDb.fromFile( File file ) {
    throw UnimplementedError ;
  }

  Future<String> dump() async {
    throw UnimplementedError ;
  }

  void dumpIntoFile( File file ) async {
    throw UnimplementedError ;
  }

  /// Returns the [entityName] entity set
  Set< JsonObject > getEntitySet( final String entityName ) {
    var database   = content[ 'entities' ] as JsonObject ;
    var entityList = database[ entityName ] as List ;
    return Set.of( entityList.map( ( row ) => row as JsonObject ) ) ;
  }

  /// Saves the data in [data] into the entity set
  /// [entityName], which's primary key is [pkName]
  bool saveEntity( {
    required String     entityName,
    required String     pkName,
    required JsonObject data,
  } ) {
    if ( data[ pkName ] == null ) {
      return false ;
    }

    var entity = _findEntity(
      entityName: entityName,
      attrName:   pkName,
      attrValue:  data[ pkName ] as String,
    ) ;

    if ( entity == null ) {
      return _saveNewEntity( entityName: entityName, data: data ) ;
    }
    return _updateEntity( entity: entity, newData: data ) ;
  }

  /// Updates the JsonObject [entity] with the data
  /// in [newData]
  bool _updateEntity( {
    required JsonObject entity,
    required JsonObject newData,
  } ) {
    entity.addAll( newData ) ;
    return true ;
  }

  /// Adds into the entity set with the name [entityName]
  /// a new row with the data [data]
  bool _saveNewEntity( {
    required String     entityName,
    required JsonObject data,
  } ) {
    var entitySet = getEntitySet( entityName ) ;
    return entitySet.add( data ) ;
  }

  /// If the entity with the attribute named [attrName]
  /// and value [attrValue] exists, returns the entity JsonObject;
  /// otherwise, returns null
  JsonObject? _findEntity( {
    required String entityName,
    required String attrName,
    required String attrValue,
  } ) {
    var entitySet = getEntitySet( entityName ) ;
    var entityAlreadyExists = true ;

    var entityFound = entitySet.firstWhere(
      ( row ) => row[ attrName ] == attrValue,
      orElse: () {
        entityAlreadyExists = false ;
        return entitySet.first ;
      }
    ) ;

    return entityAlreadyExists
      ? entityFound
      : null ;
  }
}
