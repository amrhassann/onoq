// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_option_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductOptionDetailsAdapter extends TypeAdapter<ProductOptionDetails> {
  @override
  final int typeId = 4;

  @override
  ProductOptionDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductOptionDetails(
      stckQty: fields[2] as String?,
      selQty: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductOptionDetails obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.selQty)
      ..writeByte(2)
      ..write(obj.stckQty);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductOptionDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
