// The actual contact list.
// This project uses `azlistview` to show the contact list.

import 'package:flutter/material.dart';
import 'package:azlistview/azlistview.dart';
// import 'package:uuid/v4.dart';

import 'package:contact_box/core/io/sqlite.dart';
import 'package:contact_box/shared/global_objects.dart';
// import 'package:contact_box/core/contact.dart';

/*
 * First let's see how an item of the list consists of.
 * The are two statuses of a list: normal mode and select mode.
 * On the normal mode, when tapping a contact item, a page of the detailed
 * info will be shown, and on the select mode, the users will see a checkbox
 * on the right side of the item, and they would be able to select the users
 * and do the bulk operation.
 */

// The item of `azlistview` has to extend `ISuspensionBean`. This is for the
// normal mode.
class _ContactListItem extends ISuspensionBean{
  String uuid;
  String name;
  String tagIndex; // The first letter of the _name_.

  _ContactListItem(this.uuid, this.name);
  
  @override
  String getSuspensionTag() {
    // Actually I'm not clear what's this method used for. But it's required.
    throw UnimplementedError();
  }
}

// And this is for the select mode.
// As `ContactListItemWithSelection` extends `ContactListItem`, when it
// meets the case that both classes have to be considered, just use
// `ContactListItem` to refer to the bath will be okay.
class _ContactListItemWithSelection extends _ContactListItem{
  bool beenSelected = false;

  _ContactListItemWithSelection(super.uuid, super.contact);
}

// Then let's see how an item is shown. It's done by an independent function
// here.
// Attention `_buildListItem()` judges whether it's on normal mode or select
// mode just by the type of the object `contact` rather than the status
// variable. Consider an excessive case: When it's on the normal mode, but
// the parameter is a `_ContactListItemWithSelection` object, it will
// shows a "checkbox" on the right of the item.
Widget _buildListItem(_ContactListItem contact){
  // Judge the type of the object first. When it's on normal mode:
  if (contact is! _ContactListItemWithSelection) {
    return ListTile(
      // The main context of the item would be the contact's name.
      title: Text(contact.name),

      // TODO: onTap: jump to the detailed page.
      // TODO: onLongPress: jump to select mode.
    );
  }
  // Or when it's on select mode:
  else {
    return ListTile(
      title: Text(contact.name),
      // The difference of select mode is that there would be a checkbox
      // on the right side.
      // TODO: trailing: a checkbox.

      // TODO: onTap: change the status of whether it's selected.
      // No `onLongPress()` needed.
    );
  }
}

// The list object to show.
class ContactList extends StatefulWidget{
  const ContactList({super.key});

  @override
  State<StatefulWidget> createState(){
    return _ContactListState();
  }
}

class _ContactListState extends State<ContactList>{
  List<_ContactListItem> _contacts = [];
  final double subItemHeight = 40;

  // When a contact list is initialized, it reads all the contacts from the
  // database.
  @override
  Future<void> initState() async{
    super.initState();
    // TODO: load data from the database.
    ContactDatabaseObject db = await SharedDatabase.of(context)!
      .contactDatabase;
    var contacts = await db.readAllNames();
    for (String uuid in contacts.keys){
      if(contacts[uuid]!=null){
        _contacts.add(_ContactListItem(uuid, contacts[uuid]!));
      }
    }

    _sort();
  }

  Future<void> _sort() async{
    if(_contacts.isEmpty) return;
    for (int i=0; i<_contacts.length; i++){
      // TODO: Romanization.
    }
  }

  // What an item of 
  @override
  Widget build(BuildContext context){
    return AzListView(
      // The data about the actual contacts.
      data: _contacts,
      itemCount: _contacts.length,

      // A function to build each item of the list.
      itemBuilder: (BuildContext context, int index){
        return _buildListItem(_contacts[index]);
      },

      // Physical effect of scrolling. 
      physics: const BouncingScrollPhysics()
    );
  }
}