import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onoq/data/service/data/api/product_service.dart';
import 'package:xml/xml.dart';
import '../../../data/model/delivery_model.dart';
import '../../../data/model/product_detail_model.dart';
import '../../../data/model/product_model.dart';
import '../../../data/service/data/local/product_local_service.dart';
import '../../../data/service/network/network_helper.dart';
import '../../../data/service/network/urls.dart';

class ProductController extends GetxController {
  RxList<Product> products = <Product>[].obs;
  RxList<Delivery> deliveryList = <Delivery>[].obs;
  Rx<DetailProduct> detailProduct = DetailProduct().obs;
  RxList<Product> searchList = <Product>[].obs;
  RxList<Product> oldSearch = <Product>[].obs;
  NetworkHelper helper = NetworkHelper();
  RxInt? quantitySelectedProduct = 0.obs;
  RxString? key = "".obs;
  RxBool? isLoading = false.obs;
  RxBool? isLoadMore = false.obs;

  Future<List<Product>> getProducts(int page, bool isOnline) async {
    isLoading!.value = true;
    List<Product> list = await ProductLocalService().getCacheProduct();
    if (isOnline) {
      await getDeliveryService();
      List<Product> product = await ProductService().getProduct(page);
      list = await ProductLocalService().addCacheProduct(product);
      print(list.length);
    }

    products.assignAll(list);
    isLoading!.value = false;
    isLoadMore!.value = false;

    return products;
  }

  Future getDetailProduct(String? prodNo) async {
    detailProduct.value = DetailProduct();

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
          detailProduct.value = DetailProduct.fromXml(detail.single);

          return detail.single;

          // print(listProd.length);
        },
        onError: (error) {
          return '';
        });
  }

  void searchProduct(String? keyword) async {
    key!.value = keyword!;
    isLoading!.value = true;
    if (key == null || key!.value == "") {
      isLoading!.value = false;
    } else {
      searchList.clear();
      for (var product in products) {
        if (product.prdNm!.toLowerCase().contains(key!.toLowerCase())) {
          searchList.add(product);
        }
      }
      isLoading!(false);
    }
  }

  void getMoreProduct(String keywordSearch, int page) async {
    isLoadMore!.value = true;
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      getProducts(page, true);
    } else {
      getProducts(page, false);
    }
  }

  Future getDeliveryService() async {
    Box box = await Hive.openBox('delivery');
    var data = box.get('deliveryService');

    if (data != null) {
      List<Delivery> result =
          (data as Iterable).map<Delivery>((i) => i).toList();
      deliveryList.assignAll(result);
    } else {
      return helper.get(
          path: Urls.deliveryList,
          headers: {
            'Content-Type': 'application/xml',
            'openapikey': '721407f393e84a28593374cc2b347a98',
            'Accept-Charset': 'utf-8'
          },
          onSuccess: (content) {
            var raw = XmlDocument.parse(content);
            var listRaw = raw.findAllElements('template');
            for (var e in listRaw) {
              deliveryList.add(Delivery.fromXml(e));
            }
            box.put('deliveryService', deliveryList);

            isLoading!.value = false;
            return;
          },
          onError: (error) {
            return;
          });
    }
  }

  void decreaseQuantity() {
    if (quantitySelectedProduct!.value > 0) {
      quantitySelectedProduct!.value--;
    }
  }

  void increaseQuantity() {
    quantitySelectedProduct!.value++;
  }
}
