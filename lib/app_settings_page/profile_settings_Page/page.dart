import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:moviewer/providers/user_provider.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  File? _image;
  final _picker = ImagePicker();

  bool _isProfileLoading = false;
  bool _isEmailLoading = false;
  bool _isPasswordLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // call the provider
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final user = userProvider.user;
      if (user != null) {
        _usernameController.text = user.username;
        _emailController.text = user.email;
      }
    });
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _updateProfile() async {
    setState(() => _isProfileLoading = true);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    if (user != null) {
      user.username = _usernameController.text;
      userProvider.setUser(user);
    }
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isProfileLoading = false);
    _showSuccessSnackBar('Profile updated successfully!');
  }

  Future<void> _updateEmail() async {
    setState(() => _isEmailLoading = true);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    if (user != null) {
      user.email = _emailController.text;
      userProvider.setUser(user);
      // Here you would typically update the user's email in your database as well
    }
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isEmailLoading = false);
    _showSuccessSnackBar('Email updated successfully!');
  }

  Future<void> _updatePassword() async {
    setState(() => _isPasswordLoading = true);
    // Here you would typically verify the current password and update the new password in your database
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isPasswordLoading = false);
    _showSuccessSnackBar('Password updated successfully!');
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(10),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Profile Settings'),
      ),
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Profile Photo Section
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.surface,
                            image: _image != null
                                ? DecorationImage(
                                    image: FileImage(_image!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: _image == null
                              ? Icon(Icons.person,
                                  size: 80,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color
                                      ?.withOpacity(0.5))
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: FloatingActionButton(
                            mini: true,
                            onPressed: _pickImage,
                            child: const Icon(Icons.camera_alt),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Profile Information Section
                    _buildCard(
                      context,
                      title: 'Profile Information',
                      icon: Icons.person_outline,
                      isLoading: _isProfileLoading,
                      onSave: _updateProfile,
                      child: TextField(
                        controller: _usernameController,
                        decoration: _buildInputDecoration(
                            context, 'Username', Icons.person),
                      ),
                    ),

                    // Email Section
                    _buildCard(
                      context,
                      title: 'Email Settings',
                      icon: Icons.email_outlined,
                      isLoading: _isEmailLoading,
                      onSave: _updateEmail,
                      child: TextField(
                        controller: _emailController,
                        decoration: _buildInputDecoration(
                            context, 'Email', Icons.email),
                      ),
                    ),

                    // Password Section
                    _buildCard(
                      context,
                      title: 'Change Password',
                      icon: Icons.lock_outline,
                      isLoading: _isPasswordLoading,
                      onSave: _updatePassword,
                      child: Column(
                        children: [
                          TextField(
                            controller: _currentPasswordController,
                            obscureText: true,
                            decoration: _buildInputDecoration(
                                context, 'Current Password', Icons.lock),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _newPasswordController,
                            obscureText: true,
                            decoration: _buildInputDecoration(
                                context, 'New Password', Icons.lock),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _confirmPasswordController,
                            obscureText: true,
                            decoration: _buildInputDecoration(
                                context, 'Confirm Password', Icons.lock),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildCard(BuildContext context,
      {required String title,
      required IconData icon,
      required bool isLoading,
      required VoidCallback onSave,
      required Widget child}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ExpansionTile(
        title: Text(title),
        leading: Icon(icon),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                child,
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: isLoading ? null : onSave,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Save Changes'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _buildInputDecoration(
      BuildContext context, String labelText, IconData icon) {
    return InputDecoration(
      labelText: labelText,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
