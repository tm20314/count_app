import 'dart:io';

import 'package:count_app/screens/second_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
      url: 'https://ycnpvgqdogzhjhiilvbs.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InljbnB2Z3Fkb2d6aGpoaWlsdmJzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTU3MDkxMDksImV4cCI6MjAzMTI4NTEwOX0.w32xNB9Wv81yD5X3mvvSUuKb2ydvMrqvDXFg7DWa0L0');
  runApp(const MainApp());
}

final supabase = Supabase.instance.client;

// MainAppクラス: アプリケーションの状態を管理するStatefulWidget
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SecondScreen(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _userId;
  @override
  void initState() {
    _setupAuthListener();

    super.initState();

    supabase.auth.onAuthStateChange.listen((data) {
      setState(() {
        _userId = data.session?.user.id;
      });
    });
  }

  void _setupAuthListener() {
    supabase.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SecondScreen(),
          ),
        );
      }
    });
  }

  Future<void> _nativeGoogleSignIn() async {
    ///
    /// Web Client ID that you registered with Google Cloud.
    const webClientId =
        '242312621999-13sbtm407bp8t2g0k506jo3astk4c1et.apps.googleusercontent.com';

    ///
    /// iOS Client ID that you registered with Google Cloud.
    const iosClientId =
        '242312621999-ppq3o5v084j5qao0tijugh2c9o27l0f6.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Supabase Auth'),
        ),
        body: Center(
          child: Column(
            children: [
              Text(_userId ?? 'Not logged in'),
              ElevatedButton(
                  onPressed: () async {
                    if (Platform.isAndroid || Platform.isIOS) {
                      await _nativeGoogleSignIn();
                    } else if (kIsWeb) {
                      await supabase.auth.signInWithOAuth(OAuthProvider.google);
                    }
                  },
                  child: const Text('Sign in')),
            ],
          ),
        ));
  }
}
