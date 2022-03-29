import 'package:hive/hive.dart';
import 'package:xml/xml.dart';
part 'product_option_model.g.dart';

@HiveType(typeId: 4)
class ProductOptionDetails {
  ProductOptionDetails({
    this.stckQty,
    this.selQty,
  });
  @HiveField(1)
  String? selQty;
  @HiveField(2)
  String? stckQty;

  ProductOptionDetails.fromXml(XmlElement e) {
    selQty = e.findElements('selQty').isEmpty
        ? ''
        : e.findElements('selQty').first.text;

    stckQty = e.findElements('stckQty').isEmpty
        ? ''
        : e.findElements('stckQty').first.text;
  }
}
