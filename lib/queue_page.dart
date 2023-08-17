import 'package:flutter/material.dart';

class QueuePage extends StatelessWidget {
  final NavigationBar? _navigationBar ;

  static const tab = NavigationDestination(
    label: 'Queue',
    icon: Icon(Icons.queue_music),
  ) ;

  const QueuePage( {
    super.key,
    NavigationBar? navigationBar,
  } ) : _navigationBar = navigationBar ;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _navigationBar,
      body: Center(
        child: Text( 'Unimplemented Page',
          style: Theme.of( context ).textTheme.displayMedium!
        )
      )
    ) ;
  }
}
