import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io';

class ProfileController {
  final storage = const FlutterSecureStorage();

  Future<void> updateProfilePhoto(File photo) async {
    final token = await storage.read(key: 'auth');
    final formData = FormData.fromMap({
      'photo': await MultipartFile.fromFile(photo.path),
    });

    final response = await Dio().put(
      'http://127.0.0.1:8000/api/add-profile-photo',
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (response.statusCode == 200) {
      print('Profile photo updated successfully');
    } else {
      throw Exception('Failed to update profile photo');
    }
  }

  // Replace 'your_api_base_url' with the actual base URL of your backend server
  String apiBaseUrl = 'http://127.0.0.1:8000/api';

  Future<void> addProfilePhoto(String filePath) async {
    try {
      // Get the user's token from your authentication system
      final token = await storage.read(key: 'auth');

      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';

      FormData formData = FormData.fromMap({
        'photo': await MultipartFile.fromFile(filePath),
      });

      Response response =
          await dio.post('$apiBaseUrl/addProfilePhoto', data: formData);

      if (response.statusCode == 200) {
        print('Profile photo updated');
        // Handle success, if needed
      } else {
        print('Failed to update profile photo: ${response.data}');
        // Handle errors, if needed
      }
    } catch (e) {
      print('Error while updating profile photo: $e');
      // Handle errors, if needed
    }
  }
}
