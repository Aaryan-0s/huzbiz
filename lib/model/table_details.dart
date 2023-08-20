class TableDetails {
  int? tableID;
  String? tableName;
  String? tableType;
  bool? isAvailableForOrder;
  int? peopleInTable;
  List<Orders>? orders;
  List<Menus>? menus;

  TableDetails({
    this.tableID,
    this.tableName,
    this.tableType,
    this.isAvailableForOrder,
    this.peopleInTable,
    this.orders,
    this.menus,
  });

  TableDetails.fromJson(Map<String, dynamic> json) {
    tableID = json['tableID'];
    tableName = json['tableName'];
    tableType = json['tableType'];
    isAvailableForOrder = json['isAvailableForOrder'];
    peopleInTable = json['peopleInTable'];
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });
    }
    if (json['menus'] != null) {
      menus = <Menus>[];
      json['menus'].forEach((v) {
        menus!.add(Menus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tableID'] = tableID;
    data['tableName'] = tableName;
    data['tableType'] = tableType;
    data['isAvailableForOrder'] = isAvailableForOrder;
    data['peopleInTable'] = peopleInTable;
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    if (menus != null) {
      data['menus'] = menus!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'TableDetails{tableID: $tableID, tableName: $tableName, tableType: $tableType, isAvailableForOrder: $isAvailableForOrder, peopleInTable: $peopleInTable, orders: $orders, menus: $menus}';
  }
}

class Orders {
  int? orderID;
  String? orderName;
  int? orderQuantity;
  double? orderPrice;

  Orders({this.orderID, this.orderName, this.orderQuantity, this.orderPrice});

  Orders.fromJson(Map<String, dynamic> json) {
    orderID = json['orderID'];
    orderName = json['orderName'];
    orderQuantity = json['orderQuantity'];
    orderPrice = json['orderPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderID'] = orderID;
    data['orderName'] = orderName;
    data['orderQuantity'] = orderQuantity;
    data['orderPrice'] = orderPrice;
    return data;
  }

  @override
  String toString() {
    return 'Orders{orderID: $orderID, orderName: $orderName, orderQuantity: $orderQuantity, orderPrice: $orderPrice}';
  }
}

class Menus {
  int? menuID;
  String? menuName;
  List<Categories>? categories;

  Menus({this.menuID, this.menuName, this.categories});

  Menus.fromJson(Map<String, dynamic> json) {
    menuID = json['menuID'];
    menuName = json['menuName'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['menuID'] = menuID;
    data['menuName'] = menuName;
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'Menus{menuID: $menuID, menuName: $menuName, categories: $categories}';
  }
}

class Categories {
  int? categoryID;
  String? categoryName;
  double? price;
  int? quantity;

  Categories({this.categoryID, this.categoryName, this.price, this.quantity});

  Categories.fromJson(Map<String, dynamic> json) {
    categoryID = json['categoryID'];
    categoryName = json['categoryName'];
    price = json['price'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryID'] = categoryID;
    data['categoryName'] = categoryName;
    data['price'] = price;
    data['quantity'] = quantity;
    return data;
  }

  @override
  String toString() {
    return 'Categories{categoryID: $categoryID, categoryName: $categoryName, price: $price, quantity: $quantity}';
  }
}
