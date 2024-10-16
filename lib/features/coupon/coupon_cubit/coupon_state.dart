part of 'coupon_cubit.dart';

class CouponInitial extends AbstractState<CheckCouponResult> {


  const CouponInitial({
    required super.statuses,
    required super.result,
    required super.error,
  });

  factory CouponInitial.initial() {
    return CouponInitial(
      result: CheckCouponResult.fromJson({}),
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  CouponInitial copyWith({
    CubitStatuses? statuses,
    CheckCouponResult? result,
    String? error,
  }) {
    return CouponInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}