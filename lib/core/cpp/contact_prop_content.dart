// The following is also `ContactPropType`, but with the actual contents.
// The difference between them and `ContactPropType` is, they are shipped
// with each contact, instead of the contact profiles.

sealed class ContactPropContent{}

class Number extends ContactPropContent{
  int content;
  Number(this.content);
}

class Str extends ContactPropContent{
  String content;
  Str(this.content);
}

class StringWithPattern extends ContactPropContent{
  String content;
  StringWithPattern(this.content);
}

class ImageBase64 extends ContactPropContent{
  String content;
  ImageBase64(this.content);
}