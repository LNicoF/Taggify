import 'package:flutter/material.dart';
import 'package:taggify/model/song.dart';

class SongListTile extends StatelessWidget {
  const SongListTile({
    super.key,
    required this.song,
    required this.deleteSong,
  });

  final Song song;
  final void Function( Song song ) deleteSong ;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        onPressed: () {},
        icon: const Icon( Icons.play_arrow ),
      ),

      title: Text( song.name ),
      subtitle: Text( song.src ),

      trailing: IconButton(
        onPressed: () => deleteSong( song ),
        icon: Icon( Icons.delete,
          color: Theme.of( context ).colorScheme.error,
        ),
      ),
    ) ;
  }
}
