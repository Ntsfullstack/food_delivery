import 'package:hive/hive.dart';

part 'categories.g.dart';

@HiveType(typeId: 3) // Use a unique typeId
class Category extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  num? cateID;

  @HiveField(2)
  String? name;

  @HiveField(3)
  String? cover;

  Category({
    this.id,
    this.cateID,
    this.name,
    this.cover,
  });

  Category.fromJson(dynamic json) {
    id = json['_id'];
    cateID = json['CateID'];
    name = json['Name'];
    cover = json['Cover'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['CateID'] = cateID;
    map['Name'] = name;
    map['Cover'] = cover;
    return map;
  }
}