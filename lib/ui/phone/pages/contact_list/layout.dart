// This this the home page of the app, and when the app starts the user
// this would be the page the user sees.

import 'package:flutter/material.dart';
import 'package:contact_box/generated/l10n.dart';

import './list.dart';

/*
 * Scaffold ContactListPage Stateless{
 *   appBar: ...
 *   body: ...
 * }
 */
// The page object.
class ContactListPage extends StatelessWidget{
  const ContactListPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(I18nS.of(context).contactList),
      ),

      body: const ContactList() // See `./list.dart`.
      // body: Body()
    );
  }
}