import 'dart:io';
import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:jbf/main.dart';
import 'package:path_provider/path_provider.dart';

Future<void> saveUint8ListToFile(Uint8List data, String fileName) async {
  try {
    // Get the external storage directory
    Directory? externalDirectory = await getExternalStorageDirectory();

    if (externalDirectory != null) {
      // Specify the file path within the external storage directory
      String filePath = '${externalDirectory.path}/$fileName';

      // Write the Uint8List data to the file
      await File(filePath).writeAsBytes(data);

      print('File saved to: $filePath');
      homeController.newBillPath = filePath;
    } else {
      print('External storage directory not available');
    }
  } catch (e) {
    print('Error saving file: $e');
  }
}

Future<Uint8List> imageToPdf(Uint8List imageBytes) async {
  final pdf = pw.Document();

  // Add a single page to the PDF document
  pdf.addPage(pw.Page(
    build: (context) {
      final image = pw.MemoryImage(imageBytes);
      return pw.Center(child: pw.Image(image));
    },
  ));

  // Save the PDF document as a Uint8List
  return pdf.save();
}
