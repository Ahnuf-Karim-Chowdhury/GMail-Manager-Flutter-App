import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/gmail/v1.dart' as gmail;
import 'package:http/http.dart' as http;

class EmailPage extends StatefulWidget {
  @override
  _EmailPageState createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      gmail.GmailApi.gmailReadonlyScope,
    ],
  );

  List<gmail.Message> _emails = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _signInAndFetchEmails();
  }

  Future<void> _signInAndFetchEmails() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        print('User signed in: ${account.email}');
        final authHeaders = await account.authHeaders;
        final httpClient = _GoogleHttpClient(authHeaders);
        final gmailApi = gmail.GmailApi(httpClient);

        final messagesResponse = await gmailApi.users.messages.list('me', q: 'is:inbox', maxResults: 20);
        final messages = messagesResponse.messages ?? [];

        List<gmail.Message> emailMessages = [];
        for (var message in messages) {
          final msg = await gmailApi.users.messages.get('me', message.id!);
          emailMessages.add(msg);
        }

        setState(() {
          _emails = emailMessages;
          print('Fetched ${emailMessages.length} emails');
        });
      } else {
        print('Sign in failed');
      }
    } catch (error) {
      print('Error signing in and fetching emails: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inbox'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _emails.length,
              itemBuilder: (context, index) {
                final email = _emails[index];
                final snippet = email.snippet ?? '';
                final date = DateTime.fromMillisecondsSinceEpoch(int.parse(email.internalDate ?? '0'));
                return ListTile(
                  title: Text(snippet),
                  subtitle: Text(date.toString()),
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
