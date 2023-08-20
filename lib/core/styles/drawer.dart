import 'package:huzbiz_app/core/routes/app_routes.dart';
import 'package:huzbiz_app/core/styles/app_colors.dart';
import 'package:flutter/material.dart';

class DrawerView extends StatefulWidget {
  const DrawerView({super.key});

  @override
  State<DrawerView> createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.secondaryColor,
      child: Padding(
        padding: const EdgeInsets.only(
            top: 0.0, bottom: 0.0, right: 0.0, left: 16.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'huzbiz Software',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'UbuntuMedium',
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            tiles(
              'Dashboard',
              Icons.dashboard_rounded,
              () {
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoute.dashboardRoute, (route) => false);
              },
            ),
            tiles(
              'Tables',
              Icons.table_bar,
              () {
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoute.tablesRoute, (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget tiles(String tileName, IconData icon, void Function() onTap) {
    return ListTile(
      iconColor: Colors.white,
      textColor: Colors.white,
      leading: Icon(
        icon,
        size: 22,
      ),
      title: Text(
        tileName,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontFamily: 'Poppins',
        ),
      ),
      onTap: onTap,
    );
  }
}
