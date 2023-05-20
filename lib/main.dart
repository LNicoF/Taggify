import 'package:flutter/material.dart';
import 'package:taggify/song_list_page.dart';

void main()
  => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const SongListPage(),
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
