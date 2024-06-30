// import 'dart:async';
//
// import 'package:fitness_storm/core/api_manager/api_service.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
//
// import '../core/api_manager/api_url.dart';
//
// class ServerTimeService {
//
//
//
//   static DateTime _getDateTimeFromHeaders(http.Response response) {
//     final headers = response.headers;
//
//     if (headers.containsKey('date')) {
//       final dateString = headers['date']!;
//       final dateTime = _parseGMTDate(dateString);
//       return dateTime;
//     } else {
//       return DateTime.now();
//     }
//   }
//
//   static DateTime _parseGMTDate(String dateString) {
//     try {
//       final dateFormat = DateFormat('E, d MMM yyyy hh:mm:ss Z', 'en_US');
//       final d = dateFormat.parse(dateString);
//       return d;
//     } catch (e) {
//       loggerObject.e(e);
//       return DateTime.now().toUtc();
//     }
//   }
// }
