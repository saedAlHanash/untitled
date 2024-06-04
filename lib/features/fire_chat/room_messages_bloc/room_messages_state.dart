part of 'room_messages_cubit.dart';

class MessagesInitial  {
  final CubitStatuses statuses;
  final List<types.Message> allMessages;
  final String roomId;
  final types.Room room;
  final int oldLength;
  final StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? stream;

  const MessagesInitial({
    required this.statuses,
    required this.allMessages,
    required this.roomId,
    required this.room,
    required this.oldLength,
    this.stream,
  });

  factory MessagesInitial.initial() {
    return MessagesInitial(
      // allMessages:
      //     messageBox.values.map((e) => types.Message.fromJson(jsonDecode(e))).toList()
      //       ..sort((a, b) => (b.createdAt ?? 0).compareTo(a.createdAt ?? 0)),
      allMessages: [],
      roomId: '',
      room: const types.Room(id: '0', type: RoomType.direct, users: []),
      oldLength: messageBox.length,
      statuses: CubitStatuses.init,
    );
  }


  MessagesInitial copyWith({
    CubitStatuses? statuses,
    List<types.Message>? allMessages,
    String? roomId,
    types.Room? room,
    int? oldLength,
    StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? stream,
  }) {
    return MessagesInitial(
        statuses: statuses ?? this.statuses,
        allMessages: allMessages ?? this.allMessages,
        roomId: roomId ?? this.roomId,
        room: room ?? this.room,
        oldLength: oldLength ?? this.oldLength,
        stream: stream ?? this.stream);
  }
}
