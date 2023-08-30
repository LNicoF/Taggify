import 'package:flutter/material.dart';
import 'package:taggify/model/tag.dart';

import 'model/tag_repository.dart';

class TagsPage extends StatelessWidget {
  final TagRepository  _tagRepository ;
  final NavigationBar? _navigationBar ;

  static const tab = NavigationDestination(
    label: 'Tags',
    icon: Icon(Icons.label),
  ) ;

  const TagsPage( {
    super.key,
    required TagRepository tagRepository,
    NavigationBar? navigationBar,
  } ) : _tagRepository = tagRepository,
        _navigationBar = navigationBar ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _navigationBar,
      body: FutureBuilder(
        future: _tagRepository.loadAll(),
        builder: ( context, tagListSnapshot ) {
          if ( tagListSnapshot.hasData ) {
            return buildTagList( tagListSnapshot.data! ) ;
          }
          return const Center(
            child: Text( 'No tags found' ),
          ) ;
        },
      ),
    ) ;
  }

  Widget buildTagList( List< Tag > tagList ) {
    return ListView(
      children: [
      for ( final tag in tagList )
        ListTile(
          title: Text( tag.name ),
          trailing: IconButton(
            onPressed: () {
              showMenuForTag( tag ) ;
            },
            icon: const Icon( Icons.more_vert ),
          ),
        )
      ],
    ) ;
  }

  void showMenuForTag( Tag tag ) {
  }
}
