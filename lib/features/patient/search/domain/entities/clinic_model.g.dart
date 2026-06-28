// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinic_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClinicModelAdapter extends TypeAdapter<ClinicModel> {
  @override
  final int typeId = 1;

  @override
  ClinicModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClinicModel(
      doctorName: fields[0] as String,
      availableDays: (fields[8] as List).cast<DateTime>(),
      doctorSpecialty: fields[1] as String,
      doctorRating: fields[2] as String,
      doctorRatingCount: fields[3] as String,
      clinicPrice: fields[4] as String,
      doctorImageUrl: fields[5] as String?,
      doctorGender: fields[6] as String?,
      clinicLocation: fields[7] as String?,
      clinicId: fields[9] as String,
      clinicName: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ClinicModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.doctorName)
      ..writeByte(1)
      ..write(obj.doctorSpecialty)
      ..writeByte(2)
      ..write(obj.doctorRating)
      ..writeByte(3)
      ..write(obj.doctorRatingCount)
      ..writeByte(4)
      ..write(obj.clinicPrice)
      ..writeByte(5)
      ..write(obj.doctorImageUrl)
      ..writeByte(6)
      ..write(obj.doctorGender)
      ..writeByte(7)
      ..write(obj.clinicLocation)
      ..writeByte(8)
      ..write(obj.availableDays)
      ..writeByte(9)
      ..write(obj.clinicId)
      ..writeByte(10)
      ..write(obj.clinicName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClinicModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
