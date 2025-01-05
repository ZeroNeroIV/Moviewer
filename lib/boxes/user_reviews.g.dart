// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_reviews.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserReviewsAdapter extends TypeAdapter<UserReviews> {
  @override
  final int typeId = 4;

  @override
  UserReviews read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserReviews(
      userId: fields[0] as int,
      movieId: fields[1] as int,
      comment: fields[2] as String,
      rate: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, UserReviews obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.movieId)
      ..writeByte(2)
      ..write(obj.comment)
      ..writeByte(3)
      ..write(obj.rate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserReviewsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
