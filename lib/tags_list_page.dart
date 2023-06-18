import 'package:flutter/material.dart';
import 'package:taggify/model/tag.dart';
import 'package:taggify/model/tag_repository.dart';

class TagsListPage extends StatelessWidget {
  final TagRepository tagRepository ;

  const TagsListPage( {
    super.key,
    required this.tagRepository,
  } );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: tagRepository.loadAll(),
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
