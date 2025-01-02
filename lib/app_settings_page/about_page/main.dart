import 'package:flutter/material.dart';
import 'package:moviewer/app_settings_page/about_page/links_section.dart';
import 'package:moviewer/app_settings_page/about_page/social_links.dart';
import 'package:moviewer/app_settings_page/about_page/version_info.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VersionInfo(),
              SizedBox(height: 16),
              LinksSection(),
              SizedBox(height: 24),
              SocialLinks(),
            ],
          ),
        ),
      ),
    );
  }
}
