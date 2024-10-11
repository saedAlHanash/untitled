import 'package:fitness_storm/core/api_manager/api_url.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:m_cubit/abstraction.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../data/response/payments.dart';

part 'payments_state.dart';

class PaymentsCubit extends MCubit<PaymentsInitial> {
  PaymentsCubit() : super(PaymentsInitial.initial());

  @override
  String get nameCache => '${AppSharedPreference.getLocal}payments';

  @override
  String get filter => state.filter;

  Future<void> getPayments({bool newData = false}) async {
    await getDataAbstract(
      fromJson: Payment.fromJson,
      state: state,
      getDataApi: _getData,
      newData: newData,
    );
  }

  Future<Pair<List<Payment>?, String?>> _getData() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.myPayments,
    );

    if (response.statusCode.success) {
      return Pair(Payments.fromJson(response.jsonBodyPure).data, null);
    } else {
      return response.getPairError;
    }
  }

  Future<void> addPayment(Payment item) async {
    final listJson = await addOrUpdateDate([item]);
    if (listJson == null) return;
    final list = listJson.map((e) => Payment.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }

  Future<void> deletePaymentFromCache(String id) async {
    final listJson = await deleteDate([id]);
    if (listJson == null) return;
    final list = listJson.map((e) => Payment.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }
}
