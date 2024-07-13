import 'package:drawable_text/drawable_text.dart';
import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/core/strings/app_color_manager.dart';
import 'package:fitness_storm/core/widgets/app_bar/app_bar_widget.dart';
import 'package:fitness_storm/core/widgets/not_found_widget.dart';
import 'package:fitness_storm/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/models/booked_appointments.dart';
import '../../../../core/util/my_style.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/booked_appointments_cubit/booked_appointments_cubit.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(titleText: S.of(context).privateSession),
      body: Padding(
        padding: const EdgeInsets.all(20.0).r,
        child: BlocBuilder<BookedAppointmentsCubit, BookedAppointmentsInitial>(
          builder: (context, state) {
            if (state.statuses.loading) {
              return MyStyle.loadingWidget();
            }
            if (state.result.isEmpty) {
              return NotFoundWidget(text: S.of(context).noMoreData);
            }

            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: AppColorManager.f8,
                      borderRadius: BorderRadius.all(Radius.circular(12.0.r))),
                  height: 42.h,
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    controller: _tabController,
                    indicator: BoxDecoration(
                        color: AppColorManager.mainColor,
                        borderRadius:
                            BorderRadius.all(Radius.circular(12.0.r))),
                    labelStyle: TextStyle(
                      fontSize: 16.0.sp,
                      fontFamily: FontManager.cairoBold.name,
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontSize: 16.0.sp,
                      fontFamily: FontManager.cairoBold.name,
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: AppColorManager.mainColor,
                    tabs: [
                      Tab(text: S.of(context).oldSession),
                      Tab(text: S.of(context).nextSession),
                    ],
                  ),
                ),
                10.0.verticalSpace,
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _ListSessions(list: state.old, isOld: true),
                      _ListSessions(list: state.next, isOld: false),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ListSessions extends StatelessWidget {
  const _ListSessions({required this.list, required this.isOld});

  final List<Appointment> list;

  final bool isOld;

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      return NotFoundWidget(text: S.of(context).noMoreData);
    }
    return RefreshIndicator(
      onRefresh: () async {
        context.read<BookedAppointmentsCubit>().getBookedAppointments();
      },
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (_, i) {
          return _ItemAppointment(item: list[i], isOld: isOld);
        },
      ),
    );
  }
}

class _ItemAppointment extends StatelessWidget {
  const _ItemAppointment({required this.item, required this.isOld});

  final Appointment item;
  final bool isOld;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          //TODO: change this
          onTap: () {
            if (!item.isNow) return;
            if (item.videoCallToken.isEmpty) {
              context.read<BookedAppointmentsCubit>().getBookedAppointments();
              return;
            }
            startVideoCall(item);
          },
          trailing: item.isNow
              ? Container(
                  height: 10.0.r,
                  width: 10.0.r,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                )
              : isOld
                  ? item.rate != null
                      ? RatingBarIndicator(
                          itemCount: 5,
                          rating: item.rate!.rating.toDouble(),
                          itemSize: 15.0.r,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 10.0.r,
                          ),
                        )
                      : IconButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                                AppColorManager.cardColor),
                          ),
                          onPressed: () => startRating(item),
                          icon: const ImageMultiType(
                            url: Icons.star,
                            color: AppColorManager.mainColor,
                          ),
                        )
                  : null,
          leading: CircleImageWidget(url: item.user.image, size: 50.0.r),
          title: DrawableText(text: item.user.name),
          subtitle: DrawableText(
            text: item.startTime.formatDateTime,
            color: Colors.grey,
            size: 12.0.sp,
          ),
        ),
        Divider(
            color: AppColorManager.cardColor,
            indent: 10.0.w,
            endIndent: 10.0.w),
      ],
    );
  }
}
