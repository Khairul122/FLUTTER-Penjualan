part of 'app_pages.dart';

/// used to switch pages
class Routes {
  static const landing_page = _Paths.landing_page;
  static const login = _Paths.login;
  static const register = _Paths.register;
  static const dashboard = _Paths.dashboard;
  static const product = _Paths.product;
  static const HOME = '/home';
  static const PROFILE = '/profile';
  static const CART = '/cart';
  static const ORDER = '/order';
  static const SPLASH_SCREEN = '/splash-screen';
  static const PEMBAYARAN = '/pembayaran';
  static const RESI = '/resi';
}

/// contains a list of route names.
// made separately to make it easier to manage route naming
class _Paths {
  static const landing_page = '/landing-page';
  static const login = '/login';
  static const register = '/register';
  static const dashboard = '/dashboard';
  static const product = '/product';
  static const HOME = '/home';
  static const PROFILE = '/profile';
  static const CART = '/cart';
  static const ORDER = '/order';
  static const SPLASH_SCREEN = '/splash-screen';
  static const PEMBAYARAN = '/pembayaran';

  // Example :
  // static const index = '/';
  // static const splash = '/splash';
  // static const product = '/product';
  // static const productEdit = '/product/edit';
  // static const productDetail = '/product/detail';
  // static const productAdd = '/product/add';
}
