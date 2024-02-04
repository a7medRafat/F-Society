// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_users.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AllUsersModelAdapter extends TypeAdapter<AllUsersModel> {
  @override
  final int typeId = 2;

  @override
  AllUsersModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AllUsersModel(
      name: fields[0] as String?,
      email: fields[1] as String?,
      phone: fields[2] as String?,
      uid: fields[3] as String?,
      isEmailVerified: fields[6] as bool?,
      image: fields[4] as String?,
      bio: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AllUsersModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.uid)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.bio)
      ..writeByte(6)
      ..write(obj.isEmailVerified);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllUsersModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
