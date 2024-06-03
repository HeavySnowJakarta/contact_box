// A possible feature in the future.
// Avatars may be provided either on base64 strings or file path strings.

// This file defines how the avatar of a contact combines.
// A contact either has no avatar or has an avatar that points to a path
// which is relative to the application support path.

sealed class ContactAvatar{}

class NoAvatar extends ContactAvatar{}

class OneAvatar extends ContactAvatar{
  // Relative to the application path, with no '/' before it.
  final String path;

  OneAvatar(this.path);
}