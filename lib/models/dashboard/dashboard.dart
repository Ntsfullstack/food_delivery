// To parse this JSON data, do
//
//     final dashBoard = dashBoardFromJson(jsonString);

import 'dart:convert';

List<DashBoard> dashBoardFromJson(String str) => List<DashBoard>.from(json.decode(str).map((x) => DashBoard.fromJson(x)));

String dashBoardToJson(List<DashBoard> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DashBoard {
    Orders? orders;
    Revenue? revenue;
    Reservations? reservations;
    Dishes? tables;
    Dishes? dishes;
    List<PopularDish>? popularDishes;

    DashBoard({
        this.orders,
        this.revenue,
        this.reservations,
        this.tables,
        this.dishes,
        this.popularDishes,
    });

    DashBoard copyWith({
        Orders? orders,
        Revenue? revenue,
        Reservations? reservations,
        Dishes? tables,
        Dishes? dishes,
        List<PopularDish>? popularDishes,
    }) =>
        DashBoard(
            orders: orders ?? this.orders,
            revenue: revenue ?? this.revenue,
            reservations: reservations ?? this.reservations,
            tables: tables ?? this.tables,
            dishes: dishes ?? this.dishes,
            popularDishes: popularDishes ?? this.popularDishes,
        );

    factory DashBoard.fromJson(Map<String, dynamic> json) => DashBoard(
        orders: json["orders"] == null ? null : Orders.fromJson(json["orders"]),
        revenue: json["revenue"] == null ? null : Revenue.fromJson(json["revenue"]),
        reservations: json["reservations"] == null ? null : Reservations.fromJson(json["reservations"]),
        tables: json["tables"] == null ? null : Dishes.fromJson(json["tables"]),
        dishes: json["dishes"] == null ? null : Dishes.fromJson(json["dishes"]),
        popularDishes: json["popularDishes"] == null ? [] : List<PopularDish>.from(json["popularDishes"]!.map((x) => PopularDish.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "orders": orders?.toJson(),
        "revenue": revenue?.toJson(),
        "reservations": reservations?.toJson(),
        "tables": tables?.toJson(),
        "dishes": dishes?.toJson(),
        "popularDishes": popularDishes == null ? [] : List<dynamic>.from(popularDishes!.map((x) => x.toJson())),
    };
}

class Dishes {
    int? total;
    int? available;

    Dishes({
        this.total,
        this.available,
    });

    Dishes copyWith({
        int? total,
        int? available,
    }) =>
        Dishes(
            total: total ?? this.total,
            available: available ?? this.available,
        );

    factory Dishes.fromJson(Map<String, dynamic> json) => Dishes(
        total: json["total"],
        available: json["available"],
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "available": available,
    };
}

class Orders {
    int? total;
    int? completed;
    int? pending;

    Orders({
        this.total,
        this.completed,
        this.pending,
    });

    Orders copyWith({
        int? total,
        int? completed,
        int? pending,
    }) =>
        Orders(
            total: total ?? this.total,
            completed: completed ?? this.completed,
            pending: pending ?? this.pending,
        );

    factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        total: json["total"],
        completed: json["completed"],
        pending: json["pending"],
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "completed": completed,
        "pending": pending,
    };
}

class PopularDish {
    int? dishId;
    String? dishName;
    String? count;
    String? price;

    PopularDish({
        this.dishId,
        this.dishName,
        this.count,
        this.price,
    });

    PopularDish copyWith({
        int? dishId,
        String? dishName,
        String? count,
        String? price,
    }) =>
        PopularDish(
            dishId: dishId ?? this.dishId,
            dishName: dishName ?? this.dishName,
            count: count ?? this.count,
            price: price ?? this.price,
        );

    factory PopularDish.fromJson(Map<String, dynamic> json) => PopularDish(
        dishId: json["dishId"],
        dishName: json["dishName"],
        count: json["count"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "dishId": dishId,
        "dishName": dishName,
        "count": count,
        "price": price,
    };
}

class Reservations {
    int? total;
    int? today;

    Reservations({
        this.total,
        this.today,
    });

    Reservations copyWith({
        int? total,
        int? today,
    }) =>
        Reservations(
            total: total ?? this.total,
            today: today ?? this.today,
        );

    factory Reservations.fromJson(Map<String, dynamic> json) => Reservations(
        total: json["total"],
        today: json["today"],
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "today": today,
    };
}

class Revenue {
    double? total;

    Revenue({
        this.total,
    });

    Revenue copyWith({
        double? total,
    }) =>
        Revenue(
            total: total ?? this.total,
        );

    factory Revenue.fromJson(Map<String, dynamic> json) => Revenue(
        total: json["total"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
    };
}
