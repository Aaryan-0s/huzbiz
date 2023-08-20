import 'package:huzbiz_app/home/dashboard.dart';
import 'package:huzbiz_app/home/menu_screen.dart';
import 'package:huzbiz_app/home/order_screen.dart';
import 'package:huzbiz_app/home/splash_screen.dart';
import 'package:huzbiz_app/home/tables_screen.dart';

class AppRoute {
  AppRoute._();

  static const String splashRoute = '/';
  static const String dashboardRoute = '/dashboard';
  static const String tablesRoute = '/tables';
  static const String ordersRoute = '/orders';
  static const String menuRoute = '/menu';

  static getAppRoutes() => {
        splashRoute: (context) => const SplashScreenView(),
        dashboardRoute: (context) => const huzbizDashboard(),
        tablesRoute: (context) => const TablesView(),
        ordersRoute: (context) => const OrderView(),
        menuRoute: (context) => const MenuView(),
      };
}
