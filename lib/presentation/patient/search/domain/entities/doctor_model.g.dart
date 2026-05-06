// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DoctorModelAdapter extends TypeAdapter<DoctorModel> {
  @override
  final int typeId = 0;

  @override
  DoctorModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DoctorModel(
      name: fields[0] as String,
      specialty: fields[1] as String,
      rating: fields[2] as String,
      ratingCount: fields[3] as String,
      price: fields[4] as String,
      imageUrl: fields[5] as String?,
      gender: fields[6] as String?,
      location: fields[7] as String?,
      availableDays: (fields[8] as List).cast<DateTime>(),
      clinkId: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DoctorModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.specialty)
      ..writeByte(2)
      ..write(obj.rating)
      ..writeByte(3)
      ..write(obj.ratingCount)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.imageUrl)
      ..writeByte(6)
      ..write(obj.gender)
      ..writeByte(7)
      ..write(obj.location)
      ..writeByte(8)
      ..write(obj.availableDays)
      ..writeByte(9)
      ..write(obj.clinkId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DoctorModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
