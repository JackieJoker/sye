import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ProfileScreen(
      providerConfigs: [
        EmailProviderConfiguration(),
        GoogleProviderConfiguration(
          clientId: 'split-your-expenses',
        ),
        FacebookProviderConfiguration(
          clientId: 'split-your-expenses',
        ),
        AppleProviderConfiguration(),
      ],
      avatarSize: 120,
      avatarPlaceholderColor: Colors.blue,
    );
  }
}
