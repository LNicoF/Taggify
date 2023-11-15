import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart' ;
import 'package:taggify/app.dart';
import 'package:taggify/framework/json_database.dart';
import 'package:taggify/model/song_repository.dart';
import 'package:taggify/model/tag_repository.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized() ;

  group( 'end-to-end test', () {
    late App app ;

    setUp(() {
      final db = JsonDb.fromString('''
        { "entities": { "songs": [], "tags": [] } }
      ''') ;
      final songRepo = SongRepository( db ) ;
      final tagRepo  = TagRepository( db ) ;

      app = App(
        songRepository: songRepo,
        tagRepository: tagRepo,
      ) ;
    }) ;
    testWidgets('Pressing the bottom navigation buttons changes pages', (tester) async {
      await tester.pumpWidget( app ) ;
      expect(find.byKey( const Key( 'navigate_queue' )), findsOneWidget) ;
      expect(find.byKey( const Key( 'navigate_tags' )), findsOneWidget) ;
      expect(find.byKey( const Key( 'navigate_songs' )), findsOneWidget) ;

      expect(find.byKey( const Key( 'navigation_bar' )), ) ;

    });
  }) ;
}