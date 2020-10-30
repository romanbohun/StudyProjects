import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPaths;

class FileService {

  Future<File> saveFileToDocumets(File file) async {
    final documentsDir = await sysPaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(file.path);
    return await file.copy('${documentsDir.path}/$fileName');
  }

}
