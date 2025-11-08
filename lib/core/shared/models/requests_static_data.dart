import 'dart:async';

import 'package:flutter/material.dart';
import 'package:find_me_app/core/helpers/extensions/context.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/routes.dart';
import 'package:find_me_app/core/resources/strings.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ListTileModel {
  final String title;
  final IconData? icon;
  final String? svgIcon;
  final Color color;
  final Function()? onTap;

  ListTileModel({
    required this.title,
    this.icon,
    this.svgIcon,
    required this.color,
    required this.onTap,
  });
}

List<ListTileModel> kRequests(BuildContext context) => [
      ListTileModel(
        title: AppStrings.vacationRequest,
        icon: Icons.beach_access_rounded,
        color: AppColors.daisyBush800,
        onTap: () {
          unawaited(context.back());
          context.toNamed(AppRoutes.vacationRequestRoute);
        },
      ),
      ListTileModel(
        title: AppStrings.leaveRequest,
        icon: Icons.logout_rounded,
        color: AppColors.scooter800,
        onTap: () {
          unawaited(context.back());
          context.toNamed(AppRoutes.leaveRequestRoute);
        },
      ),
      ListTileModel(
        title: AppStrings.loanRequest,
        icon: Icons.paid_rounded,
        color: AppColors.saltBox900,
        onTap: () {
          unawaited(context.back());
          context.toNamed(AppRoutes.loanRequestRoute);
        },
      ),
      ListTileModel(
        title: AppStrings.financialClaim,
        icon: Icons.receipt_long_rounded,
        color: AppColors.error800,
        onTap: () {
          unawaited(context.back());
          context.toNamed(AppRoutes.financialClaimRequestRoute);
        },
      ),
      ListTileModel(
        title: AppStrings.overtimeRequest,
        icon: MdiIcons.clockTimeFour,
        color: AppColors.warning800,
        onTap: () {
          unawaited(context.back());
          context.toNamed(AppRoutes.overtimeRequestRoute);
        },
      ),
      ListTileModel(
        title: AppStrings.letterRequest,
        icon: MdiIcons.emailArrowRight,
        color: AppColors.success800,
        onTap: () {
          unawaited(context.back());
          context.toNamed(AppRoutes.letterRequestRoute);
        },
      ),
  ListTileModel(
    title: AppStrings.terminationRequest,
    icon: MdiIcons.emailArrowRight,
    color: AppColors.warning800,
    onTap: () {
      unawaited(context.back());
      context.toNamed(AppRoutes.terminationRequestRoute);
    },
  ),
  ListTileModel(
    title: AppStrings.businessTrips,
    icon: MdiIcons.airplane,
    color: AppColors.mojo800,
    onTap: () {
      unawaited(context.back());
      context.toNamed(AppRoutes.businessTripsRoute);
    },
  ),
      //TODO: Not Implemented yet
      // ListTileModel(
      //   title: AppStrings.businessTripRequest,
      //   icon: MdiIcons.airplane,
      //   color: AppColors.mojo800,
      //   onTap: () {
      //     unawaited(context.back());
      //     context.toNamed(AppRoutes.businessTripRequestRoute);
      //   },
      // ),



];
