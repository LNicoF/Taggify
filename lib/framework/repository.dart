import 'package:uuid/uuid.dart';

import 'json_database.dart';

typedef EntityData = Map< String, dynamic > ;

class Repository {
  final String _entityName ;
  final String _entityPKName ;

  final JsonDb _db ; // implement

  static bool dontFilter( element ) => true ;

  Repository( {
    required JsonDb db,
    required entityName,
    entityPkName = 'id',
  }) :
    _db = db,
    _entityName = entityName,
    _entityPKName = entityPkName ;

  Future<EntityData?> loadFromId( final String id ) async {
    var entitySet = _db.getEntitySet( _entityName ) ;
    var entityWasntFound = false ;
    var entity = entitySet.firstWhere(
      ( e ) => ( e[ 'id' ] as String ) == id,
      orElse: () {
        entityWasntFound = true ;
        return entitySet.first ;
      }
    ) ;
    if ( entityWasntFound ) {
      return null ;
    }

    return entity ;
  }

  Future<List<EntityData>> loadCollection( {
    bool Function( EntityData ) filter = dontFilter,
  } ) async {
    return _db.getEntitySet( _entityName )
              .where( filter )
              .toList() ;
  }

  Future<EntityData> save( EntityData data ) async {
    bool hasGeneratedId = false ;
    if( data[ 'id' ] == null ) {
      data[ 'id' ] = ( const Uuid() ).v4() ;
      hasGeneratedId = true ;
    }

    bool ok = _db.saveEntity(
      entityName: _entityName,
      pkName:     _entityPKName,
      data:       data
    ) ;
    if ( !ok ) {
      if ( hasGeneratedId ) {
        data.remove( 'id' ) ;
      } else {
        throw Exception ;
      }
    }
    return data ;
  }

  Future<bool> delete( EntityData entity ) async {
    return false ;
  }
}
