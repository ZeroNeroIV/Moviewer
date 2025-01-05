import 'package:flutter/material.dart';

class GeneralSecuritySection extends StatefulWidget {
  const GeneralSecuritySection({super.key});

  @override
  State<GeneralSecuritySection> createState() => _GeneralSecuritySectionState();
}

class _GeneralSecuritySectionState extends State<GeneralSecuritySection> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  bool _requireUnlock = false;
  int _selectedAuthMethod = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ExpansionTile(
      initiallyExpanded: true,
      onExpansionChanged: (expanded) {},
      title: Text(
        'General Security',
        style: theme.textTheme.bodyLarge,
      ),
      children: [
        ListTile(
          title: Text(
            'Require unlock',
            style: theme.textTheme.bodyMedium,
          ),
          trailing: Switch(
            value: _requireUnlock,
            onChanged: (value) => setState(() => _requireUnlock = value),
          ),
        ),
        if (_requireUnlock) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Radio(
                      value: 0,
                      groupValue: _selectedAuthMethod,
                      onChanged: (value) => setState(() {
                        _selectedAuthMethod = value as int;
                      }),
                    ),
                    Text('PIN', style: theme.textTheme.bodyMedium),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: _selectedAuthMethod,
                      onChanged: (value) => setState(() {
                        _selectedAuthMethod = value as int;
                      }),
                    ),
                    Text('Password', style: theme.textTheme.bodyMedium),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _selectedAuthMethod == 0
                  ? _pinController
                  : _passwordController,
              decoration: InputDecoration(
                labelText:
                    _selectedAuthMethod == 0 ? 'Enter PIN' : 'Enter Password',
                border: const OutlineInputBorder(),
                filled: true,
                fillColor: theme.colorScheme.surface,
              ),
              obscureText: true,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ],
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _pinController.dispose();
    super.dispose();
  }
}
