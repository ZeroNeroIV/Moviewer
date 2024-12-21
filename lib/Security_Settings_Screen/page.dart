
class SecuritySettingsScreen extends StatefulWidget {
  const SecuritySettingsScreen({Key? key}) : super(key: key);

  @override
  _SecuritySettingsScreenState createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  bool _requireUnlock = false;
  bool _hideNotifications = false;
  bool _secureScreen = false;
  double _autoLockTimer = 1.0;
  int _selectedAuthMethod = 0;

  bool _generalExpanded = true;
  bool _notificationsExpanded = false;
  bool _advancedExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Security and privacy'),
        backgroundColor: Colors.grey[900],
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // General Security Section
              ExpansionTile(
                initiallyExpanded: _generalExpanded,
                onExpansionChanged: (expanded) {
                  setState(() => _generalExpanded = expanded);
                },
                title: const Text('General Security',
                    style: TextStyle(color: Colors.white)),
                children: [
                  ListTile(
                    title: const Text('Require unlock',
                        style: TextStyle(color: Colors.white)),
                    trailing: Switch(
                      value: _requireUnlock,
                      onChanged: (value) =>
                          setState(() => _requireUnlock = value),
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
                                onChanged: (value) => setState(
                                    () => _selectedAuthMethod = value as int),
                              ),
                              const Text('PIN',
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 1,
                                groupValue: _selectedAuthMethod,
                                onChanged: (value) => setState(
                                    () => _selectedAuthMethod = value as int),
                              ),
                              const Text('Password',
                                  style: TextStyle(color: Colors.white)),
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
                          labelText: _selectedAuthMethod == 0
                              ? 'Enter PIN'
                              : 'Enter Password',
                          border: const OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.grey[900],
                        ),
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ],
              ),

              // Notifications Section
              ExpansionTile(
                initiallyExpanded: _notificationsExpanded,
                onExpansionChanged: (expanded) {
                  setState(() => _notificationsExpanded = expanded);
                },
                title: const Text('Notifications',
                    style: TextStyle(color: Colors.white)),
                children: [
                  ListTile(
                    title: const Text('Hide notification content',
                        style: TextStyle(color: Colors.white)),
                    trailing: Switch(
                      value: _hideNotifications,
                      onChanged: (value) =>
                          setState(() => _hideNotifications = value),
                    ),
                  ),
                ],
              ),

              // Advanced Settings Section
              ExpansionTile(
                initiallyExpanded: _advancedExpanded,
                onExpansionChanged: (expanded) {
                  setState(() => _advancedExpanded = expanded);
                },
                title: const Text('Advanced Settings',
                    style: TextStyle(color: Colors.white)),
                children: [
                  ListTile(
                    title: const Text('Secure screen',
                        style: TextStyle(color: Colors.white)),
                    subtitle: const Text(
                      'Incognito mode',
                      style: TextStyle(color: Colors.grey),
                    ),
                    trailing: Switch(
                      value: _secureScreen,
                      onChanged: (value) =>
                          setState(() => _secureScreen = value),
                    ),
                  ),
                  if (_secureScreen) ...[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Auto-lock timer (minutes)',
                            style: TextStyle(color: Colors.white),
                          ),
                          Slider(
                            value: _autoLockTimer,
                            min: 1,
                            max: 30,
                            divisions: 29,
                            label: _autoLockTimer.round().toString(),
                            onChanged: (value) =>
                                setState(() => _autoLockTimer = value),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Settings saved successfully')),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.blue,
          ),
          child: const Text('Save Changes'),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _pinController.dispose();
    super.dispose();
  }
}
