import 'package:find_me_app/features/all_cases/presentation/pages/all_Cases.dart';
import 'package:find_me_app/features/Home/presentation/pages/home.dart';
import 'package:find_me_app/features/profile/presentation/profile_view/pages/profile_view.dart';
import 'package:find_me_app/features/settings/presentation/pages/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:find_me_app/core/resources/strings.dart';

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

// Tabs list with persistent bottom nav bar keys
List<BottomNavBarTab> kUserBottomBarTabs = [
  BottomNavBarTab(
      screen: HomePageNoNavBar(),
      title: AppStrings.dashboard,
      img: 'assets/icons/home_icon.svg'),
  BottomNavBarTab(
      screen: AllCasesView(),
      title: "Casses",
      img: 'assets/icons/place_icon.svg'),
  BottomNavBarTab(
      screen: ProfileView(),
      title: "profile",
      img: 'assets/icons/person_icon.svg'),
  BottomNavBarTab(
      screen: const SettingsView(),
      title: "settings",
      img: 'assets/icons/settingss.svg'),
];
