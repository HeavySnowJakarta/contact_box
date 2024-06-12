// Some shared objects of the project.

import 'package:flutter/material.dart';

import 'package:contact_box/core/io/sqlite.dart';

// `SharedDatabase` contains some database objects which provides methods to
// operate the `sqlite` database.
// TODO: Finish how to share dark info
class SharedDatabase extends InheritedWidget{
  final Future<ContactDatabaseObject> contactDatabase
    = ContactDatabaseObject.generate();
  final Future<TagDatabaseObject> tagDatabase
    = TagDatabaseObject.generate();

  SharedDatabase({super.key, required super.child});

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  // Get the context of it.
  static SharedDatabase? of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<SharedDatabase>();
  }
}