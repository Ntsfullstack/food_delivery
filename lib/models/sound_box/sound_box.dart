import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

part 'sound_box.g.dart';

@HiveType(typeId: 2) // Changed from 0 to 1
class SoundData extends HiveObject {
  @HiveField(0)
  final List<String> sideASounds;

  @HiveField(1)
  final List<String> sideBSounds;

  @HiveField(2)
  final String padSize;

  SoundData({
    required this.sideASounds,
    required this.sideBSounds,
    required this.padSize,
  });

  Future<SoundData> toRelativePaths() async {
    final appDir = await getApplicationDocumentsDirectory();
    return SoundData(
      sideASounds: sideASounds.map((p) => p.isEmpty ? '' : path.relative(p, from: appDir.path)).toList(),
      sideBSounds: sideBSounds.map((p) => p.isEmpty ? '' : path.relative(p, from: appDir.path)).toList(),
      padSize: padSize,
    );
  }

  static Future<SoundData> fromRelativePaths(SoundData data) async {
    final appDir = await getApplicationDocumentsDirectory();
    return SoundData(
      sideASounds: data.sideASounds.map((p) => p.isEmpty ? '' : path.join(appDir.path, p)).toList(),
      sideBSounds: data.sideBSounds.map((p) => p.isEmpty ? '' : path.join(appDir.path, p)).toList(),
      padSize: data.padSize,
    );
  }

  Future<bool> validateFiles() async {
    for (String path in [...sideASounds, ...sideBSounds]) {
      if (path.isNotEmpty && !await File(path).exists()) {
        return false;
      }
    }
    return true;
  }
}