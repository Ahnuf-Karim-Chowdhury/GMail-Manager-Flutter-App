import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/gmail/v1.dart' as gmail;
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:http/http.dart' as http;
import 'package:gmail_manager/services/gmail_service.dart';
import 'package:gmail_manager/services/file_formating_service.dart';

class EmailPage extends StatefulWidget {
  @override
  _EmailPageState createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  final GmailService _gmailService = GmailService();
  final FileFormattingService _fileFormattingService = FileFormattingService();
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [gmail.GmailApi.gmailReadonlyScope, drive.DriveApi.driveFileScope],
  );
  List<gmail.Message> _emails = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchEmails();
  }

  Future<void> _fetchEmails() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        final emails = await _gmailService.fetchEmails();
        setState(() {
          _emails = emails;
          print('Fetched ${emails.length} emails');
        });
      } else {
        print('Sign in failed');
      }
    } catch (error) {
      print('Error fetching emails: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }

    @override
    Widget build(BuildContext context) {
      // TODO: implement build
      throw UnimplementedError();
    }
  }

  Future<void> _saveEmailToDrive(gmail.Message email) async {
    try {
      final authHeaders = await _googleSignIn.currentUser!.authHeaders;
      final httpClient = _GoogleHttpClient(authHeaders);
      final driveApi = drive.DriveApi(httpClient);

      await _fileFormattingService.saveEmailToDrive(
        driveApi,
        email.snippet!,
        email.id!,
      );
    } catch (error) {
      print('Error saving email to Google Drive: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inbox')),
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: _emails.length,
                itemBuilder: (context, index) {
                  final email = _emails[index];
                  final snippet = email.snippet ?? '';
                  final date = DateTime.fromMillisecondsSinceEpoch(
                    int.parse(email.internalDate ?? '0'),
                  );
                  return ListTile(
                    title: Text(snippet),
                    subtitle: Text(date.toString()),
                    trailing: IconButton(
                      icon: Icon(Icons.save),
                      onPressed: () => _saveEmailToDrive(email),
                    ),
                  );
                },
              ),
    );
  }
}

class _GoogleHttpClient extends http.BaseClient {
  final Map<String, String> _headers;

  _GoogleHttpClient(this._headers);

  final http.Client _client = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _client.send(request..headers.addAll(_headers));
  }
}
