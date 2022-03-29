import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../data/model/product_model.dart';
import '../../../utils/helpers.dart';
import '../../../utils/styles.dart';
import '../../widgets/custom_text.dart';

class ProductCard extends StatelessWidget {
  final Product item;
  final Function onTap;
  const ProductCard({Key? key, required this.item, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
            key: const Key('containerCard'),
            width: 50.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  key: const Key('cachedImage'),
                  imageUrl: item.detailProduct!.prdImage01!,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 200,
                    height: 160,
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30.sp,
                        child: NormalText(
                            key: const Key('prdNm'),
                            text: item.prdNm,
                            fontSize: 10.sp,
                            maxLines: 2,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          NormalText(
                              key: const Key('prdPrice'),
                              text: Helper()
                                  .formatRupiah(int.tryParse(item.selPrc!)!),
                              fontSize: 12.sp,
                              maxLines: 2,
                              fontWeight: FontWeight.w400,
                              color: ColorPalettes.bluePrimary),
                          Visibility(
                            visible: item.freeDelivery! != '0',
                            child: SvgPicture.asset(
                                'assets/svg/free_delivery.svg',
                                height: 16.sp,
                                width: 16.sp),
                          ),
                        ],
                      ),
                      NormalText(
                          key: const Key('selQty'),
                          text: '${item.prdSelQty} sold',
                          fontSize: 10.sp,
                          maxLines: 2,
                          fontWeight: FontWeight.w400,
                          color: ColorPalettes.greyLight),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
