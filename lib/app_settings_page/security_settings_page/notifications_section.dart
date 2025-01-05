import 'package:flutter/material.dart';

class NotificationsSection extends StatefulWidget {
  const NotificationsSection({super.key});

  @override
  State<NotificationsSection> createState() => _NotificationsSectionState();
}

class _NotificationsSectionState extends State<NotificationsSection> {
  bool _hideNotifications = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ExpansionTile(
      initiallyExpanded: false,
      onExpansionChanged: (expanded) {},
      title: Text('Notifications', style: theme.textTheme.bodyLarge),
      children: [
        ListTile(
          title: Text('Hide notification content',
              style: theme.textTheme.bodyMedium),
          trailing: Switch(
            value: _hideNotifications,
            onChanged: (value) => setState(() => _hideNotifications = value),
          ),
        ),
      ],
    );
  }
}
