import 'package:hive/hive.dart';

part 'song.g.dart';

@HiveType(typeId: 0)
class Song extends HiveObject {
  @HiveField(0)
  final int songId;

  @HiveField(1)
  final int categoryId;

  @HiveField(2)
  final String id;

  @HiveField(3)
  final String name;

  @HiveField(5)
  final String? cover;

  @HiveField(4)
  final List<Sound> sounds;

  Song({
    required this.id,
    required this.songId,
    required this.categoryId,
    required this.name,
    required this.cover,
    required this.sounds,
  });

  Map<String, dynamic> toJson() => {
    '_id': id,
    'Name': name,
    'ID': songId,
    'Cate': categoryId,
    'Cover': cover,
    'sounds': sounds.map((sound) => sound.toJson()).toList(),
  };

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['_id']?.toString() ?? '',
      name: json['Name']?.toString() ?? '',
      sounds: (json['sounds'] as List<dynamic>?)
          ?.map((soundJson) => Sound.fromJson(soundJson as Map<String, dynamic>))
          .toList() ??
          [],
      songId: json['ID'] is int ? json['ID'] : int.tryParse(json['ID']?.toString() ?? '') ?? 0,
      categoryId: json['Cate'] is int ? json['Cate'] : int.tryParse(json['Cate']?.toString() ?? '') ?? 0,
      cover: json['Cover']?.toString() ?? '',
    );
  }
}

@HiveType(typeId: 1) // typeId phải duy nhất
class Sound extends HiveObject {
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

  Sound({
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

  factory Sound.fromJson(Map<String, dynamic> json) {
    return Sound(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      loop: json['loop'] is bool ? json['loop'] : false,
      link: json['link']?.toString() ?? '',
      localPath: json['localPath']?.toString() ?? '',
      delay: json['delay'] is int ? json['delay'] : int.tryParse(json['delay']?.toString() ?? '') ?? 0,
    );
  }
}
