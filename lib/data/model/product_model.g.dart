// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 1;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      detailProduct: fields[0] as DetailProduct?,
      prdNm: fields[1] as String?,
      prdNo: fields[2] as String?,
      prdSelQty: fields[3] as String?,
      selPrc: fields[4] as String?,
      dscPrice: fields[6] as String?,
      freeDelivery: fields[7] as String?,
      stock: fields[8] as String?,
    )..tmpltSeq = fields[5] as String?;
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.detailProduct)
      ..writeByte(1)
      ..write(obj.prdNm)
      ..writeByte(2)
      ..write(obj.prdNo)
      ..writeByte(3)
      ..write(obj.prdSelQty)
      ..writeByte(4)
      ..write(obj.selPrc)
      ..writeByte(5)
      ..write(obj.tmpltSeq)
      ..writeByte(6)
      ..write(obj.dscPrice)
      ..writeByte(7)
      ..write(obj.freeDelivery)
      ..writeByte(8)
      ..write(obj.stock);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
