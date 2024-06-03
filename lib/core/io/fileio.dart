/*
 * According to `path_provider`, only the following paths are available
 * on all of Windows, macOS, Linux, Android and iOS (and HarmonyOS).
 * 
 * - Temporary
 * - Application support
 * - Application documents
 * - Application cache
 */

import 'package:path_provider/path_provider.dart';
import 'dart:io';

// `enum FileIOManagerType` is to distinguish which kind of path to use.
// For now the document path is needed to store profiles and the support
// path is needed for the contact avatars.
enum FileIOManagerType{
  document,
  support
}

// `FileIOManager` is the base class to read and write files according to
// the paths above.
// `DocumentIOManager` is designed to be static, whose only purpose is to
// provide some methods to read and write. For now it's just needed to
// be initialized when the app starts.
abstract class FileIOManager{
  // At the impletation of the child classes, async functions are needed
  // during the constructors. But it's not allowed for constructors.
  // The solution is to define an separated async function and let it to do 
  // the work instead. A factory function will be defined to call that async
  // function, and then the constructor only have to do the non-async work.

  // Thus, the fields of the class have to be marked as "late" but they
  // would be defined during the creation(actually not late).
  late Directory workDict;
  late String workPath;
  // This method reads the file from the given path and returns a String
  // value.
  // `path`: The relative path. For example, you want to read
  // `$document_directory/subdirectory/file`, set the path as
  // `directory/file` will be just okay.
  Future<String> read(String path) async{
    final File file = File("$workPath/$path");
    return file.readAsString();
  }
  // This method writes the String `content` to a file.
  Future<void> write(String path, String content) async{
    final File file = File("$workPath/$path");
    file.writeAsString(content, mode: FileMode.writeOnly);
  }
}

// It's forbidden to call async functions directly with factory functions.
// So let's move it out of the base class.
Future<FileIOManager> newFileIOManager(FileIOManagerType type) async{
  switch (type){
    case FileIOManagerType.document:
      return await DocumentIOManager.create();
    case FileIOManagerType.support:
      return await SupportIOManager.create();
  }
}

// `DocumentIOManager` provides methods to read and save files to the
// directory of application documents.
class DocumentIOManager extends FileIOManager{
  // As async functions are not allowed for the constructors, the way to
  // call the async functions when creating objects is to define a seperated
  // "constructor" function and set the constructor as private. Thus,
  // a DocumentIOManager object can only be defined via the public factory
  // function where the real "constructor" where async functions have to be
  // used will be called.

  // The "fake" constructor.
  DocumentIOManager._(){
    // Nothing to do.
  }

  // The "real" constructor that define the fields.
  _asyncInit() async{
    workDict = await getApplicationDocumentsDirectory();
    workPath = workDict.path;
  }

  // The factory function.
  static Future<DocumentIOManager> create() async{
    DocumentIOManager result = DocumentIOManager._();
    result._asyncInit();
    return result;
  }

  // So, to create the object, you have to use `DocumentIOManager.create()`.
}

class SupportIOManager extends FileIOManager{
  // The same as `DocumentIOManager`.
  SupportIOManager._();

  _asyncInit() async {
    workDict = await getApplicationSupportDirectory();
    workPath = workDict.path;
  }

  static Future<SupportIOManager> create() async{
    SupportIOManager result = SupportIOManager._();
    result._asyncInit();
    return result;
  }
}