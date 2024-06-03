// This file defines what a contact object includes.

import 'package:contact_box/core/cpp/contact_prop_content.dart';
import 'package:uuid/v4.dart';
import './cpp/contact_prop.dart';
import './contact_tag.dart';
// import './contact_avatar.dart';

// You may notice there are two "UUID"s here, one built within the
// `ContactPropContent` object, and another as the key of the map. That's
// because the UUID within the `ContactPropContent` object is used to
// distinguish between different contact properities, and the UUID as the
// key of the map is to distinguish the different properities if a contact.
class Contact{
  String name;
  // String here is a uuid value.
  Map<String, ContactProp> properties;
  // ContactAvatar avatar; // A possible feature in the future.
  // Tags of the contact.
  List<ContactTag> tags;

  Contact._(this.name, this.properties/*, this.avatar*/, {this.tags = const[]});

  // When needing to create a new contact.
  factory Contact.create(String name){
    Map<String, ContactProp> properties = {};
    // At very first the contact has no avatar.
    // ContactAvatar avatar = NoAvatar();
    return Contact._(name, properties/*, avatar*/);
  }

  // Read a contact with provided data.
  factory Contact.read(
    String name,
    Map<String, ContactProp> props,
    {List<ContactTag> tags = const []}
  ){
    return Contact._(name, props, tags: tags);
  }

  // Add a properity to the contact. An UUID to distinguish this properity
  // and other properities will be created automatically.
  void addAProperity(ContactProp properity){
    const UuidV4 uuidObject = UuidV4();
    String uuid = uuidObject.toString();
    properties.addAll({uuid: properity});
  }

  // Changes the description and content of one properity.
  void changeDescription(String uuid, String description){
    properties[uuid]?.changeDescription(description);
  }
  void changeContent(String uuid, ContactPropContent content){
    properties[uuid]?.changeContent(content);
  }
}