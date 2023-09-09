import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:saed_http/api_manager/api_service.dart';
import 'package:saed_http/pair_class.dart';

import '../../../../Utils/storage_controller.dart';
import '../data/response/coupon_response.dart';

part 'coupon_state.dart';

enum CubitStatuses { init, loading, done, error }

extension CubitStatusesHelper on CubitStatuses {
  bool get loading => this == CubitStatuses.loading;

  bool get done => this == CubitStatuses.done;
}

class CouponCubit extends Cubit<CouponInitial> {
  CouponCubit() : super(CouponInitial.initial());

  Future<void> checkCoupon(BuildContext context, {String? couponCode}) async {
    if (couponCode == null || couponCode.isEmpty) return;
    emit(state.copyWith(statuses: CubitStatuses.loading));
    final pair = await _checkCouponApi(couponCode: couponCode);

    if (pair.first == null) {
      if (context.mounted) {}
      emit(state.copyWith(statuses: CubitStatuses.error, error: pair.second));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  Future<Pair<CheckCouponResult?, String?>> _checkCouponApi({
    required String couponCode,
  }) async {
    APIService()
      ..baseUrl = 'api.fitnessstorm.org'
      ..innerHeader.addAll(
        {
          'authorization': 'Bearer ${StorageController().token}',
        },
      );

    final response = await APIService().postApi(
      url: 'mobile/user/coupons/checkCoupon',
      query: {
        'code': couponCode,
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
