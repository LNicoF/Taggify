import 'package:flutter/material.dart';

import 'page_scaffold.dart';
import 'song_list_page.dart';

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage( {
    super.key,
  } );

  @override
  Widget build(BuildContext context) {
    return const PageScaffold() ;
  }
}