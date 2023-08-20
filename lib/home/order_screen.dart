import 'package:huzbiz_app/core/data/provider/injection_container.dart';
import 'package:huzbiz_app/core/data/provider/table_bloc.dart';
import 'package:huzbiz_app/core/routes/app_routes.dart';
import 'package:huzbiz_app/core/styles/app_colors.dart';
import 'package:huzbiz_app/core/styles/drawer.dart';
import 'package:huzbiz_app/core/theme/my_snackbar.dart';
import 'package:huzbiz_app/model/table_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<TableDetails> _table = [];

  final _blocReference = sl<TableBloc>();

  TableDetails tableDetails = TableDetails();

  @override
  void didChangeDependencies() {
    tableDetails = ModalRoute.of(context)!.settings.arguments as TableDetails;
    super.didChangeDependencies();
  }

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
              "Orders",
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
              return Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.01,
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05,
                ),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 0.25,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.04,
                          vertical: screenHeight * 0.015,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "You're in table",
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontFamily: 'Ubuntu',
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              tableDetails.tableName!,
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontFamily: 'PoppinsSemi',
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 0.25,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.04,
                          vertical: screenHeight * 0.015,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Add Items To The Order",
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontFamily: 'Ubuntu',
                                fontSize: 15,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoute.menuRoute,
                                  arguments: {
                                    "tableDetails": tableDetails,
                                    "tableID": tableDetails.tableID,
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.bgColor,
                                  border: Border.all(
                                    color: AppColors.secondaryColor,
                                    width: 0.25,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.02,
                                    vertical: screenHeight * 0.005,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.menu_book_rounded,
                                        color: AppColors.secondaryColor,
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.01,
                                      ),
                                      Text(
                                        'Menu',
                                        style: TextStyle(
                                          color: AppColors.secondaryColor,
                                          fontFamily: 'PoppinsSemi',
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: screenWidth * 0.01),
                          child: Text(
                            'The Orders',
                            style: TextStyle(
                              color: AppColors.secondaryColor,
                              fontFamily: 'Poppins',
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: screenHeight * 0.04,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                      color: AppColors.secondaryColor,
                                      width: 0.25,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    tableDetails.orders!.clear();
                                  });
                                },
                                child: const Text(
                                  'Clear Orders',
                                  style: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenWidth * 0.02,
                            ),
                            SizedBox(
                              height: screenHeight * 0.04,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                      color: AppColors.secondaryColor,
                                      width: 0.25,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return StatefulBuilder(
                                        builder: (context, setState) {
                                          return Container(
                                            height: screenHeight * 0.4,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              color: AppColors.bgColor,
                                              border: Border.all(
                                                color: AppColors.primaryColor,
                                                width: 0.25,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: screenWidth * 0.06,
                                                vertical: screenHeight * 0.02,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'Details',
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .primaryColor,
                                                              fontFamily:
                                                                  'PoppinsSemi',
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                Navigator.pop(
                                                                    context);
                                                              });
                                                            },
                                                            child: Icon(
                                                              Icons.close,
                                                              color: AppColors
                                                                  .primaryColor,
                                                              size: 22,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            screenHeight * 0.01,
                                                      ),
                                                      Divider(
                                                        color: AppColors
                                                            .containerColor2,
                                                        thickness: 0.25,
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            screenHeight * 0.01,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            tableDetails.orders!
                                                                        .length >
                                                                    1
                                                                ? 'Total items'
                                                                : 'Total item',
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .containerColor,
                                                              fontFamily:
                                                                  'Ubuntu',
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          Text(
                                                            tableDetails
                                                                .orders!.length
                                                                .toString(),
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .containerColor2,
                                                              fontFamily:
                                                                  'UbuntuBold',
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            screenHeight * 0.01,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'Subtotal',
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .containerColor,
                                                              fontFamily:
                                                                  'Ubuntu',
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          Text(
                                                            'NRS ${tableDetails.orders!.fold(0.0, (previousValue, element) => previousValue + (element.orderPrice! * element.orderQuantity!))}',
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .containerColor2,
                                                              fontFamily:
                                                                  'UbuntuBold',
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            screenHeight * 0.01,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'Tax',
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .containerColor,
                                                              fontFamily:
                                                                  'Ubuntu',
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          Text(
                                                            'NRS 100.0',
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .containerColor2,
                                                              fontFamily:
                                                                  'UbuntuBold',
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            screenHeight * 0.01,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'Grand Total',
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .secondaryColor,
                                                              fontFamily:
                                                                  'Ubuntu',
                                                              fontSize: 17,
                                                            ),
                                                          ),
                                                          Text(
                                                            'NRS ${tableDetails.orders!.fold(0.0, (previousValue, element) => previousValue + (element.orderPrice! * element.orderQuantity!)) + 100}',
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .secondaryColor,
                                                              fontFamily:
                                                                  'UbuntuBold',
                                                              fontSize: 17,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: screenHeight * 0.06,
                                                    width: screenWidth,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          showSnackBar(
                                                            message:
                                                                'Your Order Is Placed',
                                                            context: context,
                                                            color: AppColors
                                                                .secondaryColor,
                                                          );
                                                          tableDetails.orders!
                                                              .clear();

                                                          _blocReference
                                                              .add(TableInit());
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            AppColors
                                                                .secondaryColor,
                                                        elevation: 0,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      child: const Text(
                                                        'Place Order',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: 'Poppins',
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                                child: const Text(
                                  'Details',
                                  style: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    tableDetails.orders!.isNotEmpty
                        ?
                        // Order List
                        SizedBox(
                            height: screenHeight * 0.8,
                            child: ListView.separated(
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: screenHeight * 0.01,
                                );
                              },
                              primary: false,
                              // shrinkWrap: true,
                              // physics: const NeverScrollableScrollPhysics(),
                              itemCount: tableDetails.orders!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 6.0),
                                  child: Dismissible(
                                    onDismissed: (direction) {
                                      setState(() {
                                        tableDetails.orders!.removeAt(index);
                                      });
                                    },
                                    direction: DismissDirection.endToStart,
                                    background: Container(
                                      color: Colors.redAccent,
                                    ),
                                    key: UniqueKey(),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        border: Border.all(
                                          color: AppColors.primaryColor,
                                          width: 0.25,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: screenWidth * 0.04,
                                          vertical: screenHeight * 0.015,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: screenWidth * 0.35,
                                                  child: Text(
                                                    tableDetails.orders![index]
                                                        .orderName!,
                                                    style: TextStyle(
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontFamily: 'Ubuntu',
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: screenHeight * 0.01,
                                                ),
                                                Text(
                                                  'NRS ${tableDetails.orders![index].orderPrice! * tableDetails.orders![index].orderQuantity!}',
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.primaryColor,
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    color: Colors.white,
                                                    border: Border.all(
                                                      color: AppColors
                                                          .primaryColor,
                                                      width: 0.25,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(
                                                          () {
                                                            tableDetails
                                                                        .orders![
                                                                            index]
                                                                        .orderQuantity! >
                                                                    0
                                                                ? tableDetails
                                                                    .orders![
                                                                        index]
                                                                    .orderQuantity = tableDetails
                                                                        .orders![
                                                                            index]
                                                                        .orderQuantity! -
                                                                    1
                                                                : 0;
                                                          },
                                                        );
                                                      },
                                                      child: const Icon(
                                                        Icons.remove,
                                                        color: Colors.red,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: screenWidth * 0.04,
                                                ),
                                                Text(
                                                  tableDetails.orders![index]
                                                      .orderQuantity!
                                                      .toString(),
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.primaryColor,
                                                    fontFamily: 'Poppins',
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: screenWidth * 0.04,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    color: Colors.white,
                                                    border: Border.all(
                                                      color: AppColors
                                                          .primaryColor,
                                                      width: 0.25,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(
                                                          () {
                                                            tableDetails
                                                                .orders![index]
                                                                .orderQuantity = tableDetails
                                                                    .orders![
                                                                        index]
                                                                    .orderQuantity! +
                                                                1;
                                                          },
                                                        );
                                                      },
                                                      child: const Icon(
                                                        Icons.add,
                                                        color: Colors.green,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  tableDetails.orders!
                                                      .removeAt(index);
                                                });
                                              },
                                              child: Icon(
                                                Icons.delete_outline_rounded,
                                                color: AppColors.secondaryColor,
                                                size: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: 0.25,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  'No Orders',
                                  style: TextStyle(
                                    color: AppColors.secondaryColor,
                                    fontFamily: 'Nova',
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
