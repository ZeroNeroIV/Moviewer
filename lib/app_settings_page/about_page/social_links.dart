import 'package:flutter/material.dart';

class SocialLinks extends StatelessWidget {
  const SocialLinks({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSocialIconButton(
            theme,
            icon: Icons.language,
            onPressed: () {},
          ),
          const SizedBox(width: 16),
          _buildSocialIconButton(
            theme,
            icon: Icons.discord,
            onPressed: () {},
          ),
          const SizedBox(width: 16),
          _buildSocialIconButton(
            theme,
            icon: Icons.code,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  IconButton _buildSocialIconButton(ThemeData theme,
      {required IconData icon, required VoidCallback onPressed}) {
    return IconButton(
      icon: Icon(icon),
      onPressed: onPressed,
    );
  }
}
