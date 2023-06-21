import 'package:flutter/material.dart';
import 'package:taggify/model/song.dart';
import 'package:taggify/model/tag.dart';
import 'package:taggify/model/tag_repository.dart';

class SongDetailsPage extends StatelessWidget {
  final Song _song ;
  final TagRepository     _tagRepository ;

  const SongDetailsPage( {
    super.key,
    required Song              song,
    required TagRepository     tagRepository,
  } ) :
    _song              = song,
    _tagRepository     = tagRepository ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Row( children: [
                const Text( 'Name' ),
                Text( _song.name )
            ],),
            Row( children: [
                const Text( 'Name' ),
                Text( _song.name )
            ],),
            FutureBuilder(
              future: _tagRepository.loadAllForSong( _song ),
              builder: (context, tagListSnapshot) {
                if ( tagListSnapshot.hasData ) {
                  return buildTagList( tagListSnapshot.data! ) ;
                } else {
                  return const Text( 'No tags' ) ;
                }
              },
            )
          ],
        ),
      ),
    ) ;
  }

  Widget buildTagList( List< Tag > tags ) {
    return Wrap(
      children: [
        for ( final tag in tags )
          InputChip(label: Text( tag.name ) ),
      ],
    ) ;
    /**
    return Wrap(
      children: [
        for ( final tag in tags.map(
          ( tagSong ) => tagSong.getTag( repository: _tagRepository )
        ) )
          TagChip(tag: tag),
      ],
    ) ;
    */
  }
}

class TagChip extends StatelessWidget {
  final Future< Tag > tag ;

  const TagChip( {
    super.key,
    required this.tag,
  } ) ;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: tag,
      builder: (context, tagSnapshot ) {
        if ( tagSnapshot.hasData ) {
          return InputChip(
            label: Text( tagSnapshot.data!.name ),
          ) ;
        }
        return const SizedBox() ;
      },
    ) ;
  }
}