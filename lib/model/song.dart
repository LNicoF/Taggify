class Song {
  String? id ;
  late String name, src ;

  Song( this.name, this.src ) ;

  Song.populate( Map< String, dynamic > data ) {
    id =   data[ 'id' ] as String ;
    name = data[ 'name' ] as String ;
    src =  data[ 'src' ] as String ;
  }

  Map< String, dynamic > dump() => {
    'id':   id,
    'name': name,
    'src':  src,
  } ;
}
