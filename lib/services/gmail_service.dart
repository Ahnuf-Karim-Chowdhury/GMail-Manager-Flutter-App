import 'package:googleapis/gmail/v1.dart' as gmail;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class GmailService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/gmail.readonly',
    ],
  );

  Future<List<gmail.Message>> fetchEmails({DateTime? startDate, DateTime? endDate}) async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return [];

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final authHeaders = {
      'Authorization': 'Bearer ${googleAuth.accessToken}',
    };
    final httpClient = _GoogleHttpClient(authHeaders);

    final gmail.GmailApi gmailApi = gmail.GmailApi(httpClient);
    String query = 'in:inbox';
    if (startDate != null) {
      query += ' after:${startDate.millisecondsSinceEpoch ~/ 1000}';
    }
    if (endDate != null) {
      query += ' before:${endDate.millisecondsSinceEpoch ~/ 1000}';
    }

    final gmail.ListMessagesResponse messages = await gmailApi.users.messages.list('me', q: query);

    List<gmail.Message> emailMessages = [];
    for (var message in messages.messages ?? []) {
      final msg = await gmailApi.users.messages.get('me', message.id!);
      emailMessages.add(msg);
    }

    return emailMessages;
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
