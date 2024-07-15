// app_drawer.dart
import 'package:count_app/main.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = supabase.auth.currentUser;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user?.userMetadata?['full_name'] ?? 'No Name'),
            accountEmail: Text(user?.email ?? 'No Email'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: user?.userMetadata?['avatar_url'] != null
                  ? NetworkImage(user!.userMetadata!['avatar_url'])
                  : null,
              child: user?.userMetadata?['avatar_url'] == null
                  ? const Icon(Icons.person)
                  : null,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          // ここに他のメニュー項目を追加できます
        ],
      ),
    );
  }
}
