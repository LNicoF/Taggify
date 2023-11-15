import 'package:flutter/material.dart';
import 'package:taggify/model/song_repository.dart';
import 'package:taggify/model/tag_repository.dart';
import 'package:taggify/queue_page.dart';
import 'package:taggify/songs_page.dart';
import 'package:taggify/tags_page.dart';

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
  int _tabIndex = 0 ;

  final _tabs = const < NavigationDestination >[
    QueuePage.tab,
    TagsPage.tab,
    SongsPage.tab,
  ] ;

  NavigationBar get _navigationBar => NavigationBar(
    key: const Key( 'navigation_bar' ),
    destinations: _tabs.map( ( tab ) => NavigationDestination(
      key: Key( 'navigate_${tab.label.toLowerCase()}'),
      icon: tab.icon,
      label: tab.label,
    ) ).toList(),
    selectedIndex: _tabIndex,
    onDestinationSelected: ( i ) { _changeTab( i ) ; },
  ) ;

  AppBar get _appBar => AppBar(
    title: Text( _tabs[ _tabIndex ].label ),
    centerTitle: true,
  ) ;

  late final _pageBuilders = < Widget Function() >[
    () => QueuePage(
      navigationBar: _navigationBar,
    ),

    () => TagsPage(
      tagRepository: widget._tagRepository,
      navigationBar: _navigationBar,
    ),

    () => SongsPage(
      songRepository: widget._songRepository,
      appBar: _appBar,
      navigationBar: _navigationBar,
    ),
  ] ;

  void _changeTab( final int newIndex ) {
    setState(() {
      _tabIndex = newIndex ;
    });
  }

  @override
  Widget build(BuildContext context) {
    final buildPage = _pageBuilders[ _tabIndex ] ;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: buildPage(),
    );
  }
}
