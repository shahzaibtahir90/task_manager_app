import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? imageBase64;
  final String name;
  final double radius;
  final File? localImage;

  const ProfileAvatar({
    super.key,
    required this.name,
    this.imageUrl,
    this.imageBase64,
    this.localImage,
    this.radius = 50,
  });

  String get _initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  ImageProvider? _resolveImageProvider() {
    if (localImage != null) {
      return FileImage(localImage!);
    }

    if (imageBase64 != null && imageBase64!.isNotEmpty) {
      return MemoryImage(base64Decode(imageBase64!));
    }

    if (imageUrl != null && imageUrl!.trim().isNotEmpty) {
      return NetworkImage(imageUrl!);
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = _resolveImageProvider();

    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.deepPurple.shade100,
      backgroundImage: imageProvider,
      child: imageProvider == null
          ? Text(
              _initials,
              style: TextStyle(
                fontSize: radius * 0.7,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            )
          : null,
    );
  }
}
