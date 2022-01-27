import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:sye/profile_page.dart';

import 'Db/db.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // User is not signed in
        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(),
            body: const SignInScreen(
                providerConfigs: [
                  EmailProviderConfiguration(),
                  GoogleProviderConfiguration(
                    clientId: 'split-your-expenses',
                  ),
                ]
            )
          );
        }

        DB.registerUser(snapshot.data!.uid);
        // Render your application if authenticated
        return const ProfilePage();
      },
    );
  }
}
