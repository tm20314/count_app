import 'package:count_app/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('注意', textAlign: TextAlign.center),
      content: const Text('ログアウトしても大丈夫そ？', textAlign: TextAlign.center),
      actions: <Widget>[
        GestureDetector(
          child: const Text('いいえ'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        GestureDetector(
          child: const Text('はい大丈夫そ'),
          onTap: () {
            Supabase.instance.client.auth.signOut();
            const SnackBar(content: Text('ログアウトしました'));

            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
              return const LoginScreen();
            }));
          },
        )
      ],
    );
  }
}
