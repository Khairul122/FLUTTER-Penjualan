library dashboard;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:marketplace/app/features/dashboard/cart/views/cart_view.dart';
import 'package:marketplace/app/features/dashboard/explore/views/screens/explore_screen.dart';
import 'package:marketplace/app/features/dashboard/home/views/home_view.dart';
import 'package:marketplace/app/features/dashboard/order/views/order_view.dart';
import 'package:marketplace/app/features/dashboard/profile/views/profile_view.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

// binding
part '../../bindings/dashboard_binding.dart';

// controller
part '../../controllers/dashboard_controller.dart';

// model

// component

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller.persistentTab,
      screens: _buildScreens(),
      items: _buildNavBarsItems(),
      backgroundColor: Colors.white, // Default is Colors.white.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarHeight: 70,
      navBarStyle: NavBarStyle.style10,
    );
  }

  List<Widget> _buildScreens() {
    return [
      HomeView(),
      ExploreScreen(),
      CartView(),
      OrderView(),
      ProfileView()
    ];
  }

  List<PersistentBottomNavBarItem> _buildNavBarsItems() {
    return [
      _navbarItem(iconData: FontAwesomeIcons.thLarge, title: "Home"),
      _navbarItem(iconData: FontAwesomeIcons.search, title: "Explore"),
      _navbarItem(iconData: FontAwesomeIcons.shoppingBasket, title: "Cart"),
      _navbarItem(iconData: FontAwesomeIcons.list, title: "History"),
      _navbarItem(iconData: FontAwesomeIcons.userAlt, title: "Profil"),
    ];
  }

  PersistentBottomNavBarItem _navbarItem({
    required IconData iconData,
    required String title,
  }) {
    return PersistentBottomNavBarItem(
      icon: Icon(iconData, size: 16.sp),
      title: (title),
      activeColorPrimary: Color.fromRGBO(246, 246, 246, 1),
      inactiveColorPrimary: Color.fromRGBO(187, 193, 202, 1),
      activeColorSecondary: Color(0xFFBA704F),
      textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.sp),
    );
  }
}
