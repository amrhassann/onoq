import 'package:hive/hive.dart';
import 'package:onoq/data/model/product_model.dart';
part 'cart_model.g.dart';

@HiveType(typeId: 5)
class CartModel {
  CartModel({this.product, this.quantity});
  @HiveField(1)
  int? quantity;
  @HiveField(2)
  Product? product;
}
