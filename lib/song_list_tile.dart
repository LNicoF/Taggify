import 'package:flutter/material.dart';
import 'package:taggify/delete_button.dart';
import 'package:taggify/model/song.dart';
import 'package:taggify/song_form_dialog.dart';

class SongListTile extends StatelessWidget {
  const SongListTile({
    super.key,
    required this.song,
    required this.deleteSong,
    required this.saveSong,
  });

  final Song song;
  final void Function( Song song ) deleteSong ;
  final void Function( Song song ) saveSong ;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        onPressed: () {},
        icon: const Icon( Icons.play_arrow ),
      ),

      title: Text( song.name ),
      subtitle: Text( song.src ),

      trailing: MenuAnchor(
        builder: ( context, menu, child ) => IconButton(
          onPressed: () {
            if ( menu.isOpen ) {
              menu.close() ;
            } else {
              menu.open() ;
            }
          },
          icon: const Icon( Icons.more_vert )
        ) ,

        menuChildren: [
          MenuItemButton( // Details
            onPressed: () {},

            leadingIcon: const Icon( Icons.info ),
            child: const Text( 'Details' ),
          ),

          MenuItemButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: ( cotext ) => SongFormDialog(
                  fromSong: song,
                  saveSong: saveSong,
                ),
              ) ;
            },

            leadingIcon: const Icon( Icons.edit ),
            child: const Text( 'Edit' ),
          ),

          DeleteMenuItemButton(
            onPressed: () => deleteSong( song ),
          ),
        ],
      )
    ) ;
  }
}
