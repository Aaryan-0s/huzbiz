import 'package:huzbiz_app/core/data/provider/injection_container.dart';
import 'package:huzbiz_app/core/data/provider/table_bloc.dart';
import 'package:huzbiz_app/core/routes/app_routes.dart';
import 'package:huzbiz_app/core/styles/app_colors.dart';
import 'package:huzbiz_app/model/table_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  final _blocReference = sl<TableBloc>();

  List<TableDetails> _table = [];

  TableDetails tableDetails = TableDetails();
  int? tableID;

  bool isMenuClicked = false;
  int menuIndexClicked = 0;
  int selectedMenuIndex = -1;

  String searchtext = '';

  @override
  void didChangeDependencies() {
    Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      tableDetails = args['tableDetails'];
      tableID = args['tableID'];
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    //FILTER SEARCH
    // List<TableDetails> filteredTable = _table
    //     .where((element) => element.menus!.any((element) =>
    //         element.menuName!.toLowerCase().contains(searchtext.toLowerCase())))
    //     .toList();

    // List<Menus> filteredMenu = tableDetails.menus!
    //     .where((element) =>
    //         element.menuName!.toLowerCase().contains(searchtext.toLowerCase()))
    //     .toList();

    List<Categories> filteredCategory = tableDetails.menus![0].categories!
        .where((element) => element.categoryName!
            .toLowerCase()
            .contains(searchtext.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.09,
        backgroundColor: AppColors.bgColor,
        iconTheme: IconThemeData(
          color: AppColors.secondaryColor,
          size: 24,
        ),
        title: Text(
          "Menu",
          style: TextStyle(
            color: AppColors.secondaryColor,
            fontFamily: 'PoppinsSemi',
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
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
                  padding: EdgeInsets.only(bottom: screenHeight * 0.05),
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.symmetric(
                                  horizontal: BorderSide(
                                    color: AppColors.secondaryColor,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.05,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.search,
                                      color: AppColors.containerColor,
                                      size: 26,
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.04,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        onChanged: (value) {
                                          setState(() {
                                            searchtext = value;
                                            // print(filteredTable.length);
                                            if (searchtext == '') {
                                              isMenuClicked == false;
                                            } else {
                                              isMenuClicked = true;
                                            }

                                            print(filteredCategory.length);
                                            // print(menuIndexClicked);
                                          });
                                        },
                                        // controller: searchController,
                                        style: TextStyle(
                                          color: AppColors.containerColor,
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Search Menu Category..',
                                          hintStyle: TextStyle(
                                            color: AppColors.containerColor,
                                            fontFamily: 'UbuntuMedium',
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: screenWidth * 0.45,
                                  decoration: BoxDecoration(
                                    color: AppColors.menuContainer,
                                    border: BorderDirectional(
                                      end: BorderSide(
                                        color: AppColors.secondaryColor,
                                        width: 0.5,
                                      ),
                                      bottom: BorderSide(
                                        color: AppColors.secondaryColor,
                                        width: 0.5,
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.05,
                                      vertical: screenHeight * 0.015,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Menu Category',
                                          style: TextStyle(
                                            color: AppColors.containerColor,
                                            fontFamily: 'UbuntuMedium',
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: screenWidth * 0.55,
                                  decoration: BoxDecoration(
                                    color: AppColors.menuContainer,
                                    border: BorderDirectional(
                                      bottom: BorderSide(
                                        color: AppColors.secondaryColor,
                                        width: 0.5,
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.05,
                                      vertical: screenHeight * 0.015,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Choose Items',
                                          style: TextStyle(
                                            color: AppColors.containerColor,
                                            fontFamily: 'UbuntuMedium',
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: screenHeight * 0.58,
                                  width: screenWidth * 0.45,
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) {
                                      return SizedBox(
                                        height: screenHeight * 0.005,
                                      );
                                    },
                                    primary: false,
                                    itemCount: tableDetails.menus!.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isMenuClicked = true;
                                            menuIndexClicked = index;
                                            selectedMenuIndex =
                                                selectedMenuIndex == index
                                                    ? -1
                                                    : index;
                                          });
                                          // if (isMenuClicked == false) {
                                          //   setState(
                                          //     () {
                                          //       isMenuClicked = true;
                                          //       menuIndexClicked = index;
                                          //       selectedMenuIndex =
                                          //           selectedMenuIndex == index
                                          //               ? -1
                                          //               : index;
                                          //     },
                                          //   );
                                          // } else {
                                          //   setState(() {
                                          //     isMenuClicked = false;
                                          //     selectedMenuIndex =
                                          //         selectedMenuIndex == index
                                          //             ? -1
                                          //             : index;
                                          //   });
                                          // }
                                        },
                                        child: Container(
                                          width: screenWidth * 0.45,
                                          margin: EdgeInsets.only(
                                            left: screenWidth * 0.015,
                                          ),
                                          decoration: BoxDecoration(
                                            color: selectedMenuIndex == index
                                                ? AppColors.containerColor
                                                : Colors.white,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(5),
                                            ),
                                            border: Border.all(
                                              color: selectedMenuIndex == index
                                                  ? AppColors.menuContainer
                                                  : AppColors.secondaryColor,
                                              width: 0.25,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: screenWidth * 0.03,
                                              vertical: screenHeight * 0.015,
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.restaurant_rounded,
                                                  color:
                                                      selectedMenuIndex == index
                                                          ? AppColors.bgColor
                                                          : AppColors
                                                              .secondaryColor,
                                                  size: 18,
                                                ),
                                                SizedBox(
                                                  width: screenWidth * 0.04,
                                                ),
                                                Text(
                                                  tableDetails
                                                      .menus![index].menuName!,
                                                  style: TextStyle(
                                                    color: selectedMenuIndex ==
                                                            index
                                                        ? AppColors.bgColor
                                                        : AppColors
                                                            .secondaryColor,
                                                    fontFamily: 'PoppinsSemi',
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                isMenuClicked == true
                                    ? searchtext == ''
                                        ? SizedBox(
                                            width: screenWidth * 0.55,
                                            height: screenHeight * 0.58,
                                            child: ListView.separated(
                                              separatorBuilder:
                                                  (context, index) {
                                                return SizedBox(
                                                  height: screenHeight * 0.005,
                                                );
                                              },
                                              primary: false,
                                              itemCount: _table[tableID!]
                                                  .menus![menuIndexClicked]
                                                  .categories!
                                                  .length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  margin: EdgeInsets.only(
                                                    left: screenWidth * 0.015,
                                                    right: screenWidth * 0.015,
                                                  ),
                                                  width: screenWidth * 0.55,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(5),
                                                    ),
                                                    border: Border.all(
                                                      color: AppColors
                                                          .secondaryColor,
                                                      width: 0.25,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal:
                                                          screenWidth * 0.03,
                                                      vertical:
                                                          screenHeight * 0.015,
                                                    ),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            top: 4.0,
                                                          ),
                                                          child: Icon(
                                                            Icons
                                                                .restaurant_menu_rounded,
                                                            color: AppColors
                                                                .secondaryColor,
                                                            size: 20,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: screenWidth *
                                                              0.04,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  screenWidth *
                                                                      0.25,
                                                              child: Text(
                                                                tableDetails
                                                                    .menus![
                                                                        menuIndexClicked]
                                                                    .categories![
                                                                        index]
                                                                    .categoryName!,
                                                                style:
                                                                    TextStyle(
                                                                  color: AppColors
                                                                      .containerColor2,
                                                                  fontFamily:
                                                                      'UbuntuMedium',
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  screenHeight *
                                                                      0.01,
                                                            ),
                                                            Text(
                                                              'NPR ${tableDetails.menus![menuIndexClicked].categories![index].price}',
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .containerColor,
                                                                fontFamily:
                                                                    'UbuntuMedium',
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  screenHeight *
                                                                      0.01,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    setState(
                                                                      () {
                                                                        tableDetails.menus![menuIndexClicked].categories![index].quantity! >
                                                                                0
                                                                            ? tableDetails.menus![menuIndexClicked].categories![index].quantity =
                                                                                tableDetails.menus![menuIndexClicked].categories![index].quantity! - 1
                                                                            : 0;

                                                                        _blocReference
                                                                            .add(TableInit());
                                                                      },
                                                                    );
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              100),
                                                                      color: Colors
                                                                          .white,
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: AppColors
                                                                            .primaryColor,
                                                                        width:
                                                                            0.2,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        const Padding(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .all(
                                                                        2.0,
                                                                      ),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .remove,
                                                                        color: Colors
                                                                            .red,
                                                                        size:
                                                                            16,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      screenWidth *
                                                                          0.02,
                                                                ),
                                                                Text(
                                                                  tableDetails
                                                                      .menus![
                                                                          menuIndexClicked]
                                                                      .categories![
                                                                          index]
                                                                      .quantity!
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    color: AppColors
                                                                        .primaryColor,
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                  maxLines: 2,
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      screenWidth *
                                                                          0.02,
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    setState(
                                                                      () {
                                                                        tableDetails
                                                                            .menus![
                                                                                menuIndexClicked]
                                                                            .categories![
                                                                                index]
                                                                            .quantity = tableDetails
                                                                                .menus![menuIndexClicked].categories![index].quantity! +
                                                                            1;

                                                                        _blocReference
                                                                            .add(TableInit());
                                                                      },
                                                                    );
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              100),
                                                                      color: Colors
                                                                          .white,
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: AppColors
                                                                            .primaryColor,
                                                                        width:
                                                                            0.25,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        const Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              2.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .add,
                                                                        color: Colors
                                                                            .green,
                                                                        size:
                                                                            16,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        const Spacer(),
                                                        GestureDetector(
                                                          onTap: () {
                                                            _blocReference.add(
                                                                TableInit());
                                                            // Navigator.popAndPushNamed(
                                                            //     context,
                                                            //     AppRoute.ordersRoute,
                                                            //     arguments: tableDetails);

                                                            setState(() {
                                                              Orders newOrders =
                                                                  Orders(
                                                                orderID: tableDetails
                                                                    .menus![
                                                                        menuIndexClicked]
                                                                    .categories![
                                                                        index]
                                                                    .categoryID,
                                                                orderName: tableDetails
                                                                    .menus![
                                                                        menuIndexClicked]
                                                                    .categories![
                                                                        index]
                                                                    .categoryName,
                                                                orderPrice: tableDetails
                                                                    .menus![
                                                                        menuIndexClicked]
                                                                    .categories![
                                                                        index]
                                                                    .price,
                                                                orderQuantity: tableDetails
                                                                    .menus![
                                                                        menuIndexClicked]
                                                                    .categories![
                                                                        index]
                                                                    .quantity,
                                                              );
                                                              if (tableDetails
                                                                      .menus![
                                                                          menuIndexClicked]
                                                                      .categories![
                                                                          index]
                                                                      .quantity! >
                                                                  0) {
                                                                tableDetails
                                                                    .orders!
                                                                    .add(
                                                                        newOrders);
                                                              }
                                                            });

                                                            tableDetails
                                                                .menus![
                                                                    menuIndexClicked]
                                                                .categories![
                                                                    index]
                                                                .quantity = 0;
                                                          },
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              color: AppColors
                                                                  .bgColor,
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Icon(
                                                                Icons.done,
                                                                color: AppColors
                                                                    .secondaryColor,
                                                                size: 16,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        : SizedBox(
                                            width: screenWidth * 0.55,
                                            height: screenHeight * 0.58,
                                            child: ListView.separated(
                                              separatorBuilder:
                                                  (context, index) {
                                                return SizedBox(
                                                  height: screenHeight * 0.005,
                                                );
                                              },
                                              primary: false,
                                              itemCount:
                                                  filteredCategory.length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  margin: EdgeInsets.only(
                                                    left: screenWidth * 0.015,
                                                    right: screenWidth * 0.015,
                                                  ),
                                                  width: screenWidth * 0.55,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(5),
                                                    ),
                                                    border: Border.all(
                                                      color: AppColors
                                                          .secondaryColor,
                                                      width: 0.25,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal:
                                                          screenWidth * 0.03,
                                                      vertical:
                                                          screenHeight * 0.015,
                                                    ),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            top: 4.0,
                                                          ),
                                                          child: Icon(
                                                            Icons
                                                                .restaurant_menu_rounded,
                                                            color: AppColors
                                                                .secondaryColor,
                                                            size: 20,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: screenWidth *
                                                              0.04,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  screenWidth *
                                                                      0.25,
                                                              child: Text(
                                                                filteredCategory[
                                                                        index]
                                                                    .categoryName!,
                                                                style:
                                                                    TextStyle(
                                                                  color: AppColors
                                                                      .containerColor2,
                                                                  fontFamily:
                                                                      'UbuntuMedium',
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  screenHeight *
                                                                      0.01,
                                                            ),
                                                            Text(
                                                              'NPR ${filteredCategory[index].price}',
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .containerColor,
                                                                fontFamily:
                                                                    'UbuntuMedium',
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  screenHeight *
                                                                      0.01,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    setState(
                                                                      () {
                                                                        filteredCategory[index].quantity! >
                                                                                0
                                                                            ? filteredCategory[index].quantity =
                                                                                filteredCategory[index].quantity! - 1
                                                                            : 0;

                                                                        _blocReference
                                                                            .add(TableInit());
                                                                      },
                                                                    );
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              100),
                                                                      color: Colors
                                                                          .white,
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: AppColors
                                                                            .primaryColor,
                                                                        width:
                                                                            0.2,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        const Padding(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .all(
                                                                        2.0,
                                                                      ),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .remove,
                                                                        color: Colors
                                                                            .red,
                                                                        size:
                                                                            16,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      screenWidth *
                                                                          0.02,
                                                                ),
                                                                Text(
                                                                  filteredCategory[
                                                                          index]
                                                                      .quantity!
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    color: AppColors
                                                                        .primaryColor,
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                                  maxLines: 2,
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      screenWidth *
                                                                          0.02,
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    setState(
                                                                      () {
                                                                        filteredCategory[index]
                                                                            .quantity = filteredCategory[index]
                                                                                .quantity! +
                                                                            1;

                                                                        _blocReference
                                                                            .add(TableInit());
                                                                      },
                                                                    );
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              100),
                                                                      color: Colors
                                                                          .white,
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: AppColors
                                                                            .primaryColor,
                                                                        width:
                                                                            0.25,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        const Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              2.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .add,
                                                                        color: Colors
                                                                            .green,
                                                                        size:
                                                                            16,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        const Spacer(),
                                                        GestureDetector(
                                                          onTap: () {
                                                            _blocReference.add(
                                                                TableInit());
                                                            // Navigator.popAndPushNamed(
                                                            //     context,
                                                            //     AppRoute.ordersRoute,
                                                            //     arguments: tableDetails);

                                                            setState(() {
                                                              Orders newOrders =
                                                                  Orders(
                                                                orderID: filteredCategory[
                                                                        index]
                                                                    .categoryID,
                                                                orderName:
                                                                    filteredCategory[
                                                                            index]
                                                                        .categoryName,
                                                                orderPrice:
                                                                    filteredCategory[
                                                                            index]
                                                                        .price,
                                                                orderQuantity:
                                                                    filteredCategory[
                                                                            index]
                                                                        .quantity,
                                                              );
                                                              if (filteredCategory[
                                                                          index]
                                                                      .quantity! >
                                                                  0) {
                                                                tableDetails
                                                                    .orders!
                                                                    .add(
                                                                        newOrders);
                                                              }
                                                            });

                                                            filteredCategory[
                                                                    index]
                                                                .quantity = 0;
                                                            tableDetails
                                                                .menus![
                                                                    menuIndexClicked]
                                                                .categories![
                                                                    index]
                                                                .quantity = 0;
                                                          },
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              color: AppColors
                                                                  .bgColor,
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Icon(
                                                                Icons.done,
                                                                color: AppColors
                                                                    .secondaryColor,
                                                                size: 16,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                    : Container(),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: screenWidth * 0.1,
                            right: screenWidth * 0.1,
                            top: screenHeight * 0.1,
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                _blocReference.add(TableInit());
                                Navigator.popAndPushNamed(
                                    context, AppRoute.ordersRoute,
                                    arguments: tableDetails);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.05,
                                  vertical: screenHeight * 0.015,
                                ),
                              ),
                              child: Text(
                                'Done',
                                style: TextStyle(
                                  color: AppColors.bgColor,
                                  fontFamily: 'PoppinsSemi',
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )),
    );
  }
}
