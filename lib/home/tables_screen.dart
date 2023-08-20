import 'package:huzbiz_app/core/data/provider/injection_container.dart';
import 'package:huzbiz_app/core/data/provider/table_bloc.dart';
import 'package:huzbiz_app/core/routes/app_routes.dart';
import 'package:huzbiz_app/core/styles/app_colors.dart';
import 'package:huzbiz_app/core/styles/drawer.dart';
import 'package:huzbiz_app/model/table_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TablesView extends StatefulWidget {
  const TablesView({super.key});

  @override
  State<TablesView> createState() => _TablesViewState();
}

class _TablesViewState extends State<TablesView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<TableDetails> _table = [];

  final _blocReference = sl<TableBloc>();

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
              "Tables",
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
      body: BlocProvider<TableBloc>(
        create: (context) => _blocReference..add(TableInit()),
        child: BlocListener<TableBloc, TableState>(
          bloc: _blocReference,
          listener: (context, state) {
            if (state is TableError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
            if (state is TableLoading) {
              const CircularProgressIndicator();
            }
            if (state is TableLoaded) {
              const CircularProgressIndicator();
              _table = state.loadedTableModel;
              setState(() {});
            }
          },
          child: BlocBuilder<TableBloc, TableState>(
            builder: (context, state) {
              return ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: screenHeight * 0.02,
                  );
                },
                itemCount: _table.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                primary: true,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "Table type - ",
                            style: TextStyle(
                              color: AppColors.secondaryColor,
                              fontFamily: 'Poppins',
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: _table[index].tableType!.isEmpty
                                    ? "N/A"
                                    : _table[index].tableType,
                                style: TextStyle(
                                  color: AppColors.secondaryColor,
                                  fontFamily: 'UbuntuMedium',
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoute.ordersRoute,
                              arguments: _table[index],
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color:
                                          _table[index].isAvailableForOrder ==
                                                  true
                                              ? Colors.green
                                              : Colors.red,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      child: Text(
                                        _table[index].isAvailableForOrder ==
                                                true
                                            ? "Available for order"
                                            : "Order In Progress",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.015,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: screenWidth * 0.65,
                                        decoration: BoxDecoration(
                                          color: _table[index]
                                                      .isAvailableForOrder ==
                                                  true
                                              ? AppColors.tableContainer
                                              : AppColors.bgColor,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: AppColors.primaryColor,
                                            width: 0.1,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 10,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                _table[index].tableName!,
                                                style: TextStyle(
                                                  color: _table[index]
                                                              .isAvailableForOrder ==
                                                          true
                                                      ? AppColors.primaryColor
                                                      : Colors.red,
                                                  fontFamily: 'Poppins',
                                                  fontSize: 14,
                                                ),
                                              ),
                                              SizedBox(
                                                height: screenHeight * 0.015,
                                              ),
                                              Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .people_alt_rounded,
                                                        size: 16,
                                                        color: _table[index]
                                                                    .isAvailableForOrder ==
                                                                true
                                                            ? AppColors
                                                                .secondaryColor
                                                            : Colors.red,
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        _table[index]
                                                            .peopleInTable!
                                                            .toString(),
                                                        style: TextStyle(
                                                          color: _table[index]
                                                                      .isAvailableForOrder ==
                                                                  true
                                                              ? AppColors
                                                                  .secondaryColor
                                                              : Colors.red,
                                                          fontFamily: 'Poppins',
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: screenWidth * 0.05,
                                                  ),
                                                  Row(
                                                    children: [
                                                      _table[index]
                                                                  .isAvailableForOrder ==
                                                              true
                                                          ? Icon(
                                                              Icons
                                                                  .pending_actions,
                                                              size: 16,
                                                              color: AppColors
                                                                  .secondaryColor,
                                                            )
                                                          : const Icon(
                                                              Icons.timelapse,
                                                              size: 16,
                                                              color: Colors.red,
                                                            ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        _table[index]
                                                                    .isAvailableForOrder ==
                                                                true
                                                            ? "Yet To Take Order"
                                                            : "1 mins ago",
                                                        style: TextStyle(
                                                          color: _table[index]
                                                                      .isAvailableForOrder ==
                                                                  true
                                                              ? AppColors
                                                                  .secondaryColor
                                                              : Colors.red,
                                                          fontFamily: 'Poppins',
                                                          fontSize: 11,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: screenHeight * 0.075,
                                        width: screenWidth * 0.15,
                                        decoration: BoxDecoration(
                                          color: _table[index]
                                                      .isAvailableForOrder ==
                                                  true
                                              ? AppColors.tableContainer
                                              : AppColors.bgColor,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                            color: AppColors.primaryColor,
                                            width: 0.10,
                                          ),
                                        ),
                                        child: Image(
                                          image: _table[index]
                                                      .isAvailableForOrder ==
                                                  true
                                              ? const AssetImage(
                                                  "assets/icons/green_table.png",
                                                )
                                              : const AssetImage(
                                                  "assets/icons/red_table.png",
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
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
