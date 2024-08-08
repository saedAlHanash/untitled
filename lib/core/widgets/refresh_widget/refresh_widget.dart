import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../strings/app_color_manager.dart';

class RefreshWidget extends StatefulWidget {
  const RefreshWidget({
    super.key,
    required this.child,
    this.onRefresh,
    required this.isLoading,
  });

  final Widget child;
  final Function()? onRefresh;
  final bool isLoading;

  @override
  State<RefreshWidget> createState() => _RefreshWidgetState();
}

class _RefreshWidgetState extends State<RefreshWidget> {
  final _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    widget.onRefresh?.call();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      _refreshController.refreshCompleted();
    } else if (widget.isLoading) {
      if (!_refreshController.isRefresh) {
        Future(() => _refreshController.requestRefresh(
            needCallback: false, duration: Duration.zero, needMove: false));
      }
      _refreshController.loadComplete();
    }
    return SmartRefresher(
      enablePullDown: true,
      header: const WaterDropHeader(
        waterDropColor: AppColorManager.mainColor,
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      child: widget.child,
    );
  }
}
