part of 'messages_cubit.dart';

class MessagesInitial extends AbstractState<List<types.Message>> {
  final StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? stream;

  const MessagesInitial({
    required super.result,
    super.statuses,
    super.request,
    this.stream,
  });

  types.Room get mRequest => request as types.Room;

  @override
  List<Object?> get props => [
        statuses,
        error,
        result,
        if (request != null) request,
        if (stream != null) stream,
      ];

  factory MessagesInitial.initial() {
    return const MessagesInitial(
      result: <types.Message>[],
      statuses: CubitStatuses.init,
    );
  }

  MessagesInitial copyWith({
    CubitStatuses? statuses,
    List<types.Message>? result,
    types.Room? request,
    StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? stream,
  }) {
    return MessagesInitial(
        statuses: statuses ?? this.statuses,
        result: result ?? this.result,
        request: request ?? this.request,
        stream: stream ?? this.stream);
  }
}
