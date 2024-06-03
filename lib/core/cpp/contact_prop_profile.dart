// This file defines what a profile of a contact properity includes.

import "package:uuid/v4.dart";
import "contact_prop_type.dart";

class ContactPropProfile{
  final UuidV4 uuid;
  final String name;
  final String description;
  final ContactPropType type;
  final String outlink;

  const ContactPropProfile.load(
    this.uuid,
    this.description,
    this.name,
    this.type,
    this.outlink
  );

  factory ContactPropProfile.create(name, description, type, outlink){
    const UuidV4 uuid = UuidV4();
    return ContactPropProfile.load(uuid, name, description, type, outlink);
  }
}