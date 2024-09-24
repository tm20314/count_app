import 'package:count_app/main.dart';
import 'package:count_app/views/second_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthState();
  }

  void _checkAuthState() async {
    final session = supabase.auth.currentSession;
    if (session != null) {
      // ユーザーが既にログインしている場合、SecondScreenに遷移
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SecondScreen(),
          ),
        );
      });
    } else {
      // ログインしていない場合は、認証リスナーをセットアップ
      _setupAuthListener();
    }
  }

  void _setupAuthListener() {
    supabase.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('ログインしました')),
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SecondScreen(),
            ),
          );
        });
      }
    });
  }

  Future<void> _googleSignIn() async {
    try {
      if (kIsWeb) {
        await supabase.auth.signInWithOAuth(
          OAuthProvider.google,
          redirectTo: 'https://gadgelogger.github.io/count_app/', // 実際の開発環境のURL
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
          hostedDomain: 'ous.jp', // ここでドメインを指定
        );

        final googleUser = await googleSignIn.signIn();
        if (googleUser == null) {
          throw 'Google Sign In was canceled';
        }

        // ドメインの確認
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

        await supabase.auth.signInWithIdToken(
          provider: OAuthProvider.google,
          idToken: idToken,
          accessToken: accessToken,
        );
        setState(() {
          // ログイン成功したら状態を書き換える
        });
      }

      print('Google Sign In successful');
    } catch (error) {
      print('Error during Google Sign In: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google Sign In failed: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ログイン'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: ElevatedButton(
              onPressed: _googleSignIn,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.g_mobiledata),
                  SizedBox(width: 8),
                  Text('Googleでログイン'),
                ],
              )),
        ),
      ),
    );
  }
}
