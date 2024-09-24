import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  Session? getCurrentSession() {
    return _client.auth.currentSession;
  }

  Stream<AuthState> onAuthStateChange() {
    return _client.auth.onAuthStateChange;
  }

  Future<void> signInWithGoogle() async {
    if (kIsWeb) {
      await _client.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'https://gadgelogger.github.io/count_app/',
        queryParams: {
          'hd': 'ous.jp',
        },
      );
    } else {
      const webClientId =
          '242312621999-13sbtm407bp8t2g0k506jo3astk4c1et.apps.googleusercontent.com';
      const iosClientId =
          '242312621999-ppq3o5v084j5qao0tijugh2c9o27l0f6.apps.googleusercontent.com';

      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: iosClientId,
        serverClientId: webClientId,
        hostedDomain: 'ous.jp',
      );

      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw 'Google Sign In was canceled';
      }

      if (!googleUser.email.endsWith('@ous.jp')) {
        throw 'Only @ous.jp accounts are allowed';
      }

      final googleAuth = await googleUser.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null) {
        throw 'No Access Token found.';
      }
      if (idToken == null) {
        throw 'No ID Token found.';
      }

      await _client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
    }
  }

  Future<Map<String, dynamic>> fetchLatestCount() async {
    return await _client
        .from('count')
        .select('person, time, image_url')
        .order('time', ascending: false)
        .limit(1)
        .single();
  }

  Future<List<Map<String, dynamic>>> fetchCountData() async {
    return await _client
        .from('count')
        .select('person, time')
        .order('time', ascending: false)
        .limit(24);
  }
}
