// To parse this JSON data, do
//
//     final dashBoard = dashBoardFromJson(jsonString);

import 'dart:convert';

List<DashBoard> dashBoardFromJson(String str) => List<DashBoard>.from(json.decode(str).map((x) => DashBoard.fromJson(x)));

String dashBoardToJson(List<DashBoard> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DashBoard {
    Users? users;
    Revenue? revenue;
    Orders? orders;
    Dishes? dishes;
    Tables? tables;
    Reservations? reservations;
    RecentActivity? recentActivity;

    DashBoard({
        this.users,
        this.revenue,
        this.orders,
        this.dishes,
        this.tables,
        this.reservations,
        this.recentActivity,
    });

    DashBoard copyWith({
        Users? users,
        Revenue? revenue,
        Orders? orders,
        Dishes? dishes,
        Tables? tables,
        Reservations? reservations,
        RecentActivity? recentActivity,
    }) =>
        DashBoard(
            users: users ?? this.users,
            revenue: revenue ?? this.revenue,
            orders: orders ?? this.orders,
            dishes: dishes ?? this.dishes,
            tables: tables ?? this.tables,
            reservations: reservations ?? this.reservations,
            recentActivity: recentActivity ?? this.recentActivity,
        );

    factory DashBoard.fromJson(Map<String, dynamic> json) => DashBoard(
        users: json["users"] == null ? null : Users.fromJson(json["users"]),
        revenue: json["revenue"] == null ? null : Revenue.fromJson(json["revenue"]),
        orders: json["orders"] == null ? null : Orders.fromJson(json["orders"]),
        dishes: json["dishes"] == null ? null : Dishes.fromJson(json["dishes"]),
        tables: json["tables"] == null ? null : Tables.fromJson(json["tables"]),
        reservations: json["reservations"] == null ? null : Reservations.fromJson(json["reservations"]),
        recentActivity: json["recentActivity"] == null ? null : RecentActivity.fromJson(json["recentActivity"]),
    );

    Map<String, dynamic> toJson() => {
        "users": users?.toJson(),
        "revenue": revenue?.toJson(),
        "orders": orders?.toJson(),
        "dishes": dishes?.toJson(),
        "tables": tables?.toJson(),
        "reservations": reservations?.toJson(),
        "recentActivity": recentActivity?.toJson(),
    };
}

class Dishes {
    int? totalDishes;
    CategoryCounts? categoryCounts;
    double? averageRating;
    List<PopularDish>? popularDishes;
    List<RevenueByCategory>? revenueByCategory;

    Dishes({
        this.totalDishes,
        this.categoryCounts,
        this.averageRating,
        this.popularDishes,
        this.revenueByCategory,
    });

    Dishes copyWith({
        int? totalDishes,
        CategoryCounts? categoryCounts,
        double? averageRating,
        List<PopularDish>? popularDishes,
        List<RevenueByCategory>? revenueByCategory,
    }) =>
        Dishes(
            totalDishes: totalDishes ?? this.totalDishes,
            categoryCounts: categoryCounts ?? this.categoryCounts,
            averageRating: averageRating ?? this.averageRating,
            popularDishes: popularDishes ?? this.popularDishes,
            revenueByCategory: revenueByCategory ?? this.revenueByCategory,
        );

    factory Dishes.fromJson(Map<String, dynamic> json) => Dishes(
        totalDishes: json["totalDishes"],
        categoryCounts: json["categoryCounts"] == null ? null : CategoryCounts.fromJson(json["categoryCounts"]),
        averageRating: json["averageRating"]?.toDouble(),
        popularDishes: json["popularDishes"] == null ? [] : List<PopularDish>.from(json["popularDishes"]!.map((x) => PopularDish.fromJson(x))),
        revenueByCategory: json["revenueByCategory"] == null ? [] : List<RevenueByCategory>.from(json["revenueByCategory"]!.map((x) => RevenueByCategory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "totalDishes": totalDishes,
        "categoryCounts": categoryCounts?.toJson(),
        "averageRating": averageRating,
        "popularDishes": popularDishes == null ? [] : List<dynamic>.from(popularDishes!.map((x) => x.toJson())),
        "revenueByCategory": revenueByCategory == null ? [] : List<dynamic>.from(revenueByCategory!.map((x) => x.toJson())),
    };
}

class CategoryCounts {
    int? appetizers;
    int? mainCourse;
    int? desserts;
    int? beverages;
    int? noodles;
    int? rice;

    CategoryCounts({
        this.appetizers,
        this.mainCourse,
        this.desserts,
        this.beverages,
        this.noodles,
        this.rice,
    });

    CategoryCounts copyWith({
        int? appetizers,
        int? mainCourse,
        int? desserts,
        int? beverages,
        int? noodles,
        int? rice,
    }) =>
        CategoryCounts(
            appetizers: appetizers ?? this.appetizers,
            mainCourse: mainCourse ?? this.mainCourse,
            desserts: desserts ?? this.desserts,
            beverages: beverages ?? this.beverages,
            noodles: noodles ?? this.noodles,
            rice: rice ?? this.rice,
        );

    factory CategoryCounts.fromJson(Map<String, dynamic> json) => CategoryCounts(
        appetizers: json["appetizers"],
        mainCourse: json["mainCourse"],
        desserts: json["desserts"],
        beverages: json["beverages"],
        noodles: json["noodles"],
        rice: json["rice"],
    );

    Map<String, dynamic> toJson() => {
        "appetizers": appetizers,
        "mainCourse": mainCourse,
        "desserts": desserts,
        "beverages": beverages,
        "noodles": noodles,
        "rice": rice,
    };
}

class PopularDish {
    int? dishId;
    String? name;
    String? imageUrl;
    String? price;
    String? category;
    String? rating;
    String? totalOrdered;

    PopularDish({
        this.dishId,
        this.name,
        this.imageUrl,
        this.price,
        this.category,
        this.rating,
        this.totalOrdered,
    });

    PopularDish copyWith({
        int? dishId,
        String? name,
        String? imageUrl,
        String? price,
        String? category,
        String? rating,
        String? totalOrdered,
    }) =>
        PopularDish(
            dishId: dishId ?? this.dishId,
            name: name ?? this.name,
            imageUrl: imageUrl ?? this.imageUrl,
            price: price ?? this.price,
            category: category ?? this.category,
            rating: rating ?? this.rating,
            totalOrdered: totalOrdered ?? this.totalOrdered,
        );

    factory PopularDish.fromJson(Map<String, dynamic> json) => PopularDish(
        dishId: json["dishId"],
        name: json["name"],
        imageUrl: json["imageUrl"],
        price: json["price"],
        category: json["category"],
        rating: json["rating"],
        totalOrdered: json["totalOrdered"],
    );

    Map<String, dynamic> toJson() => {
        "dishId": dishId,
        "name": name,
        "imageUrl": imageUrl,
        "price": price,
        "category": category,
        "rating": rating,
        "totalOrdered": totalOrdered,
    };
}

class RevenueByCategory {
    String? category;
    String? categoryRevenue;
    String? orderCount;

    RevenueByCategory({
        this.category,
        this.categoryRevenue,
        this.orderCount,
    });

    RevenueByCategory copyWith({
        String? category,
        String? categoryRevenue,
        String? orderCount,
    }) =>
        RevenueByCategory(
            category: category ?? this.category,
            categoryRevenue: categoryRevenue ?? this.categoryRevenue,
            orderCount: orderCount ?? this.orderCount,
        );

    factory RevenueByCategory.fromJson(Map<String, dynamic> json) => RevenueByCategory(
        category: json["category"],
        categoryRevenue: json["category_revenue"],
        orderCount: json["order_count"],
    );

    Map<String, dynamic> toJson() => {
        "category": category,
        "category_revenue": categoryRevenue,
        "order_count": orderCount,
    };
}

class Orders {
    int? totalOrders;
    int? completedOrders;
    int? pendingOrders;
    int? inProgressOrders;
    List<dynamic>? ordersByDate;

    Orders({
        this.totalOrders,
        this.completedOrders,
        this.pendingOrders,
        this.inProgressOrders,
        this.ordersByDate,
    });

    Orders copyWith({
        int? totalOrders,
        int? completedOrders,
        int? pendingOrders,
        int? inProgressOrders,
        List<dynamic>? ordersByDate,
    }) =>
        Orders(
            totalOrders: totalOrders ?? this.totalOrders,
            completedOrders: completedOrders ?? this.completedOrders,
            pendingOrders: pendingOrders ?? this.pendingOrders,
            inProgressOrders: inProgressOrders ?? this.inProgressOrders,
            ordersByDate: ordersByDate ?? this.ordersByDate,
        );

    factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        totalOrders: json["totalOrders"],
        completedOrders: json["completedOrders"],
        pendingOrders: json["pendingOrders"],
        inProgressOrders: json["inProgressOrders"],
        ordersByDate: json["ordersByDate"] == null ? [] : List<dynamic>.from(json["ordersByDate"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "totalOrders": totalOrders,
        "completedOrders": completedOrders,
        "pendingOrders": pendingOrders,
        "inProgressOrders": inProgressOrders,
        "ordersByDate": ordersByDate == null ? [] : List<dynamic>.from(ordersByDate!.map((x) => x)),
    };
}

class RecentActivity {
    List<RecentOrder>? recentOrders;

    RecentActivity({
        this.recentOrders,
    });

    RecentActivity copyWith({
        List<RecentOrder>? recentOrders,
    }) =>
        RecentActivity(
            recentOrders: recentOrders ?? this.recentOrders,
        );

    factory RecentActivity.fromJson(Map<String, dynamic> json) => RecentActivity(
        recentOrders: json["recentOrders"] == null ? [] : List<RecentOrder>.from(json["recentOrders"]!.map((x) => RecentOrder.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "recentOrders": recentOrders == null ? [] : List<dynamic>.from(recentOrders!.map((x) => x.toJson())),
    };
}

class RecentOrder {
    int? orderId;
    String? userId;
    String? username;
    String? customerName;
    String? totalPrice;
    String? status;
    int? tableId;
    DateTime? orderDate;
    String? itemCount;

    RecentOrder({
        this.orderId,
        this.userId,
        this.username,
        this.customerName,
        this.totalPrice,
        this.status,
        this.tableId,
        this.orderDate,
        this.itemCount,
    });

    RecentOrder copyWith({
        int? orderId,
        String? userId,
        String? username,
        String? customerName,
        String? totalPrice,
        String? status,
        int? tableId,
        DateTime? orderDate,
        String? itemCount,
    }) =>
        RecentOrder(
            orderId: orderId ?? this.orderId,
            userId: userId ?? this.userId,
            username: username ?? this.username,
            customerName: customerName ?? this.customerName,
            totalPrice: totalPrice ?? this.totalPrice,
            status: status ?? this.status,
            tableId: tableId ?? this.tableId,
            orderDate: orderDate ?? this.orderDate,
            itemCount: itemCount ?? this.itemCount,
        );

    factory RecentOrder.fromJson(Map<String, dynamic> json) => RecentOrder(
        orderId: json["orderId"],
        userId: json["userId"],
        username: json["username"],
        customerName: json["customerName"],
        totalPrice: json["totalPrice"],
        status: json["status"],
        tableId: json["tableId"],
        orderDate: json["orderDate"] == null ? null : DateTime.parse(json["orderDate"]),
        itemCount: json["itemCount"],
    );

    Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "userId": userId,
        "username": username,
        "customerName": customerName,
        "totalPrice": totalPrice,
        "status": status,
        "tableId": tableId,
        "orderDate": orderDate?.toIso8601String(),
        "itemCount": itemCount,
    };
}

class Reservations {
    int? totalReservations;
    int? confirmedReservations;
    int? pendingReservations;
    int? todayReservations;
    int? upcomingReservations;

    Reservations({
        this.totalReservations,
        this.confirmedReservations,
        this.pendingReservations,
        this.todayReservations,
        this.upcomingReservations,
    });

    Reservations copyWith({
        int? totalReservations,
        int? confirmedReservations,
        int? pendingReservations,
        int? todayReservations,
        int? upcomingReservations,
    }) =>
        Reservations(
            totalReservations: totalReservations ?? this.totalReservations,
            confirmedReservations: confirmedReservations ?? this.confirmedReservations,
            pendingReservations: pendingReservations ?? this.pendingReservations,
            todayReservations: todayReservations ?? this.todayReservations,
            upcomingReservations: upcomingReservations ?? this.upcomingReservations,
        );

    factory Reservations.fromJson(Map<String, dynamic> json) => Reservations(
        totalReservations: json["totalReservations"],
        confirmedReservations: json["confirmedReservations"],
        pendingReservations: json["pendingReservations"],
        todayReservations: json["todayReservations"],
        upcomingReservations: json["upcomingReservations"],
    );

    Map<String, dynamic> toJson() => {
        "totalReservations": totalReservations,
        "confirmedReservations": confirmedReservations,
        "pendingReservations": pendingReservations,
        "todayReservations": todayReservations,
        "upcomingReservations": upcomingReservations,
    };
}

class Revenue {
    int? totalRevenue;
    int? todayRevenue;
    int? monthRevenue;
    int? revenueGrowth;

    Revenue({
        this.totalRevenue,
        this.todayRevenue,
        this.monthRevenue,
        this.revenueGrowth,
    });

    Revenue copyWith({
        int? totalRevenue,
        int? todayRevenue,
        int? monthRevenue,
        int? revenueGrowth,
    }) =>
        Revenue(
            totalRevenue: totalRevenue ?? this.totalRevenue,
            todayRevenue: todayRevenue ?? this.todayRevenue,
            monthRevenue: monthRevenue ?? this.monthRevenue,
            revenueGrowth: revenueGrowth ?? this.revenueGrowth,
        );

    factory Revenue.fromJson(Map<String, dynamic> json) => Revenue(
        totalRevenue: json["totalRevenue"],
        todayRevenue: json["todayRevenue"],
        monthRevenue: json["monthRevenue"],
        revenueGrowth: json["revenueGrowth"],
    );

    Map<String, dynamic> toJson() => {
        "totalRevenue": totalRevenue,
        "todayRevenue": todayRevenue,
        "monthRevenue": monthRevenue,
        "revenueGrowth": revenueGrowth,
    };
}

class Tables {
    int? totalTables;
    int? availableTables;
    int? occupiedTables;
    int? reservedTables;
    int? totalCapacity;

    Tables({
        this.totalTables,
        this.availableTables,
        this.occupiedTables,
        this.reservedTables,
        this.totalCapacity,
    });

    Tables copyWith({
        int? totalTables,
        int? availableTables,
        int? occupiedTables,
        int? reservedTables,
        int? totalCapacity,
    }) =>
        Tables(
            totalTables: totalTables ?? this.totalTables,
            availableTables: availableTables ?? this.availableTables,
            occupiedTables: occupiedTables ?? this.occupiedTables,
            reservedTables: reservedTables ?? this.reservedTables,
            totalCapacity: totalCapacity ?? this.totalCapacity,
        );

    factory Tables.fromJson(Map<String, dynamic> json) => Tables(
        totalTables: json["totalTables"],
        availableTables: json["availableTables"],
        occupiedTables: json["occupiedTables"],
        reservedTables: json["reservedTables"],
        totalCapacity: json["totalCapacity"],
    );

    Map<String, dynamic> toJson() => {
        "totalTables": totalTables,
        "availableTables": availableTables,
        "occupiedTables": occupiedTables,
        "reservedTables": reservedTables,
        "totalCapacity": totalCapacity,
    };
}

class Users {
    int? totalUsers;
    int? totalCustomers;
    int? totalStaff;
    int? totalAdmins;
    int? newUsersLast30Days;

    Users({
        this.totalUsers,
        this.totalCustomers,
        this.totalStaff,
        this.totalAdmins,
        this.newUsersLast30Days,
    });

    Users copyWith({
        int? totalUsers,
        int? totalCustomers,
        int? totalStaff,
        int? totalAdmins,
        int? newUsersLast30Days,
    }) =>
        Users(
            totalUsers: totalUsers ?? this.totalUsers,
            totalCustomers: totalCustomers ?? this.totalCustomers,
            totalStaff: totalStaff ?? this.totalStaff,
            totalAdmins: totalAdmins ?? this.totalAdmins,
            newUsersLast30Days: newUsersLast30Days ?? this.newUsersLast30Days,
        );

    factory Users.fromJson(Map<String, dynamic> json) => Users(
        totalUsers: json["totalUsers"],
        totalCustomers: json["totalCustomers"],
        totalStaff: json["totalStaff"],
        totalAdmins: json["totalAdmins"],
        newUsersLast30Days: json["newUsersLast30Days"],
    );

    Map<String, dynamic> toJson() => {
        "totalUsers": totalUsers,
        "totalCustomers": totalCustomers,
        "totalStaff": totalStaff,
        "totalAdmins": totalAdmins,
        "newUsersLast30Days": newUsersLast30Days,
    };
}
