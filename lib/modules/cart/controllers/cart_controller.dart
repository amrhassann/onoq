import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../data/model/cart_model.dart';

class CartController extends GetxController {
  RxList<CartModel> cartList = <CartModel>[].obs;
  RxInt? totalPriceCart = 0.obs;
  RxBool? isLoading = false.obs;
  Future<List<CartModel>> getCart() async {
    Box box = await Hive.openBox('cart');
    var data = box.get('carts');

    if (data != null) {
      List<CartModel> result =
          (data as Iterable).map<CartModel>((i) => i).toList();
      cartList.assignAll(result);
      for (var element in result) {
        totalPriceCart!.value +=
            (int.parse(element.product!.selPrc!) * element.quantity!);
      }
    }
    isLoading!(false);
    return cartList;
  }

  Future<bool?> addItemToCart(CartModel? cart) async {
    Box box = await Hive.openBox('cart');
    var data = box.get('carts');
    List<CartModel> cartList = <CartModel>[];
    if (data != null) {
      List<CartModel> result =
          (data as Iterable).map<CartModel>((i) => i).toList();
      if (result
          .where((element) => element.product!.prdNo == cart!.product!.prdNo)
          .isEmpty) {
        result.add(cart!);
        box.put('carts', result);
        getCart();

        return true;
      } else {
        return false;
      }
    } else {
      cartList.add(cart!);
      box.put('carts', cartList);
      getCart();

      return true;
    }
  }
}
