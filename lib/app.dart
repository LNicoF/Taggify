import 'package:flutter/material.dart';
import 'package:taggify/model/song_repository.dart';
import 'package:taggify/model/tag_repository.dart';
import 'package:taggify/tab.dart';

class App extends StatefulWidget {
  final SongRepository _songRepository ;
  final TagRepository  _tagRepository ;

  const App({
    super.key,
    required SongRepository songRepository,
    required TagRepository tagRepository,
  }) : _tagRepository = tagRepository, _songRepository = songRepository;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int selectedIndex = 0 ;

  final _tabs = const < TabStructure >[
    // Queue
    TabStructure(
      label: 'Home',
      icon: Icon( Icons.queue_music ),
      body: Text( 'Queue' ),
    ),

    // Tags
    TabStructure(
      label: 'Tags',
      icon: Icon( Icons.label ),
      body: Text( 'Tags' ),
    ),

    // Songs
    TabStructure(
      label: 'Songs',
      icon: Icon( Icons.music_note ),
      body: Text( 'Songs' ),
    ),
  ] ;

  late final _navigationBar = NavigationBar(
    destinations: _tabs.map( ( tab ) => NavigationDestination(
      icon: tab.icon,
      label: tab.label,
    ) ).toList(),
  ) ;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
        bottomNavigationBar: _navigationBar,
      ),
    );
  }
}
