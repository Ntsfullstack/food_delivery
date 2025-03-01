import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'enum.dart';

class FileUtils {
  static String _localPath = '';
  final ImagePicker _picker = ImagePicker();

  static Future<String> get localPath async {
    if (_localPath == '') {
      Directory localPathDic = (Platform.isAndroid
          ? await getExternalStorageDirectory()
          : await getApplicationDocumentsDirectory())!;

      _localPath = localPathDic.path;
    }

    return _localPath;
  }

  static Future<Map<String, dynamic>> localFile(String fileName) async {
    final String jsonString = await rootBundle.loadString(fileName);
    final data = json.decode(jsonString);
    return data;
  }

  Future<File> writeToFile({ByteData? data}) async {
    var time = DateTime.now().toIso8601String();
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/Signature-$time.png';
    Uint8List? uint8list = data?.buffer.asUint8List();
    File file = File(path);
    await file.writeAsBytes(uint8list!);
    return file;
  }

  // Future<XFile?> saveScreenShootToGallery(
  //     {required RenderRepaintBoundary boundary, bool saveTras = false}) async {
  //   ui.Image image = await boundary.toImage(pixelRatio: 2);
  //   ByteData? byteData =
  //       await (image.toByteData(format: ui.ImageByteFormat.png));
  //   if (byteData != null) {
  //     // if (saveTras)
  //     await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
  //     final tempDir = await getTemporaryDirectory();
  //     final tempFile = await File('${tempDir.path}/temp_image.png').create();
  //     await tempFile.writeAsBytes(byteData.buffer.asUint8List());
  //     return XFile(tempFile.path);
  //   }
  // }

  Future<XFile?> getFromGallery(
      {required ActionMedia actionMedia,
      required PreviewType previewType}) async {
    XFile? pickedFile;
    switch (actionMedia) {
      case ActionMedia.camera:
        pickedFile = await _picker.pickImage(source: ImageSource.camera);
        break;
      case ActionMedia.gallery:
        pickedFile = await _picker.pickImage(source: ImageSource.gallery);
        break;
    }

    return pickedFile;
  }

  Future<List<Map>> readJsonFile(String filePath) async {
    var input = await File(filePath).readAsString();
    var map = jsonDecode(input);
    return map;
  }

  static Future<Directory?> getSavedPDFDir() async {
    Directory tempDirectory = await getTemporaryDirectory();
    String filePath = tempDirectory.path;

    Directory? pdfDirectory;

    await Directory('$filePath/PDFs').exists().then((isExistsDirectory) async {
      if (isExistsDirectory) {
        pdfDirectory = Directory('$filePath/PDFs');
      } else {
        await Directory('$filePath/PDFs').create().then((createdDirectory) {
          pdfDirectory = createdDirectory;
        });
      }
    });

    return pdfDirectory;
  }
}
