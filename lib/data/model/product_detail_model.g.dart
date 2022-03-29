// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DetailProductAdapter extends TypeAdapter<DetailProduct> {
  @override
  final int typeId = 2;

  @override
  DetailProduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DetailProduct(
      asDetail: fields[1] as String?,
      htmlDetail: fields[2] as String?,
      prdImage01: fields[3] as String?,
      prdImage02: fields[4] as String?,
      prdImage03: fields[5] as String?,
      prdImage04: fields[6] as String?,
      prdNm: fields[7] as String?,
      prdNo: fields[8] as String?,
      prdSelQty: fields[9] as String?,
      prdWght: fields[10] as String?,
      selPrc: fields[12] as String?,
      tmpltSeq: fields[13] as String?,
      productOption: fields[11] as ProductOptionDetails?,
      dscPrice: fields[14] as String?,
      freeDelivery: fields[15] as String?,
      dispCtgrNo1: fields[16] as String?,
      stock: fields[17] as String?,
      updateDt: fields[18] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, DetailProduct obj) {
    writer
      ..writeByte(18)
      ..writeByte(1)
      ..write(obj.asDetail)
      ..writeByte(2)
      ..write(obj.htmlDetail)
      ..writeByte(3)
      ..write(obj.prdImage01)
      ..writeByte(4)
      ..write(obj.prdImage02)
      ..writeByte(5)
      ..write(obj.prdImage03)
      ..writeByte(6)
      ..write(obj.prdImage04)
      ..writeByte(7)
      ..write(obj.prdNm)
      ..writeByte(8)
      ..write(obj.prdNo)
      ..writeByte(9)
      ..write(obj.prdSelQty)
      ..writeByte(10)
      ..write(obj.prdWght)
      ..writeByte(11)
      ..write(obj.productOption)
      ..writeByte(12)
      ..write(obj.selPrc)
      ..writeByte(13)
      ..write(obj.tmpltSeq)
      ..writeByte(14)
      ..write(obj.dscPrice)
      ..writeByte(15)
      ..write(obj.freeDelivery)
      ..writeByte(16)
      ..write(obj.dispCtgrNo1)
      ..writeByte(17)
      ..write(obj.stock)
      ..writeByte(18)
      ..write(obj.updateDt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetailProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
