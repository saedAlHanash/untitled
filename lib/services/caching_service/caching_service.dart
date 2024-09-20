// import 'dart:convert';
//
// import 'package:fitness_storm/core/api_manager/api_service.dart';
// import 'package:fitness_storm/core/extensions/extensions.dart';
// import 'package:flutter_chat_types/flutter_chat_types.dart';
// import 'package:hive_flutter/hive_flutter.dart';
//
// import '../../core/strings/enum_manager.dart';
//
// const latestUpdateBox = 'latestUpdateBox';
// const version = 2;
//
// class CachingService {
//   static var timeInterval = 180;
//
//   static Future<void> initial() async {
//     await Hive.initFlutter();
//   }
//
//   static Future<void> updateLatestUpdateBox(String name) async {
//     final boxUpdate = await getBox(latestUpdateBox);
//
//     await boxUpdate.put(name, DateTime.now().toIso8601String());
//   }
//
//   static Future<void> sortData({
//     required dynamic data,
//     required String name,
//     String filter = '',
//   }) async {
//     await updateLatestUpdateBox(name);
//
//     final haveId = _getIdParam(data).isNotEmpty;
//
//     final key = CacheKey(
//       id: '',
//       filter: filter,
//       version: version,
//     );
//
//     final box = await getBox(name);
//
//     if (data is Iterable) {
//       await clearKeysId(box: box, filter: key);
//       for (var e in data) {
//         final id = haveId ? _getIdParam(e) : '';
//         final keyString = key.copyWith(id: id).jsonString;
//         await box.put(keyString, jsonEncode(e));
//       }
//       return;
//     }
//
//     final keyString = key.copyWith(id: haveId ? _getIdParam(data) : '').jsonString;
//
//     try {
//       await box.put(keyString, jsonEncode(data));
//     } catch (e) {
//       loggerObject.e('sortData SingleData $name $e');
//     }
//   }
//
//   static Future<void> sortDataChat({
//     required Iterable<dynamic> data,
//     required String name,
//     String filter = '',
//   }) async {
//     await updateLatestUpdateBox(name);
//
//     final haveId = _getIdParam(data).isNotEmpty;
//
//     final key = CacheKey(
//       id: '',
//       filter: filter,
//       version: version,
//     );
//
//     final box = await getBox(name);
//
//     for (var e in data) {
//       final id = haveId ? _getIdParam(e) : '';
//       final keyString = key.copyWith(id: id).jsonString;
//       await box.put(keyString, jsonEncode(e));
//     }
//   }
//
//   static Future<Iterable<dynamic>?> addOrUpdate({
//     required List<dynamic> data,
//     required String name,
//     required String filter,
//   }) async {
//     final key = CacheKey(
//       id: getIdFromData(data),
//       filter: filter,
//       version: version,
//     );
//
//     if (key.id.isEmpty) return null;
//
//     final box = await getBox(name);
//
//     for (var d in data) {
//       final keys = box.keys.where((e) => jsonDecode(e)['id'] == d.id);
//
//       final item = jsonEncode(d);
//
//       final mapUpdate = Map.fromEntries(keys.map((key) => MapEntry(key, item)));
//
//       //if not found the operation is add
//       if (mapUpdate.isEmpty) mapUpdate[key.jsonString] = item;
//
//       await box.putAll(mapUpdate);
//     }
//
//     return await getList(name, filter: filter);
//   }
//
//   static Future<Iterable<dynamic>?> delete({
//     required List<String> data,
//     required String name,
//     required String filter,
//   }) async {
//     if (getIdFromData(data).isEmpty) return null;
//
//     final box = await getBox(name);
//
//     for (var id in data) {
//       final keys = box.keys.where((e) {
//         return jsonDecode(e)['id'] == id;
//       });
//
//       await box.deleteAll(keys);
//     }
//
//     return await getList(name, filter: filter);
//   }
//
//   static Future<void> clearKeysId({
//     required Box<String> box,
//     required CacheKey filter,
//   }) async {
//     final keys = box.keys.where((e) {
//       final keyCache = jsonDecode(e);
//       return keyCache['filter'] == filter.filter;
//     });
//
//     await box.deleteAll(keys);
//   }
//
//   static Future<Iterable<dynamic>> getList(
//     String name, {
//     String filter = '',
//   }) async {
//     final box = await getBox(name);
//     final listKeys = box.keys.toList();
//
//     List<dynamic> f = [];
//
//     for (var i = 0; i < listKeys.length; i++) {
//       try {
//         final keyCache = CacheKey.fromJson(jsonDecode(listKeys[i]));
//
//         if (keyCache.version != version) {
//           listKeys.removeAt(i);
//           await box.deleteAt(i);
//           i -= 1;
//           continue;
//         }
//
//         if (keyCache.filter == filter) f.add(listKeys[i]);
//       } catch (e) {
//         listKeys.removeAt(i);
//         await box.deleteAt(i);
//         i -= 1;
//         loggerObject.e(e);
//       }
//     }
//
//     return f.map((e) => jsonDecode(box.get(e) ?? '{}'));
//   }
//
//   static Future<Iterable<Message>> getListChat(
//     String name, {
//     String filter = '',
//   }) async {
//     final nowTimeMillis = DateTime.now().millisecondsSinceEpoch;
//     final box = await getBox(name);
//
//     final listKeys = box.keys.toList();
//
//     final listMessages = <Message>[];
//
//     for (var i = 0; i < listKeys.length; i++) {
//       try {
//         final keyCache = CacheKey.fromJson(jsonDecode(listKeys[i]));
//
//         if (keyCache.version != version) {
//           await _removeFromListBox(listKeys, i, box);
//           continue;
//         }
//
//         if (keyCache.filter == filter) {
//           final message = Message.fromJson(jsonDecode(box.get(listKeys[i]) ?? '{}'));
//
//           if (isMoreThanOneMonth(message.createdAt ?? 0, nowTimeMillis) &&
//               (message.type == MessageType.file || message.type == MessageType.video)) {
//             await _removeFromListBox(listKeys, i, box);
//             continue;
//           }
//
//           listMessages.add(message);
//         }
//       } catch (e) {
//         await _removeFromListBox(listKeys, i, box);
//         loggerObject.e(e);
//       }
//     }
//
//     return listMessages;
//   }
//
//   static bool isMoreThanOneMonth(int firstTimestamp, int secondTimestamp) {
//     int result = (firstTimestamp - secondTimestamp).abs();
//
//     final r = result > 2592000000;
//     if (r) loggerObject.f(r);
//     return r;
//   }
//
//   static Future<void> _removeFromListBox(
//       List<dynamic> listKeys, int i, Box<String> box) async {
//     listKeys.removeAt(i);
//     await box.deleteAt(i);
//     i = i - 1;
//   }
//
//   static Future<dynamic> getData(
//     String name, {
//     String filter = '',
//   }) async {
//     final box = await getBox(name);
//
//     final listKeys = box.keys.toList();
//
//     dynamic keyBox;
//
//     for (var i = 0; i < listKeys.length; i++) {
//       try {
//         final keyCache = CacheKey.fromJson(jsonDecode(listKeys[i]));
//         if (keyCache.version != version) {
//           listKeys.removeAt(i);
//           await box.deleteAt(i);
//           i -= 1;
//           continue;
//         }
//         if (keyCache.filter == filter) {
//           keyBox = listKeys[i];
//           break;
//         }
//       } catch (e) {
//         listKeys.removeAt(i);
//         await box.deleteAt(i);
//         i -= 1;
//         loggerObject.e(e);
//       }
//     }
//
//     if (keyBox == null) return null;
//     final dataByKey = box.get(keyBox);
//
//     if (dataByKey == null) return null;
//
//     return jsonDecode(dataByKey);
//   }
//
//   static Future<Box<String>> getBox(String name) async {
//     return Hive.isBoxOpen(name)
//         ? Hive.box<String>(name)
//         : await Hive.openBox<String>(name);
//   }
//
//   static Future<NeedUpdateEnum> needGetData(
//     String name, {
//     String filter = '',
//     int? timeInterval,
//   }) async {
//     final box = await getBox(name);
//
//     final listKeys = box.keys.toList();
//
//     dynamic keyFounded;
//
//     for (var i = 0; i < listKeys.length; i++) {
//       try {
//         final keyCache = CacheKey.fromJson(jsonDecode(listKeys[i]));
//         if (keyCache.version != version) {
//           listKeys.removeAt(i);
//           await box.deleteAt(i);
//           i -= 1;
//           continue;
//         }
//         if (keyCache.filter == filter) {
//           keyFounded = listKeys[i];
//           break;
//         }
//       } catch (e) {
//         listKeys.removeAt(i);
//         await box.deleteAt(i);
//         i -= 1;
//         loggerObject.e(e);
//       }
//     }
//
//     if (keyFounded == null) {
//       return NeedUpdateEnum.withLoading;
//     }
//
//     final latest = DateTime.tryParse((await getBox(latestUpdateBox)).get(name) ?? '');
//
//     if (latest == null) {
//       return NeedUpdateEnum.withLoading;
//     }
//
//     final d = DateTime.now().difference(latest).inSeconds.abs();
//
//     if (d > (timeInterval ?? CachingService.timeInterval)) {
//       return NeedUpdateEnum.noLoading;
//     }
//
//     return NeedUpdateEnum.no;
//   }
//
//   static String getIdFromData(dynamic data) {
//     return _getIdParam(data);
//   }
//
//   static String _getIdParam(dynamic data) {
//     try {
//       if (data is Map) {
//         return data['id'];
//       }
//       if (data is List) {
//         if (data.first is String) return data.first;
//         return (data.first.id.toString().isBlank) ? '-' : data.first.id.toString();
//       } else {
//         return (data.id.toString().isBlank) ? '-' : data.id.toString();
//       }
//     } catch (e) {
//       return '-1';
//     }
//   }
// }
//
// class CacheKey {
//   CacheKey({
//     required this.id,
//     required this.filter,
//     required this.version,
//   }) {
//     filter = filter.replaceAll('null', '');
//   }
//
//   final String id;
//   String filter;
//   final num version;
//
//   factory CacheKey.fromJson(Map<String, dynamic> json) {
//     return CacheKey(
//       id: json["id"] ?? "",
//       filter: json["filter"] ?? "",
//       version: json["version"] ?? 0,
//     );
//   }
//
//   bool isMatchFilter(CacheKey key) {
//     return filter == key.filter;
//   }
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "filter": filter,
//         "version": version,
//       };
//
//   String get jsonString => jsonEncode(this);
//
//   CacheKey copyWith({
//     String? id,
//     String? filter,
//     num? version,
//   }) {
//     return CacheKey(
//       id: id ?? this.id,
//       filter: filter ?? this.filter,
//       version: version ?? this.version,
//     );
//   }
// }
