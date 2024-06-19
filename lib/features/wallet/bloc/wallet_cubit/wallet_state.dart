part of 'wallet_cubit.dart';

class WalletInitial extends AbstractState<List<Wallet>> {
  // final WalletRequest request;
  // final  bool walletParam;
  const WalletInitial({
    required super.result,
    super.error,
    // required this.request,
    // required this.walletParam,
    super.statuses,
  });//

  factory WalletInitial.initial() {
    return const WalletInitial(
      result: [],
      error: '',
      // walletParam: false,
      // request: WalletRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  WalletInitial copyWith({
    CubitStatuses? statuses,
    List<Wallet>? result,
    String? error,
    // WalletRequest? request,
    // bool? walletParam,
  }) {
    return WalletInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      // request: request ?? this.request,
      // walletParam: walletParam ?? this.walletParam,
    );
  }
}
