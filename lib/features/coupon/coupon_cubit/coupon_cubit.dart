import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../data/response/coupon_response.dart';

part 'coupon_state.dart';

class CouponCubit extends Cubit<CouponInitial> {
  CouponCubit() : super(CouponInitial.initial());

  Future<void> checkCoupon(
    BuildContext context, {
    String? couponCode,
    String? subscriptionId,
    String? bundleId,
  }) async {
    if (couponCode == null || couponCode.isEmpty) return;
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _checkCouponApi(
      couponCode: couponCode,
      subscriptionId: subscriptionId,
      bundleId: bundleId,
    );

    if (pair.first == null) {
      if (context.mounted) {}
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<CheckCouponResult?, String?>> _checkCouponApi({
    required String couponCode,
    String? subscriptionId,
    String? bundleId,
  }) async {
    final response = await APIService().callApi(type: ApiType.post,
      url: 'coupons/checkCoupon',
      query: {
        'code': couponCode,
        if(subscriptionId!=null)
        'subscription_id': subscriptionId,
        if(bundleId!=null)
        'bundle_id': bundleId,
      },
    );

    if (response.statusCode.success) {
      return Pair(CheckCouponResult.fromJson(jsonDecode(response.body)), null);
    } else {
      return Pair(null, 'Error Code : ${response.statusCode}');
    }
  }

  void reInit() => emit(CouponInitial.initial());
}
