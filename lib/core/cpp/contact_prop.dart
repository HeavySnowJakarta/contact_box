// This file defines each properity of a contact. It combines the UUID to
// find out what the properity actually is, the description to say what it's
// used to, and the actual content.
// TODO: When defining the content it does not check if it fits the pattern.
// This can only be done after it searches the array of the profiles.

import 'package:uuid/v4.dart';
import './contact_prop_content.dart';

class ContactProp{
  final UuidV4 uuid; // Actually the UUID of the properity profile.
  String description;
  ContactPropContent content;

  // So we are not going to generate a UUID when creating a ContactProp
  // object.
  ContactProp(this.uuid, this.description, this.content);

  // The description and the content may changes as time goes by.
  void changeDescription(String description){
    this.description = description;
  }
  void changeContent(ContactPropContent content){
    this.content = content;
  }
}