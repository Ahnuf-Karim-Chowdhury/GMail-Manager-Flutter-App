import 'dart:io';
import 'package:archive/archive_io.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class FileFormattingService {
  Future<void> saveEmailToDrive(drive.DriveApi driveApi, String emailContent, String emailId) async {
    // Save the email content to a PDF file
    final directory = await getApplicationDocumentsDirectory();
    final pdfFile = File(p.join(directory.path, 'email-text', '$emailId.pdf'));

    // Create PDF
    final pdf = pw.Document();
    pdf.addPage(pw.Page(build: (context) => pw.Text(emailContent)));
    await pdfFile.writeAsBytes(await pdf.save());

    // Create ZIP archive
    final archive = Archive();
    archive.addFile(ArchiveFile('email-text/$emailId.pdf', pdfFile.lengthSync(), await pdfFile.readAsBytes()));

    final zipEncoder = ZipFileEncoder();
    final zipFile = File(p.join(directory.path, '$emailId.zip'));
    zipEncoder.zipDirectory(Directory(p.join(directory.path, 'email-text')));

    // Upload the ZIP file to Google Drive
    var zipMedia = drive.Media(zipFile.openRead(), zipFile.lengthSync());
    var zipFileDrive = drive.File()..name = '$emailId.zip';

    await driveApi.files.create(zipFileDrive, uploadMedia: zipMedia);

    print('Email saved to Google Drive');
  }
}
