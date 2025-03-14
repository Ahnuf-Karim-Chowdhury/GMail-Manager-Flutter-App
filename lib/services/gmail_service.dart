import 'package:googleapis/gmail/v1.dart' as gmail;
import 'package:googleapis_auth/googleapis_auth.dart' as auth;
import 'package:google_sign_in/google_sign_in.dart';

class GmailService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['https://www.googleapis.com/auth/gmail.readonly']);

  Future<List<gmail.Message>> fetchEmails() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final auth.AuthClient? client = await googleUser?.authenticatedClient();
    if (client == null) return [];

    final gmail.GmailApi gmailApi = gmail.GmailApi(client);
    final gmail.ListMessagesResponse messages = await gmailApi.users.messages.list("me");
    
    return messages.messages ?? [];
  }
}
