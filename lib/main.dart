import 'package:flutter/material.dart';
import 'framework/json_database.dart';
import 'model/song_repository.dart';
import 'model/tag_repository.dart';
import 'song_list_page.dart';
import 'tags_list_page.dart';

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
      home: TabbedTemplate(
        tagRepository: tagRepository,
        songRepository: songRepository,
      ),
    );
  }
}

///
/// This class contains what's common to all pages in the app
///
class TabbedTemplate extends StatefulWidget {
  final List< Widget > pages ;

  TabbedTemplate( {
    super.key,
    required SongRepository songRepository,
    required TagRepository  tagRepository,
  } ):
    pages = [
      const UnimplementedPage(),
      SongListPage( songRepository: songRepository ),
      TagsListPage( tagRepository: tagRepository ),
    ] ;

  @override
  State<TabbedTemplate> createState() => _TabbedTemplateState();
}

class _TabbedTemplateState extends State<TabbedTemplate> {
  int selectedIndex = 0 ;
  get pages => widget.pages;

  @override
  void initState() {
    super.initState();
  }

  void changeTab( int index ) {
    setState(() {
      selectedIndex = index ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: TabsBar(
        selectedIndex: selectedIndex,
        onTap: ( index ) => changeTab( index ),
      ),
      body: pages[ selectedIndex ],
    ) ;
  }
}

class TabsBar extends StatelessWidget {
  final void Function(int)? onTap ;
  final int selectedIndex;

  const TabsBar({
    super.key,
    required this.selectedIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon( Icons.play_arrow_rounded ),
          label: 'Play',
        ),
        BottomNavigationBarItem(
          icon: Icon( Icons.music_note_rounded ),
          label: 'Songs',
        ),
        BottomNavigationBarItem(
          icon: Icon( Icons.label_rounded ),
          label: 'Tags',
        ),
      ],
    );
  }
}

class UnimplementedPage extends StatelessWidget {
  const UnimplementedPage( { super.key } ) ;

  @override
  Widget build( BuildContext context ) {
    return Center(
      child: Text( 'UnimplementedPage',
        style: Theme.of( context ).textTheme.displayMedium
      ),
    ) ;
  }
}
