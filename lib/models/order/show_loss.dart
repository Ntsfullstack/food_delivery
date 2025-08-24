// To parse this JSON data, do
//
//     final showLoss = showLossFromJson(jsonString);

import 'dart:convert';

ShowLoss showLossFromJson(String str) => ShowLoss.fromJson(json.decode(str));

String showLossToJson(ShowLoss data) => json.encode(data.toJson());

class ShowLoss {
  Summary summary;
  List<PeriodBreakdown> periodBreakdown;
  List<DetailedOrder> detailedOrders;

  ShowLoss({
    required this.summary,
    required this.periodBreakdown,
    required this.detailedOrders,
  });

  factory ShowLoss.fromJson(Map<String, dynamic> json) => ShowLoss(
    summary: Summary.fromJson(json["summary"]),
    periodBreakdown: List<PeriodBreakdown>.from(json["period_breakdown"].map((x) => PeriodBreakdown.fromJson(x))),
    detailedOrders: List<DetailedOrder>.from(json["detailed_orders"].map((x) => DetailedOrder.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "summary": summary.toJson(),
    "period_breakdown": List<dynamic>.from(periodBreakdown.map((x) => x.toJson())),
    "detailed_orders": List<dynamic>.from(detailedOrders.map((x) => x.toJson())),
  };
}

class DetailedOrder {
  int orderId;
  DateTime orderDate;
  int totalPrice;
  String userId;

  DetailedOrder({
    required this.orderId,
    required this.orderDate,
    required this.totalPrice,
    required this.userId,
  });

  factory DetailedOrder.fromJson(Map<String, dynamic> json) => DetailedOrder(
    orderId: json["order_id"],
    orderDate: DateTime.parse(json["order_date"]),
    totalPrice: json["total_price"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "order_date": orderDate.toIso8601String(),
    "total_price": totalPrice,
    "user_id": userId,
  };
}

class PeriodBreakdown {
  String period;
  int noShowCount;
  int totalLoss;
  int avgLossPerOrder;

  PeriodBreakdown({
    required this.period,
    required this.noShowCount,
    required this.totalLoss,
    required this.avgLossPerOrder,
  });

  factory PeriodBreakdown.fromJson(Map<String, dynamic> json) => PeriodBreakdown(
    period: json["period"],
    noShowCount: json["no_show_count"],
    totalLoss: json["total_loss"],
    avgLossPerOrder: json["avg_loss_per_order"],
  );

  Map<String, dynamic> toJson() => {
    "period": period,
    "no_show_count": noShowCount,
    "total_loss": totalLoss,
    "avg_loss_per_order": avgLossPerOrder,
  };
}

class Summary {
  int totalNoShowOrders;
  int totalLossPrice;
  double averageLossPerOrder;
  int minLoss;
  int maxLoss;
  Period period;

  Summary({
    required this.totalNoShowOrders,
    required this.totalLossPrice,
    required this.averageLossPerOrder,
    required this.minLoss,
    required this.maxLoss,
    required this.period,
  });

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    totalNoShowOrders: json["total_no_show_orders"],
    totalLossPrice: json["total_loss_price"],
    averageLossPerOrder: json["average_loss_per_order"]?.toDouble(),
    minLoss: json["min_loss"],
    maxLoss: json["max_loss"],
    period: Period.fromJson(json["period"]),
  );

  Map<String, dynamic> toJson() => {
    "total_no_show_orders": totalNoShowOrders,
    "total_loss_price": totalLossPrice,
    "average_loss_per_order": averageLossPerOrder,
    "min_loss": minLoss,
    "max_loss": maxLoss,
    "period": period.toJson(),
  };
}

class Period {
  DateTime start;
  DateTime end;
  String groupBy;

  Period({
    required this.start,
    required this.end,
    required this.groupBy,
  });

  factory Period.fromJson(Map<String, dynamic> json) => Period(
    start: DateTime.parse(json["start"]),
    end: DateTime.parse(json["end"]),
    groupBy: json["groupBy"],
  );

  Map<String, dynamic> toJson() => {
    "start": "${start.year.toString().padLeft(4, '0')}-${start.month.toString().padLeft(2, '0')}-${start.day.toString().padLeft(2, '0')}",
    "end": "${end.year.toString().padLeft(4, '0')}-${end.month.toString().padLeft(2, '0')}-${end.day.toString().padLeft(2, '0')}",
    "groupBy": groupBy,
  };
}
