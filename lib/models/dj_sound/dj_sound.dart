import 'package:hive/hive.dart';

part 'dj_sound.g.dart';

@HiveType(typeId: 1)
class DJSound extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String link;

  @HiveField(3)
  String localPath;

  @HiveField(4)
  final bool loop;

  @HiveField(5)
  final int delay;

  DJSound({
    required this.id,
    required this.name,
    required this.link,
    required this.delay,
    this.localPath = '',
    required this.loop,
  });

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'loop': loop,
    'link': link,
    'localPath': localPath,
    'delay': delay,
  };

  factory DJSound.fromJson(Map<String, dynamic> json) {
    return DJSound(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      loop: json['loop'] is bool ? json['loop'] : false,
      link: json['link']?.toString() ?? '',
      localPath: json['localPath']?.toString() ?? '',
      delay: json['delay'] is int ? json['delay'] : int.tryParse(json['delay']?.toString() ?? '') ?? 0,
    );
  }
}