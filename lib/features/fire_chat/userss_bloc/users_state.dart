part of 'users_bloc.dart';

class UsersInitial extends AbstractState<List<types.User>> {
  final StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? stream;
  final String search;

  const UsersInitial({
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

  factory UsersInitial.initial() {
    return const UsersInitial(
      result: [],

      statuses: CubitStatuses.init,
    );
  }


  UsersInitial copyWith({
    CubitStatuses? statuses,
    List<types.User>? result,
    List<types.User>? myUsers,
    List<types.User>? othersUsers,
    String? error,
    String? search,
    bool? request,
    StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? stream,
  }) {
    return UsersInitial(
        statuses: statuses ?? this.statuses,
        result: result ?? this.result,
        error: error ?? this.error,
        search: search ?? this.search,
        request: request ?? this.request,
        stream: stream ?? this.stream);
  }
}
