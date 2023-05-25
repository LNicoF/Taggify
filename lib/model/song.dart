class Song {
  String? id ;
  late String name, src ;

  Song( this.name, this.src ) ;

  Song.populate( Map< String, dynamic > data ) {
    throw UnimplementedError() ;
  }

  Map< String, dynamic > dump() {
    throw UnimplementedError() ;
  }
}
