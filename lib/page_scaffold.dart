import 'package:flutter/material.dart';

class PageScaffold extends StatelessWidget {
  final Widget? floatingActionButton;

  const PageScaffold( {
    super.key,
    this.floatingActionButton,
  } );

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of( context ).colorScheme.primary ;
    final tabs = < Tab >[
      Tab(
        icon: Icon(
          Icons.home,
          color: primaryColor,
        ),
        text: 'Home',
      ),
      Tab(
        icon: Icon(
          Icons.music_note_outlined,
          color: primaryColor,
        ),
        text: 'Songs',
      ),
      Tab(
        icon: Icon(
          Icons.label_outline,
          color: primaryColor,
        ),
        text: 'Tags',
      ),
    ] ;

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: TabBar(
            tabs: tabs,
          ),
        ),
        floatingActionButton: floatingActionButton,
        body: TabBarView(
          children: tabs.map(
            ( Tab tab ) => Text( '${ tab.text }')
          ).toList(),
        )
      ),
    ) ;
  }
}