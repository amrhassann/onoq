import 'package:hive/hive.dart';
import 'package:onoq/data/model/product_option_model.dart';
import 'package:xml/xml.dart';

part 'product_detail_model.g.dart';

@HiveType(typeId: 2)
class DetailProduct {
  DetailProduct({
    this.asDetail,
    this.htmlDetail,
    this.prdImage01,
    this.prdImage02,
    this.prdImage03,
    this.prdImage04,
    this.prdNm,
    this.prdNo,
    this.prdSelQty,
    this.prdWght,
    this.selPrc,
    this.tmpltSeq,
    this.productOption,
    this.dscPrice,
    this.freeDelivery,
    this.dispCtgrNo1,
    this.stock,
    this.updateDt,
  });
  @HiveField(1)
  String? asDetail;
  @HiveField(2)
  String? htmlDetail;
  @HiveField(3)
  String? prdImage01;
  @HiveField(4)
  String? prdImage02;
  @HiveField(5)
  String? prdImage03;
  @HiveField(6)
  String? prdImage04;
  @HiveField(7)
  String? prdNm;
  @HiveField(8)
  String? prdNo;
  @HiveField(9)
  String? prdSelQty;
  @HiveField(10)
  String? prdWght;
  @HiveField(11)
  ProductOptionDetails? productOption;
  @HiveField(12)
  String? selPrc;
  @HiveField(13)
  String? tmpltSeq;
  @HiveField(14)
  String? dscPrice;
  @HiveField(15)
  String? freeDelivery;
  @HiveField(16)
  String? dispCtgrNo1;
  @HiveField(17)
  String? stock;
  @HiveField(18)
  DateTime? updateDt;

  DetailProduct.fromXml(XmlElement e) {
    asDetail = e.findElements('asDetail').isEmpty
        ? ''
        : e.findElements('asDetail').first.text;

    htmlDetail = e.findElements('htmlDetail').isEmpty
        ? ''
        : e.findElements('htmlDetail').first.text;

    prdImage01 = (e.findElements('prdImage01').isEmpty ||
            e.findElements('prdImage01').first.text ==
                'http://image.elevenia.co.id/g/0/2/2/6/9/6/no_image_300.gif')
        ? 'https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg'
        : e.findElements('prdImage01').first.text;
    prdImage02 = e.findElements('prdImage02').isEmpty ||
            e.findElements('prdImage02').first.text ==
                'http://image.elevenia.co.id/g/0/2/2/6/9/6/no_image_300.gif'
        ? 'https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg'
        : e.findElements('prdImage02').first.text;
    prdImage03 = e.findElements('prdImage03').isEmpty ||
            e.findElements('prdImage03').first.text ==
                'http://image.elevenia.co.id/g/0/2/2/6/9/6/no_image_300.gif'
        ? 'https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg'
        : e.findElements('prdImage03').first.text;
    prdImage04 = e.findElements('prdImage04').isEmpty ||
            e.findElements('prdImage04').first.text ==
                'http://image.elevenia.co.id/g/0/2/2/6/9/6/no_image_300.gif'
        ? 'https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg'
        : e.findElements('prdImage04').first.text;
    prdNm = e.findElements('prdNm').isEmpty
        ? ''
        : e.findElements('prdNm').first.text;
    prdSelQty = e.findElements('prdSelQty').isEmpty
        ? ''
        : e.findElements('prdSelQty').first.text;

    prdWght = e.findElements('prdWght').isEmpty
        ? ''
        : e.findElements('prdWght').first.text;

    selPrc = e.findElements('selPrc').isEmpty
        ? ''
        : e.findElements('selPrc').first.text;

    tmpltSeq = e.findElements('tmpltSeq').isEmpty
        ? ''
        : e.findElements('tmpltSeq').first.text;

    dscPrice = e.findElements('dscPrice').isEmpty
        ? ''
        : e.findElements('dscPrice').first.text;
    freeDelivery = e.findElements('freeDelivery').isEmpty
        ? ''
        : e.findElements('freeDelivery').first.text;

    dispCtgrNo1 = e.findElements('dispCtgrNo1').isEmpty
        ? ''
        : e.findElements('dispCtgrNo1').first.text;
    stock = e.findElements('stock').isEmpty
        ? ''
        : e.findElements('stock').first.text;
    productOption = e.findElements('ProductOptionDetails').isEmpty
        ? ProductOptionDetails()
        : ProductOptionDetails.fromXml(
            e.findElements('ProductOptionDetails').first);
    updateDt = e.findElements('updateDt').isEmpty
        ? DateTime.now()
        : DateTime.tryParse(e.findElements('updateDt').first.text);
  }

  DetailProduct.fromJson(Map<String, dynamic> json) {
    asDetail = json['asDetail'];
    htmlDetail = json['htmlDetail'];
    prdImage01 = json['prdImage01'];
    prdImage02 = json['prdImage02'];
    prdImage03 = json['prdImage03'];
    prdImage04 = json['prdImage04'];
    prdNm = json['prdNm'];
    prdNo = json['prdNo'];
    prdSelQty = json['prdSelQty'];
    prdWght = json['prdWght'];
    selPrc = json['selPrc'];
    tmpltSeq = json['tmpltSeq'];
    productOption = json['productOption'];
    dscPrice = json['dscPrice'];
    freeDelivery = json['freeDelivery'];
    dispCtgrNo1 = json['dispCtgrNo1'];
    stock = json['stock'];
    updateDt = json['updateDt'];
  }
}
