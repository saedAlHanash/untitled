import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
 


import '../../../../Utils/storage_controller.dart';
import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../data/response/coupon_response.dart';

part 'coupon_state.dart';

extension CubitStatusesHelper on CubitStatuses {
  bool get loading => this == CubitStatuses.loading;

  bool get done => this == CubitStatuses.done;
}

class CouponCubit extends Cubit<CouponInitial> {
  CouponCubit() : super(CouponInitial.initial());

  Future<void> checkCoupon(
    BuildContext context, {
    String? couponCode,
    required String subscriptionId,
  }) async {
    if (couponCode == null || couponCode.isEmpty) return;
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair =
        await _checkCouponApi(couponCode: couponCode, subscriptionId: subscriptionId);

    if (pair.first == null) {
      if (context.mounted) {}
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<CheckCouponResult?, String?>> _checkCouponApi({
    required String couponCode,
    required String subscriptionId,
  }) async {

    final response = await APIService().postApi(
      url: 'mobile/user/coupons/checkCoupon',
      query: {
        'code': couponCode,
        'subscription_id': subscriptionId,
      },
    );

    if (response.statusCode == 200) {
      return Pair(CheckCouponResult.fromJson(jsonDecode(response.body)), null);
    } else {
      return Pair(null, 'Error Code : ${response.statusCode}');
    }
  }

  void reInit() => emit(CouponInitial.initial());
}
