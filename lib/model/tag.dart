class Tag {
  String? id ;
  late String name ;

  Tag( { required this.name } ) ;

  Tag.populate( Map< String, dynamic > data ) {
    id =   data[ 'id' ] as String ;
    name = data[ 'name' ] as String ;
  }

  Map< String, dynamic > dump() => {
    "id":   id,
    "name": name,
  } ;
}