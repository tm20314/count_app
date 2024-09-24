import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../services/supabase_service.dart';
import '../views/second_screen.dart';

class AuthController {
  final SupabaseService _supabaseService = SupabaseService();

  void checkAuthState(BuildContext context) async {
    final session = _supabaseService.getCurrentSession();
    if (session != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SecondScreen(),
          ),
        );
      });
    } else {
      _setupAuthListener(context);
    }
  }

  void _setupAuthListener(BuildContext context) {
    _supabaseService.onAuthStateChange().listen((data) {
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

  Future<void> googleSignIn(BuildContext context) async {
    try {
      await _supabaseService.signInWithGoogle();
      print('Google Sign In successful');
    } catch (error) {
      print('Error during Google Sign In: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google Sign In failed: $error')),
      );
    }
  }
}
