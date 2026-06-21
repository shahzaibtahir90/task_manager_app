import 'dart:convert';
import 'dart:io';

class ImageService {
  Future<String> encodeProfileImage(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    return base64Encode(bytes);
  }
}
