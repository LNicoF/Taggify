import 'package:flutter/material.dart';
import 'package:taggify/json_database.dart';
import 'package:taggify/model/song_repository.dart';
import 'package:taggify/song_list_page.dart';

void main() {
  final db = JsonDb() ;
  final songRepo = SongRepository( db ) ;

  runApp(MyApp(
    songRepository: songRepo,
  ));
}

class MyApp extends StatelessWidget {
  final SongRepository songRepository ;

  const MyApp({super.key, required this.songRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: SongListPage(
        songRepository: songRepository,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title ;

  const MyHomePage( {
    super.key,
    required this.title,
  } );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( title ),
      ),
      body: null,
    ) ;
  }
}
