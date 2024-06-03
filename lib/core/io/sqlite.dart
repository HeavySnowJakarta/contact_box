// This file defines some methods to operate the SQLite database.

// I use `sqlite3` instead of `sqflite` because it's cross-platform between
// mobile and PC systems.
import 'package:sqlite3/sqlite3.dart';

import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';
import 'package:flutter/material.dart' hide Row;

import 'package:contact_box/core/contact.dart';
import 'package:contact_box/core/contact_tag.dart';
import 'package:contact_box/core/cpp/contact_prop.dart';
import 'package:contact_box/core/exceptions.dart';


// As we have to power a sqlite3 object, let's encapsulate the functions as
// a class.
// On the following classes, We set the constructor private because we want the operation to read the
// database to be asynchronus. So you can see this structure:
/* 
 * DatabaseObject._() : super(/*sth*/);
 * static Future<DatabaseObject> generate() async;
 */
// That's to say, the user can only use the asynchronus methods to generate
// and operate the database.
abstract class DatabaseObject{
  final Database database;

  DatabaseObject(this.database);

  // Close the database when being disposed.
  void dispose(){
    database.dispose();
  }
}

// Contact database manager class.
class ContactDatabaseObject extends DatabaseObject{
  // This class operates the file "contact.sqlite".
  ContactDatabaseObject._() : super(sqlite3.open('contact.sqlite')){
    // Create the database table automatically.
    // Among them, `id` is a UUIDv4 object, `props` is a JSON object.
    // Note: Avatars are not provided here as it's a probably feature in the
    // future.
    database.execute(
      """
        CREATE TABLE IF NOT EXIST contacts(
          id TEXT PRIMARY KEY,
          name TEXT,
          avatar TEXT,
          props TEXT,
          tags TEXT
        );
      """
    );
  }

  static Future<ContactDatabaseObject> generate() async{
    return ContactDatabaseObject._();
  }

  // Read all the contacts from the database, including the name and all
  // properities.
  Future<Map<String, Contact>> readAllContacts() async{
    // Get the result data and generate the empty result container.
    ResultSet rows = database.select("SELECT * FROM contacts;");
    Map<String, Contact> result = {};

    // Add the result to the result container.
    for (Row row in rows){
      // Get the uuid and see if it's valid.
      final String uuid = row["id"];
      if (!Uuid.isValidUUID(fromString: uuid)){
        throw NonValidUuidException(uuid);
      }

      // Read the name and properities.
      final String name = row["name"];
      final Map<String, ContactProp> props = jsonDecode(row["props"]);
      final List<ContactTag> tags = jsonDecode(row["tags"]);
      final Contact contact = Contact.read(name, props, tags: tags);
      result[uuid] = contact;
    }

    return result;
  }

  // Read all the names of the contacts from the database. Mainly used when
  // generating the list of the contacts.
  // The first string stands for the UUID value while the second one stands
  // for the name.
  // MAYBE AVATAR IN THE FUTURE.
  Future<Map<String, String>> readAllNames() async{
    // Get the result data and generate an empty result container.
    ResultSet rows = database.select("SELECT id, name FROM contacts;");
    Map<String, String> result = {};

    // Add the results to the container.
    for (Row row in rows){
      // The uuid and see if it's valid.
      final String uuid = row["id"];
      if(!Uuid.isValidUUID(fromString: uuid)){
        throw NonValidUuidException(uuid);
      }

      // Read the name.
      final String name = row["name"];
      result[uuid] = name;
    }

    return result;
  }

  // Add a contact to the database. A uuid would be generated automatically.
  Future<void> addAContact(Contact contact) async{
    UuidV4 uuidObj = const UuidV4();
    String uuid = uuidObj.toString();

    final String name = contact.name;
    final String props = jsonEncode(contact.properties);
    final String tags = jsonEncode(contact.tags);

    database.execute(
      """
        INSERT INTO contacts (id, name, props, tags)
        VALUE ($uuid, $name, $props, $tags);
      """
    );
  }

  // Update the content of a contact.
  Future<void> update(String uuid, Contact contact) async{
    // See if the uuid is valid.
    if(!Uuid.isValidUUID(fromString: uuid)){
      throw NonValidUuidException(uuid);
    }

    final String newName = contact.name;
    final String newProps = jsonEncode(contact.properties);
    final String newTags = jsonEncode(contact.tags);

    database.execute(
      """
        UPDATE contacts SET name=$newName, props=$newProps, tags=$newTags
        WHERE id=$uuid;
      """
    );
  }

  // Delete a contact from the list.
  Future<void> delete(String uuid) async{
    // See if the uuid is valid.
    if (!Uuid.isValidUUID(fromString: uuid)){
      throw NonValidUuidException(uuid);
    }

    database.execute("DELETE FROM contacts WHERE ID = $uuid;");
  }

