import 'package:huzbiz_app/core/styles/app_colors.dart';
import 'package:huzbiz_app/core/styles/drawer.dart';
import 'package:flutter/material.dart';

class huzbizDashboard extends StatefulWidget {
  const huzbizDashboard({super.key});

  @override
  State<huzbizDashboard> createState() => _huzbizDashboardState();
}

class _huzbizDashboardState extends State<huzbizDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.bgColor,
      drawer: const DrawerView(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: screenHeight * 0.09,
        backgroundColor: AppColors.bgColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              child: Image.asset(
                "assets/icons/menu26.png",
              ),
            ),
            Text(
              "huzbiz Software",
              style: TextStyle(
                color: AppColors.secondaryColor,
                fontFamily: 'PoppinsSemi',
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const CircleAvatar(
              radius: 15,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(
                "assets/icons/user.png",
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenHeight * 0.024),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: "Welcome , ",
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontFamily: 'Poppins',
                  fontSize: 20,
                ),
                children: [
                  TextSpan(
                    text: "John Doe!",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontFamily: 'Nova',
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Text(
              "Here's the orders for you today.",
              style: TextStyle(
                color: AppColors.secondaryColor,
                fontFamily: 'Poppins',
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            SizedBox(
              height: screenHeight * 0.4,
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                primary: true,
                shrinkWrap: true,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/tables');
                    },
                    child: Container(
                      height: screenHeight * 0.16,
                      decoration: BoxDecoration(
                        color: AppColors.containerColor2,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.secondaryColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 5,
                                ),
                                child: Text(
                                  'Table Orders',
                                  style: TextStyle(
                                    color: AppColors.dashBoardtext,
                                    fontFamily: 'Ubuntu',
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.015,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.local_restaurant_rounded,
                                  color: AppColors.dashBoardtext,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: screenWidth * 0.02,
                                ),
                                Text(
                                  'Kathmandu Foods',
                                  style: TextStyle(
                                    color: AppColors.dashBoardtext,
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: screenHeight * 0.015,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.group_rounded,
                                      color: AppColors.tableContainer,
                                      size: 14,
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.01,
                                    ),
                                    Text(
                                      '16 Checked In',
                                      style: TextStyle(
                                        color: AppColors.dashBoardtext,
                                        fontFamily: 'Ubuntu',
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 4,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.check_rounded,
                                          color: AppColors.dashBoardtext,
                                          size: 12,
                                        ),
                                        SizedBox(
                                          width: screenWidth * 0.01,
                                        ),
                                        Text(
                                          'Place Order',
                                          style: TextStyle(
                                            color: AppColors.dashBoardtext,
                                            fontFamily: 'Ubuntu',
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/tables');
                    },
                    child: Container(
                      height: screenHeight * 0.16,
                      decoration: BoxDecoration(
                        color: AppColors.containerColor2,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.secondaryColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 5,
                                ),
                                child: Text(
                                  'Table Orders',
                                  style: TextStyle(
                                    color: AppColors.dashBoardtext,
                                    fontFamily: 'Ubuntu',
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.015,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.restaurant_rounded,
                                  color: AppColors.dashBoardtext,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: screenWidth * 0.02,
                                ),
                                Text(
                                  'Olive Garden',
                                  style: TextStyle(
                                    color: AppColors.dashBoardtext,
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: screenHeight * 0.015,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.group_rounded,
                                      color: AppColors.tableContainer,
                                      size: 14,
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.01,
                                    ),
                                    Text(
                                      '5 Checked In',
                                      style: TextStyle(
                                        color: AppColors.dashBoardtext,
                                        fontFamily: 'Ubuntu',
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 4,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.check_rounded,
                                          color: AppColors.dashBoardtext,
                                          size: 12,
                                        ),
                                        SizedBox(
                                          width: screenWidth * 0.01,
                                        ),
                                        Text(
                                          'Place Order',
                                          style: TextStyle(
                                            color: AppColors.dashBoardtext,
                                            fontFamily: 'Ubuntu',
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
