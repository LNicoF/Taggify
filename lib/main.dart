import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:taggify/framework/json_database.dart';
import 'package:taggify/model/song.dart';
import 'package:taggify/model/song_repository.dart';
import 'package:taggify/model/tag_repository.dart';
import 'package:taggify/song_details_page.dart';

void main() async {
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
      ],
      "song_tag": [
        {
          "id": "1290983",
          "song_id": "1123467",
          "tag_id": "678934"
        },
        {
          "id": "12381119",
          "song_id": "1123467",
          "tag_id": "4567898"
        }
      ]
    }
  }
  ''') ;
  final songRepo    = SongRepository( db ) ;
  final tagRepo     = TagRepository( db ) ;

  final exampleSong = await songRepo.loadFromId( "1123467" ) ;

  print( await tagRepo.loadAllForSong( exampleSong! ) ) ;

  return ;
  runApp( MyApp(
    songRepository:    songRepo,
    tagRepository:     tagRepo,
    exampleSong:       exampleSong,
  ));
}

class MyApp extends StatelessWidget {
  final SongRepository    songRepository ;
  final TagRepository     tagRepository ;
  final Song              exampleSong ;

  const MyApp({
    super.key,
    required this.songRepository,
    required this.tagRepository,
    required this.exampleSong,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: SongDetailsPage(
        song: exampleSong,
        tagRepository: tagRepository
      ),
    );
  }
}
