part of 'get_rooms_cubit.dart';

class RoomsInitial {
  final CubitStatuses statuses;
  final List<types.Room> allRooms;
  final List<types.Room> myRooms;
  final String error;
  final bool noReadMessages;
  final StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? stream;

  const RoomsInitial({
    required this.statuses,
    required this.allRooms,
    required this.error,
    required this.noReadMessages,
    required this.myRooms,
    this.stream,
  });

  factory RoomsInitial.initial() {
    final allFromHive = roomsBox.values.map((e) {
      return types.Room.fromJson(jsonDecode(e));
    }).toList()
      ..sort((a, b) => (b.updatedAt ?? 0).compareTo(a.updatedAt ?? 0));

    final myRoom = allFromHive.where((e) => _isMe(e)).toList()
      ..sort((a, b) => (b.updatedAt ?? 0).compareTo(a.updatedAt ?? 0));

    return RoomsInitial(
      allRooms: allFromHive,
      myRooms: myRoom,
      error: '',
      noReadMessages: false,
      statuses: CubitStatuses.init,
    );
  }

  RoomsInitial copyWith({
    CubitStatuses? statuses,
    List<types.Room>? allRooms,
    List<types.Room>? myRooms,
    String? error,
    bool? noReadMessages,
    StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? stream,
  }) {
    return RoomsInitial(
        statuses: statuses ?? this.statuses,
        allRooms: allRooms ?? this.allRooms,
        myRooms: myRooms ?? this.myRooms,
        error: error ?? this.error,
        noReadMessages: noReadMessages ?? this.noReadMessages,
        stream: stream ?? this.stream);
  }

  types.Room? getCostumerRoom() {
    return allRooms
        .firstWhereOrNull((e) => e.name?.contains('Customer Service') ?? false);
  }
}

bool _isMe(types.Room room) {
  for (var e in room.users) {
    if (e.id == firebaseUser?.uid) return true;
  }

  return false;
}
