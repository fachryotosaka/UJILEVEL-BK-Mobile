import 'package:dio/dio.dart' as di;
import 'package:ujilevel_bk/helper/dio.dart';
import 'package:ujilevel_bk/models/consultation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ConsultationController {
  Consultation? _consultation;
  Consultation? get consultation => _consultation;

  Future<List<Consultation>> getConsultation() async {
    const storage = FlutterSecureStorage();
    try {
      final token = await storage.read(key: 'auth');

      di.Response res = await dio().get(
        '/archive-schedule',
        options: di.Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      if (res.statusCode == 200) {
        final List<dynamic> responseData = res.data['consultations'];
        final List<Consultation> consultations =
            responseData.map((json) => Consultation.fromJson(json)).toList();
        return consultations;
      } else {
        throw Exception('Failed to fetch consultation');
      }
    } catch (e) {
      throw Exception('Failed to fetch consultation: $e');
    }
  }
}
