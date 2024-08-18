part of 'open_room_cubit.dart';

class OpenRoomInitial extends AbstractState<Room?> {
  const OpenRoomInitial({
    required super.result,
    super.error,
    super.request,
    super.statuses,
  });

  factory OpenRoomInitial.initial() {
    return const OpenRoomInitial(
      result: null,
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [
        statuses,
        error,
        if (result != null) result!,
        if (request != null) request,
      ];

  OpenRoomInitial copyWith({
    CubitStatuses? statuses,
    Room? result,
    String? error,
    dynamic request,
    // Room?? open_roomParam,
  }) {
    return OpenRoomInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
      // open_roomParam: open_roomParam ?? this.open_roomParam,
    );
  }
}
