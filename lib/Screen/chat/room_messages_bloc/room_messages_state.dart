part of 'room_messages_cubit.dart';

class RoomMessagesInitial  {
  final CubitStatuses statuses;
  final List<types.Message> allMessages;
  final String roomId;
  final int oldLength;
  final StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? stream;

  const RoomMessagesInitial({
    required this.statuses,
    required this.allMessages,
    required this.roomId,
    required this.oldLength,
    this.stream,
  });

  factory RoomMessagesInitial.initial() {
    return RoomMessagesInitial(
      allMessages:
          roomMessage.values.map((e) => types.Message.fromJson(jsonDecode(e))).toList()
            ..sort((a, b) => (b.createdAt ?? 0).compareTo(a.createdAt ?? 0)),
      roomId: '',
      oldLength: roomMessage.length,
      statuses: CubitStatuses.init,
    );
  }


  RoomMessagesInitial copyWith({
    CubitStatuses? statuses,
    List<types.Message>? allMessages,
    String? roomId,
    int? oldLength,
    StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? stream,
  }) {
    return RoomMessagesInitial(
        statuses: statuses ?? this.statuses,
        allMessages: allMessages ?? this.allMessages,
        roomId: roomId ?? this.roomId,
        oldLength: oldLength ?? this.oldLength,
        stream: stream ?? this.stream);
  }
}
