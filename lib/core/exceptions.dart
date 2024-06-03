// This file defines some exceptions of the program.

// When a Uuid is not valid, this exception will be thrown.
class NonValidUuidException implements Exception{
  final String uuid;

  NonValidUuidException(this.uuid);

  @override
  String toString(){
    return "This Uuid is reported to be non valid: $uuid";
  }
}

// When a contact can not be found (via UUID) this exception would be thrown.
class ContactNotFoundException implements Exception{
  final String uuid;

  ContactNotFoundException(this.uuid);

  @override
  String toString(){
    return "Failed to find the contact whose uuid is $uuid.";
  }
}

// When a tag can not be found (via UUID) this exception will be thrown.
class TagNotFoundException implements Exception{
  final String uuid;

  TagNotFoundException(this.uuid);

  @override
  String toString(){
    return "Failed to find the tag whose uuid is $uuid";
  }
}