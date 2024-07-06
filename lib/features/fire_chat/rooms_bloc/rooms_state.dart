part of 'rooms_cubit.dart';

class RoomsInitial extends AbstractState<List<types.Room>> {
  final StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? stream;
final String search;
  const RoomsInitial({
    required super.result,
    super.statuses,
    super.request,
    super.error,
    this.stream,
    this.search = '',
  });

  bool get mRequest => request as bool;

  @override
  List<Object?> get props => [
        statuses,
        error,
        result,
        search,
        if (request != null) request,
        if (stream != null) stream,
      ];

  factory RoomsInitial.initial() {
    return const RoomsInitial(
      result: [],
      statuses: CubitStatuses.init,
    );
  }

  bool get notRead=>result.firstWhereOrNull((e) => e.isNotRead) != null;
  RoomsInitial copyWith({
    CubitStatuses? statuses,
    List<types.Room>? result,
    String? error,
    String? search,
    bool? request,
    StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? stream,
  }) {
    return RoomsInitial(
        statuses: statuses ?? this.statuses,
        result: result ?? this.result,
        error: error ?? this.error,
        search: search ?? this.search,
        request: request ?? this.request,
        stream: stream ?? this.stream);
  }
}
