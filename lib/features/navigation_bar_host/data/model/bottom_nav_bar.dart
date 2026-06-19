import 'package:find_me_app/features/all_cases/presentation/pages/all_Cases.dart';
import 'package:find_me_app/features/Home/presentation/pages/home.dart';
import 'package:find_me_app/features/profile/presentation/profile_view/pages/profile_view.dart';
import 'package:find_me_app/features/settings/presentation/pages/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:find_me_app/core/resources/strings.dart';
import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';

class BottomNavBarTab {
  Widget? screen;
  String title;
  IconData? icon;
  String? img;
  String? activeImg;
  GlobalKey<NavigatorState>? navigatorKey;

  BottomNavBarTab({
    this.screen,
    required this.title,
    this.icon,
    this.img,
    this.activeImg,
    this.navigatorKey,
  });
}

List<BottomNavBarTab> kUserBottomBarTabs = [
  BottomNavBarTab(
      screen: HomePageNoNavBar(),
      title: AppStrings.dashboard,
      img: 'assets/icons/home_icon.svg'),
  BottomNavBarTab(
      screen: const AllCasesView(),
      title: "cases".ts,
      img: 'assets/icons/place_icon.svg'),
  BottomNavBarTab(
      screen: const ProfileView(),
      title: "profile".ts,
      img: 'assets/icons/person_icon.svg'),
  BottomNavBarTab(
      screen: const SettingsView(),
      title: "settings".ts,
      img: 'assets/icons/settingss.svg'),
];
