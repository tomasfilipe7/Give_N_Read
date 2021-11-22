// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookstop.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookStopAdapter extends TypeAdapter<BookStop> {
  @override
  final int typeId = 2;

  @override
  BookStop read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookStop()
      ..name = fields[0] as String
      ..author = fields[1] as String
      ..isbn = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, BookStop obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.author)
      ..writeByte(2)
      ..write(obj.isbn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookStopAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
