/* 
 * This file defines what a Contact Properity's type may be. It was written
 * in Rust preciously like this:
 * 
 * pub enum ContactPropType{
 *   Number,
 *   String,
 *   StringWithPattern(pattern),
 *   ImageBase64
 * }
 * 
 * Here it goes.
 */

sealed class ContactPropType{}

class Number extends ContactPropType{}
// Can't be `String` as it may be confused with the default String of Dart.
class Str extends ContactPropType{}
class StringWithPattern extends ContactPropType{
  String pattern; // Regular expression.

  StringWithPattern(this.pattern);
}
class ImageBase64 extends ContactPropType{}