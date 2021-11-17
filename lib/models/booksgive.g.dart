// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booksgive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BooksGiveAdapter extends TypeAdapter<BooksGive> {
  @override
  final int typeId = 0;

  @override
  BooksGive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BooksGive()
      ..name = fields[0] as String
      ..author = fields[1] as String
      ..isbn = fields[2] as String
      ..owner = fields[3] as String
      ..image = fields[4] as String?;
  }

  @override
  void write(BinaryWriter writer, BooksGive obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.author)
      ..writeByte(2)
      ..write(obj.isbn)
      ..writeByte(3)
      ..write(obj.owner)
      ..writeByte(4)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BooksGiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
