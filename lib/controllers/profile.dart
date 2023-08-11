import 'dart:async';

import 'package:dio/dio.dart' as di;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ujilevel_bk/helper/dio.dart';

class ProfileController {
  final storage = const FlutterSecureStorage();

  Future<void> addProfilePhoto(String filePath) async {
    try {
      // Get the user's token from your authentication system
      final token = await storage.read(key: 'auth');

      di.FormData formData = di.FormData.fromMap({
        'photo': await di.MultipartFile.fromFile(filePath),
      });

      di.Response res = await dio().post('add-profile-photo',
          options: di.Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Accept': 'application/json',
            },
          ),
          data: formData);

      if (res.statusCode == 200) {
        print('Profile photo updated');
        // Handle success, if needed
      } else {
        print('Failed to update profile photo: ${res.data}');
        // Handle errors, if needed
      }
    } catch (e) {
      print('Error while updating profile photo: $e');
      // Handle errors, if needed
    }
  }

  Future<void> deleteProfilePhoto() async{
    try {

      final token = await storage.read(key: 'auth');

      di.Response res = await dio().delete('delete-profile-photo',
        options: di.Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Accept': 'application/json',
            },
          ),     
      );

    } catch (e) {
      print('Error while deleting profile photo: $e');
    }
  }

  final di.Dio _dio = di.Dio();

  Future<void> updateProfile(String? userId, Map<String, dynamic> data) async {
    final token = await storage.read(key: 'auth');

    try {
      di.Response res = await dio().put('edit-student/$userId',
          options: di.Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Accept': 'application/json',
            },
          ),
          data: data);

      // print('$userId');

      if (res.statusCode == 200) {
        // Update successful
        print('Data Berhasil Diedit!');
        print(res.data);
        

      } else {
        // Handle error scenarios
        print('Update failed: ${res.data}');
      }
    } catch (error) {
      // Handle Dio errors or network issues
      print('Error: $error');
    }
  }

  
}
