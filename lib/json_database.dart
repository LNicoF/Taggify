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

  Set< JsonObject > getEntitySet( final String entityName ) {
    var entities = content[ 'entities' ] as JsonObject ;
    return Set.of( entities[ entityName ] as List< JsonObject > ) ;
  }
}