  // Get the information from a specific contact (via the UUID).
  Future<Contact> getAContact(String uuid) async{
    // See if the uuid is valid.
    if (!Uuid.isValidUUID(fromString: uuid)){
      throw NonValidUuidException(uuid);
    }

    final ResultSet rows = database.select(
      "SELECT * FROM contacts WHERE id=$uuid;"
    );

    // `for` here but there would be only one row. :)
    for (Row row in rows){
      final String name = row["name"];
      final String propsStr = row["props"];
      final Map<String, ContactProp> props = jsonDecode(propsStr);
      final List<ContactTag> tags = jsonDecode(row["tags"]);

      final Contact contact = Contact.read(name, props, tags: tags);
      // Seems dirty here.
      return contact;
    }

    // No contact found.
    throw ContactNotFoundException(uuid);
  }
}

// Tag database manager class.
class TagDatabaseObject extends DatabaseObject{
  TagDatabaseObject._() : super(sqlite3.open('tag.sqlite')){
    // Create the database automatically.
    // Among them, `id` is a UUIDv4 object, `color` is a hex string,
    // list is a JSON list which includes UUID keys of the contacts.
    database.execute(
      """
        CREATE TABLE IF NOT EXIST tags(
          id TEXT PRIMARY KEY,
          name TEXT,
          color INT,
          list TEXT
        );
      """
    );
  }

  // The course to generate the database object should be async.
  static Future<TagDatabaseObject> generate() async{
    return TagDatabaseObject._();
  }

  // Get a list of current tags from the database.
  Future<List<ContactTag>> getCurrentTags() async{
    List<ContactTag> result = [];
    ResultSet rows = database.select("SELECT id, name, color FROM tags;");
    for (Row row in rows){
      String uuid = row["id"];
      String name = row["name"];
      Color color = Color(row["color"]);
      result.add(ContactTag(uuid, name, color));
    }
    return result;
  }

  // Get the list of the uuids of the contacts of a specific tag.
  // Either a `ContactTag` object or it's uuid should be provided. If both are
  // provided, the program will use the first one.
  Future<List<String>> getContactUuidList({
    ContactTag? tagObject,
    String? tagUuid
  }) async{
    // If no parameter is provided, just return (throwing an error may be
    // better).
    if (tagObject == null && tagUuid == null) {
      return [];
    }
    if (tagObject != null) tagUuid = tagObject.uuid;
    ResultSet rows = database.select(
      "SELECT list FROM tags WHERE id=$tagUuid;"
    );
    // Actually one row here. If one is found, just return it.
    for (Row row in rows){
      List<String> contactList = jsonDecode(row["list"]);
      return contactList;
    }
    // If none is found, return an empty list.
    return [];
  }

  // Get the info of a tag (including name and color) based on its uuid.
  Future<(String name, Color color)> getTagInfo(String tagUuid) async{
    ResultSet rows = database.select(
      "SELECT name, color FROM tags WHERE id=$tagUuid;"
    );

    for (Row row in rows){
      String name = row["name"];
      Color color = Color(row["color"]);
      return (name, color);
    }

    // If no tag is found, throw an exception.
    throw TagNotFoundException(tagUuid);
  }

  // Update the name of a tag.
  Future<void> updateName(String tagUuid, String newName) async{
    database.execute("UPDATE tags SET name=$newName WHERE id=$tagUuid;");
  }

  // Update the color of a tag.
  Future<void> updateColor(String tagUuid, Color newColor) async{
    int newColorValue = newColor.value;
    database.execute("UPDATE tags SET color=$newColorValue WHERE id=$tagUuid;");
  }

  // Add a contact to a tag's list.
  Future<void> addAContact2List(String tagUuid, String contactUuid) async{
    // Check the contact uuid to avoid adding non-valid contact uuids.
    if(!Uuid.isValidUUID(fromString: contactUuid)){
      throw NonValidUuidException(contactUuid);
    }
    // Get the list and see if the contact's uuid has been already existed.
    List<String> oldList = await getContactUuidList(tagUuid: tagUuid);
    if (!oldList.contains(contactUuid)){
      // Add the contact's data and update it to the database.
      oldList.add(contactUuid);
      String newList = jsonEncode(oldList);
      database.execute("UPDATE tags SET list=$newList WHERE id=$tagUuid;");
    }
  }

  // Remove a contact from the list if it exists.
  Future<void> removeAContactFromList(
    String tagUuid,
    String contactUuid
  ) async{
    List<String> oldList = await getContactUuidList(tagUuid: tagUuid);
    if(oldList.contains(contactUuid)){
      oldList.remove(contactUuid);
      String newList = jsonEncode(oldList);
      database.execute("UPDATE tags SET list=$newList WHERE id=$tagUuid;");
    }
  }

  // Add a `ContactTag` object (with an empty list) to the database.
  Future<void> addATag(ContactTag tag) async{
    String uuid = tag.uuid;
    String name = tag.tagName;
    int color = tag.color.value;
    String list = jsonEncode(<String>[]);
    database.execute(
      """
        INSERT INTO tags (id, name, color, list)
        VALUES ($uuid, $name, $color, $list);
      """
    );
  }

  // Remove a tag from the database.
  Future<void> removeATag(String uuid) async{
    database.execute("DELETE FROM tags WHERE id=$uuid;");
  }
}