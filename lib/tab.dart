import 'package:flutter/material.dart';

class TabStructure {
  final String label ;
  final Icon   icon ;
  final Widget body ;

  const TabStructure( {
    required this.label,
    required this.icon,
    required this.body
  } );
}
