import 'package:bloc/bloc.dart';

part 'refresh_home_plan_state.dart';

class RefreshHomePlanCubit extends Cubit<RefreshHomePlanState> {
  RefreshHomePlanCubit() : super(RefreshHomePlanState.initial());

  void refresh() {
    emit(state.copyWith(count: state.count + 1));
  }
}
