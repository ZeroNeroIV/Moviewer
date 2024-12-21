

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('About', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Version Info
              const ListTile(
                title: Text(
                  'Version',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                subtitle: Text(
                  'Stable 0.16.4.3',
                  style: TextStyle(color: Colors.grey),
                ),
              ),

              const SizedBox(height: 16),

              // Links Section
              Card(
                color: Colors.grey[900],
                child: Column(
                  children: [
                    ListTile(
                      leading:
                          const Icon(Icons.update, color: Colors.tealAccent),
                      title: const Text(
                        'Check for updates',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.new_releases,
                          color: Colors.tealAccent),
                      title: const Text(
                        "What's new",
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading:
                          const Icon(Icons.translate, color: Colors.tealAccent),
                      title: const Text(
                        'Help translate',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.description,
                          color: Colors.tealAccent),
                      title: const Text(
                        'Open source licenses',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.privacy_tip,
                          color: Colors.tealAccent),
                      title: const Text(
                        'Privacy policy',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.info, color: Colors.tealAccent),
                      title: const Text(
                        'Terms of service',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading:
                          const Icon(Icons.feedback, color: Colors.tealAccent),
                      title: const Text(
                        'Send feedback',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.star, color: Colors.tealAccent),
                      title: const Text(
                        'Rate this app',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading:
                          const Icon(Icons.videocam, color: Colors.tealAccent),
                      title: const Text(
                        'Tutorial video',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Social Links
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.language),
                      color: Colors.tealAccent,
                      onPressed: () {},
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: const Icon(Icons.discord),
                      color: Colors.tealAccent,
                      onPressed: () {},
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: const Icon(Icons.code),
                      color: Colors.tealAccent,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.tealAccent,
        child: const Icon(Icons.save, color: Colors.black),
        onPressed: () {
          // Save changes
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Changes saved successfully!'),
              backgroundColor: Colors.tealAccent,
            ),
          );
        },
      ),
    );
  }
}
