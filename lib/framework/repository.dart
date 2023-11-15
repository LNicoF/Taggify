import 'package:uuid/uuid.dart';

import 'json_database.dart';

typedef EntityData = Map< String, dynamic > ;

/// Inv: for each e in the entity set, e[ pkName ] exists
class Repository {
  final String _entityName ;
  final String _entityPKName ;

  final JsonDb _db ;

  static bool dontFilter( element ) => true ;

  void _checkInv() => assert( _db.getEntitySet( _entityName ).every( ( e ) => e[ _entityPKName ] != null ) ) ;

  Repository( {
    required JsonDb db,
    required entityName,
    entityPkName = 'id',
  }) :
    _db = db,
    _entityName = entityName,
    _entityPKName = entityPkName
  {
    _checkInv() ;
  }

  /// Pre: entity set contains an entity with [entityPkName] = [id]
  /// Post: data[ entityPkName ] = [id] and returns data
  Future<EntityData?> loadFromId( final String id ) async {
    _checkInv() ;
    var entitySet = _db.getEntitySet( _entityName ) ;
    var entityWasntFound = false ;
    var entity = entitySet.firstWhere(
      ( e ) => ( e[ 'id' ] as String ) == id,
      orElse: () {
        entityWasntFound = true ;
        _checkInv() ;
        return entitySet.first ;
      }
    ) ;
    if ( entityWasntFound ) {
      _checkInv() ;
      return null ;
    }

    _checkInv() ;
    return entity ;
  }

  /// Post: for each e in res, filter( e ) = true
  Future<List<EntityData>> loadCollection( {
    bool Function( EntityData ) filter = dontFilter,
  } ) async {
    _checkInv() ;
    return _db.getEntitySet( _entityName )
              .where( filter )
              .toList() ;
  }

  /// Pre: data != {}
  Future<EntityData> save( EntityData data ) async {
    _checkInv() ;
    if ( data == {} ) {
      return data ;
    }
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
    _checkInv() ;
    return data ;
  }

  Future<bool> delete( String id ) async {
    return _db.deleteEntity(
      entityName: _entityName,
      attrName:   _entityPKName,
      attrValue:  id,
    ) ;
  }
}
