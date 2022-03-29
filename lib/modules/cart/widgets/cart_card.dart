import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../data/model/cart_model.dart';
import '../../../utils/helpers.dart';
import '../../../utils/styles.dart';
import '../../widgets/custom_text.dart';

class CartCard extends StatelessWidget {
  final CartModel cart;
  const CartCard({Key? key, required this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 3,
                child: CachedNetworkImage(
                  imageUrl: cart.product!.detailProduct!.prdImage01!,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 100,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      SizedBox(
                    height: 160,
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.black),
                        value: downloadProgress.progress,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/image_error.jpeg',
                    height: 160,
                    width: 200,
                  ),
                ),
              ),
              Flexible(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NormalText(
                          text: cart.product!.prdNm,
                          fontSize: 10.sp,
                          maxLines: 2,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                      NormalText(
                          text: Helper().formatRupiah(
                              int.tryParse(cart.product!.selPrc!)!),
                          fontSize: 10.sp,
                          maxLines: 2,
                          fontWeight: FontWeight.w400,
                          color: ColorPalettes.greyLight),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 100.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                NormalText(
                    text: 'Qty :',
                    fontSize: 10.sp,
                    maxLines: 2,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
                NormalText(
                    text: cart.quantity.toString(),
                    fontSize: 10.sp,
                    maxLines: 2,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
