// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sound_box.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SoundDataAdapter extends TypeAdapter<SoundData> {
  @override
  final int typeId = 2;

  @override
  SoundData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SoundData(
      sideASounds: (fields[0] as List).cast<String>(),
      sideBSounds: (fields[1] as List).cast<String>(),
      padSize: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SoundData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.sideASounds)
      ..writeByte(1)
      ..write(obj.sideBSounds)
      ..writeByte(2)
      ..write(obj.padSize);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SoundDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
