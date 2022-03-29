import 'package:hive/hive.dart';

import '../../../model/product_model.dart';

class ProductLocalService {
  Future<List<Product>> getCacheProduct() async {
    Box box = await Hive.openBox('product');
    List<Product> products = <Product>[];
    var data = box.get('listProduct');
    if (data == null) {
      return <Product>[];
    } else {
      var list = (data as Iterable).map<Product>((i) => i).toList();
      products.addAll(list);
      return products;
    }
  }

  Future<List<Product>> addCacheProduct(List<Product> listProduct) async {
    Box box = await Hive.openBox('product');
    var data = box.get('listProduct');
    if (data == null) {
      box.put('listProduct', listProduct);

      return listProduct;
    } else {
      var list = (data as Iterable).map<Product>((i) => i).toList();

      list.addAll(listProduct);
      box.put('listProduct', list);
      return list;
    }
  }
}
