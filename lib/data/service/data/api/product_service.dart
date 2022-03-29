import 'package:hive/hive.dart';
import 'package:xml/xml.dart';

import '../../../model/product_detail_model.dart';
import '../../../model/product_model.dart';
import '../../network/network_helper.dart';
import '../../network/urls.dart';

class ProductService {
  NetworkHelper helper = NetworkHelper();

  Future<List<Product>> getProduct(int page) async {
    final list = <Product>[];
    Box box = await Hive.openBox('product');

    await helper.get(
        path: Urls.urlListProduct(page),
        headers: {
          'Content-Type': 'application/xml',
          'openapikey': '721407f393e84a28593374cc2b347a98',
          'Accept-Charset': 'utf-8'
        },
        onSuccess: (content) async {
          var raw = XmlDocument.parse(content);
          var listRaw = raw.findAllElements('product');
          for (var e in listRaw) {
            String? prodNo = e.findElements('prdNo').isEmpty
                ? ''
                : e.findElements('prdNo').first.text;
            getDetailProduct(prodNo).then((value) {
              return;
            });
            DetailProduct detail = await getDetailProduct(prodNo);
            list.add(Product.fromXml(e, detail));
          }

          return list;
        },
        onError: (error) {
          return <Product>[];
        });
    return list;
  }

  Future<DetailProduct> getDetailProduct(String? prodNo) async {
    return helper.get(
        path: Urls.urlDetailProduct(prodNo),
        headers: {
          'Content-Type': 'application/xml',
          'openapikey': '721407f393e84a28593374cc2b347a98',
          'Accept-Charset': 'utf-8'
        },
        onSuccess: (detailContent) {
          var rawDetail = XmlDocument.parse(detailContent);
          var detail = rawDetail.findAllElements('Product');
          var detailM = DetailProduct.fromXml(detail.single);
          return detailM;

          // print(listProd.length);
        },
        onError: (error) {
          return error;
        });
  }
}
