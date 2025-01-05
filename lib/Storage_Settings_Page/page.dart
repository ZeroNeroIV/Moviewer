
class StorageSettingsPage extends StatefulWidget {
  @override
  _StorageSettingsPageState createState() => _StorageSettingsPageState();
}

class _StorageSettingsPageState extends State<StorageSettingsPage> {
  final TextEditingController _locationController = TextEditingController();
  bool _autoBackup = true;
  double _backupFrequency = 12;
  bool _clearCacheOnLaunch = false;

  @override
  void initState() {
    super.initState();
    _locationController.text = '/storage/emulated/0/Download/manga';
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark().copyWith(
        primaryColor: Colors.teal,
        colorScheme: ColorScheme.dark(
          primary: Colors.teal,
          secondary: Colors.tealAccent,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('Data and storage'),
          actions: [
            IconButton(
              icon: Icon(Icons.help_outline),
              onPressed: () {
                // Show help dialog
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Storage Location Section
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Storage location',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextField(
                          controller: _locationController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.folder_open),
                              onPressed: () {
                                // Open folder picker
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Used for automatic backups, chapter downloads, and local source.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Backup Section
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Backup and restore',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  // Create backup logic
                                },
                                child: Text('Create backup'),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  // Restore backup logic
                                },
                                child: Text('Restore backup'),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        SwitchListTile(
                          title: Text('Automatic backup'),
                          value: _autoBackup,
                          onChanged: (value) {
                            setState(() {
                              _autoBackup = value;
                            });
                          },
                        ),
                        if (_autoBackup) ...[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Backup frequency (hours)'),
                                Slider(
                                  value: _backupFrequency,
                                  min: 1,
                                  max: 24,
                                  divisions: 23,
                                  label: _backupFrequency.round().toString(),
                                  onChanged: (value) {
                                    setState(() {
                                      _backupFrequency = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Storage Usage Section
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Storage usage',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        ListTile(
                          title: Text('/storage/emulated/0'),
                          subtitle: Text('Available: 73.1 GB / Total: 242 GB'),
                          leading: Icon(Icons.storage),
                        ),
                        Divider(),
                        ListTile(
                          title: Text('Clear chapter and episode cache'),
                          subtitle: Text('Used: 3.45 MB'),
                          trailing: Switch(
                            value: _clearCacheOnLaunch,
                            onChanged: (value) {
                              setState(() {
                                _clearCacheOnLaunch = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Save settings
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Settings saved successfully')),
            );
          },
          child: Icon(Icons.save),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }
}
