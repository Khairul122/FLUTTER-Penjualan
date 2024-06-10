import 'package:get/get.dart';
import 'package:marketplace/app/features/authentication/index/bindings/login_binding.dart';
import 'package:marketplace/app/features/dashboard/cart/bindings/cart_binding.dart';
import 'package:marketplace/app/features/dashboard/cart/pembayaran/bindings/pembayaran_binding.dart';

import '../../features/authentication/index/views/screens/login_screen.dart';
import '../../features/authentication/register/bindings/register_binding.dart';
import '../../features/authentication/register/views/register_view.dart';
import '../../features/dashboard/cart/pembayaran/views/pembayaran_view.dart';
import '../../features/dashboard/cart/views/cart_view.dart';
import '../../features/dashboard/explore/views/screens/explore_screen.dart';
import '../../features/dashboard/home/views/home_view.dart';
import '../../features/dashboard/index/views/screens/dashboard_screen.dart';
import '../../features/dashboard/order/views/order_view.dart';
import '../../features/dashboard/profile/views/profile_view.dart';
import '../../features/landing/views/landing_view.dart';
import '../../features/product/product_detail/views/screens/product_detail_screen.dart';
import '../../features/splash_screen/views/splash_screen_view.dart';
import '../../features/dashboard/cart/pembayaran/resi/bindings/resi_binding.dart';
import '../../features/dashboard/cart/pembayaran/resi/views/resi_view.dart';

// import '../../features/dashboard/home/bindings/home_binding.dart';

part 'app_routes.dart';

/// contains all configuration pages
class AppPages {
  /// when the app is opened this page will be the first to be shown
  static const initial = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => SplashScreenView(),
      binding: SplashScreenBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: _Paths.landing_page,
      page: () => LandingScreen(),
      binding: LandingBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.login,
      page: () => LoginScreen(),
      binding: LoginBinding(),
      // transition: Transition.downToUp,
    ),
    GetPage(
      name: _Paths.register,
      page: () => RegisterScreen(),
      binding: RegisterBinding(),
      // transition: Transition.downToUp,
    ),
    GetPage(
      name: _Paths.dashboard,
      page: () => DashboardScreen(),
      bindings: [
        DashboardBinding(),
        ExploreBinding(),
        HomeBinding(),
        ProfileBinding(),
        CartBinding(),
        OrderBinding(),
      ],
    ),
    GetPage(
      name: _Paths.product + "/:id",
      page: () => ProductDetailScreen(),
      binding: ProductDetailBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: Routes.PEMBAYARAN,
      page: () => const PembayaranView(),
      binding: PembayaranBinding(),
    ),
    GetPage(
      name: Routes.RESI,
      page: () => const ResiView(),
      binding: ResiBinding(),
    ),
  ];
}
