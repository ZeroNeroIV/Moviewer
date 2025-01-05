import 'package:flutter/material.dart';

class LinksSection extends StatelessWidget {
  const LinksSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.surface,
      child: Column(
        children: [
          _buildLinkItem(
            theme,
            icon: Icons.update,
            text: 'Check for updates',
            onTap: () {},
          ),
          _buildLinkItem(
            theme,
            icon: Icons.new_releases,
            text: "What's new",
            onTap: () {},
          ),
          _buildLinkItem(
            theme,
            icon: Icons.translate,
            text: 'Help translate',
            onTap: () {},
          ),
          _buildLinkItem(
            theme,
            icon: Icons.description,
            text: 'Open source licenses',
            onTap: () {},
          ),
          _buildLinkItem(
            theme,
            icon: Icons.privacy_tip,
            text: 'Privacy policy',
            onTap: () {},
          ),
          _buildLinkItem(
            theme,
            icon: Icons.info,
            text: 'Terms of service',
            onTap: () {},
          ),
          _buildLinkItem(
            theme,
            icon: Icons.feedback,
            text: 'Send feedback',
            onTap: () {},
          ),
          _buildLinkItem(
            theme,
            icon: Icons.star,
            text: 'Rate this app',
            onTap: () {},
          ),
          _buildLinkItem(
            theme,
            icon: Icons.videocam,
            text: 'Tutorial video',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  ListTile _buildLinkItem(ThemeData theme,
      {required IconData icon,
      required String text,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.primary),
      title: Text(text, style: theme.textTheme.bodyLarge),
      onTap: onTap,
    );
  }
}
