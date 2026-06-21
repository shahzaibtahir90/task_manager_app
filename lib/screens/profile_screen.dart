import 'package:flutter/material.dart';
import 'package:flutter_internship_app/models/user_model.dart';
import 'package:flutter_internship_app/services/auth_service.dart';
import 'package:flutter_internship_app/services/firestore_service.dart';
import 'package:flutter_internship_app/widgets/custom_button.dart';
import 'package:flutter_internship_app/widgets/profile_avatar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _authService = AuthService();
  final _firestoreService = FirestoreService();
  bool _isLoading = false;

  void _logout() async {
    setState(() => _isLoading = true);

    try {
      await _authService.logout();

      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = _authService.getCurrentUser();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        elevation: 0,
      ),
      body: user == null
          ? const Center(child: Text('No user logged in'))
          : StreamBuilder<UserModel?>(
              stream: _firestoreService.getUserDataStream(user.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final userData = snapshot.data;
                final displayName = userData?.name ??
                    user.displayName ??
                    user.email?.split('@').first ??
                    'User';
                final displayEmail = userData?.email ?? user.email ?? '';
                final profileImageUrl = userData?.profileImageUrl ??
                    user.photoURL;
                final profileImageBase64 = userData?.profileImageBase64;
                final joinedDate =
                    userData?.createdAt ?? user.metadata.creationTime;

                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProfileAvatar(
                        name: displayName,
                        imageUrl: profileImageUrl,
                        imageBase64: profileImageBase64,
                        radius: 60,
                      ),
                      const SizedBox(height: 32),
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Name: ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  displayName,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                const Text(
                                  'Email: ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    displayEmail,
                                    style: const TextStyle(fontSize: 16),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            if (joinedDate != null) ...[
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  const Text(
                                    'Joined: ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${joinedDate.year}-${joinedDate.month.toString().padLeft(2, '0')}-${joinedDate.day.toString().padLeft(2, '0')}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      CustomButton(
                        label: 'Logout',
                        onPressed: _logout,
                        isLoading: _isLoading,
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
