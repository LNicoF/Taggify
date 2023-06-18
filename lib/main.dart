import 'package:flutter/material.dart';
import 'package:taggify/framework/json_database.dart';
import 'package:taggify/model/song_repository.dart';
import 'package:taggify/model/tag_repository.dart';
import 'package:taggify/tags_list_page.dart';

void main() {
  final db = JsonDb.fromString('''
  {
    "entities": {
      "songs": [
        {
          "id": "1123467",
          "name": "locura",
          "src": "path/to/maddness"
        },
        {
          "id": "4567898",
          "name": "asdf",
          "src": "path/to/irrelevance"
        }
      ],
      "tags": [
        {
          "id": "678934",
          "name": "energic shit"
        },
        {
          "id": "917239",
          "name": "sad shit"
        }
      ]
    }
  }
  ''') ;
  final songRepo = SongRepository( db ) ;
  final tagRepo  = TagRepository( db ) ;

  runApp(MyApp(
    songRepository: songRepo,
    tagRepository: tagRepo,
  ));
}

class MyApp extends StatelessWidget {
  final SongRepository songRepository ;
  final TagRepository  tagRepository ;

  const MyApp({
    super.key,
    required this.songRepository,
    required this.tagRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: TagsListPage(
        tagRepository: tagRepository,
      ),
    );
  }
}
