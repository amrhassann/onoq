import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onoq/modules/cart/widgets/cart_card.dart';
import 'package:sizer/sizer.dart';

import '../../utils/helpers.dart';
import '../product/detail_product_screen.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import 'controllers/cart_controller.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: NormalText(
            text: 'Cart',
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: Colors.black),
      ),
      body: GetX<CartController>(builder: (_) {
        return SafeArea(
          child: _.cartList.isEmpty
              ? Center(
                  child: NormalText(
                      text: 'No product in cart',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black))
              : Stack(
                  children: [
                    SingleChildScrollView(
                      child: SizedBox(
                        height: 90.h,
                        child: Column(
                          children: _.cartList
                              .map((element) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              Get.to(() => DetailProductScreen(
                                                    product: element.product!,
                                                  ));
                                            },
                                            child: CartCard(cart: element)),
                                        const Divider(),
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: 100.w,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                  flex: 8,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      NormalText(
                                          text: 'Total',
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                      NormalText(
                                          text: Helper().formatRupiah(
                                              _.totalPriceCart!.value),
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black)
                                    ],
                                  )),
                              Flexible(
                                flex: 5,
                                child: CustomPrimaryButton(
                                  label: 'Checkout',
                                  rounded: false,
                                  type: ButtonType.large,
                                  onPressed: () {},
                                ),
                              ),
                            ]),
                      ),
                    )
                  ],
                ),
        );
      }),
    );
  }
}
