import 'package:hive/hive.dart';
import 'package:xml/xml.dart';

part 'delivery_model.g.dart';

@HiveType(typeId: 3)
class Delivery {
  Delivery({
    this.dlvTmpltNm,
    this.dlvTmpltSeq,
  });

  @HiveField(1)
  String? dlvTmpltNm;
  @HiveField(2)
  String? dlvTmpltSeq;

  Delivery.fromXml(XmlElement e) {
    dlvTmpltNm = e.findElements('dlvTmpltNm').isEmpty
        ? ''
        : e.findElements('dlvTmpltNm').first.text;
    dlvTmpltSeq = e.findElements('dlvTmpltSeq').isEmpty
        ? ''
        : e.findElements('dlvTmpltSeq').first.text;
  }
}
