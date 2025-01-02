import 'package:flutter/material.dart';

class StorageSettingsPage extends StatefulWidget {
  const StorageSettingsPage({super.key});

  @override
  State<StorageSettingsPage> createState() => _StorageSettingsPageState();
}

class _StorageSettingsPageState extends State<StorageSettingsPage> {
  final TextEditingController _locationController = TextEditingController();
  bool _autoBackup = true;
  double _backupFrequency = 12;
  bool _clearCacheOnLaunch = false;

  @override
  void initState() {
    super.initState();
    _locationController.text = '/storage/Download/';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Data and storage'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              // Show help dialog
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Storage Location Section
              _buildStorageLocationCard(context),
              const SizedBox(height: 16),

              // Backup Section
              _buildBackupSection(context),
              const SizedBox(height: 16),

              // Storage Usage Section
              _buildStorageUsageCard(context),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add functionality here
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  Widget _buildStorageLocationCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Storage location',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.folder_open),
                  onPressed: () {
                    // Open folder picker
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Used for automatic backups, chapter downloads, and local source.',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackupSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Backup and restore',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Create backup logic
                    },
                    child: const Text('Create backup'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Restore backup logic
                    },
                    child: const Text('Restore backup'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Automatic backup'),
              value: _autoBackup,
              onChanged: (value) {
                setState(() {
                  _autoBackup = value;
                });
              },
            ),
            if (_autoBackup)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Backup frequency (hours)'),
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
        ),
      ),
    );
  }

  Widget _buildStorageUsageCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Storage usage',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            const ListTile(
              title: Text('/storage/emulated/0'),
              subtitle: Text('Available: 73.1 GB / Total: 242 GB'),
              leading: Icon(Icons.storage),
            ),
            const Divider(),
            ListTile(
              title: const Text('Clear chapter and episode cache'),
              subtitle: const Text('Used: 3.45 MB'),
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
    );
  }
}
