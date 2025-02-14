// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dj_sound.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DJSoundAdapter extends TypeAdapter<DJSound> {
  @override
  final int typeId = 1;

  @override
  DJSound read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DJSound(
      id: fields[0] as String,
      name: fields[1] as String,
      link: fields[2] as String,
      delay: fields[5] as int,
      localPath: fields[3] as String,
      loop: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, DJSound obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.link)
      ..writeByte(3)
      ..write(obj.localPath)
      ..writeByte(4)
      ..write(obj.loop)
      ..writeByte(5)
      ..write(obj.delay);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DJSoundAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
