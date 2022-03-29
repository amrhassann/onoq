import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../widgets/custom_text.dart';
import 'controllers/product_controller.dart';
import 'detail_product_screen.dart';
import 'widgets/product_card.dart';
import 'widgets/product_card_shimmer.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({Key? key}) : super(key: key);

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  Widget build(BuildContext context) {
    return GetX<ProductController>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: NormalText(
              text: 'Search for ${_.key} ',
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black),
        ),
        body: SafeArea(
          child: (_.isLoading!.value && _.searchList.isEmpty)
              ? AnimatedList(
                  initialItemCount: 10,
                  itemBuilder: (context, index, animation) {
                    return SlideTransition(
                      position: animation.drive(Tween(
                          begin: const Offset(1, 0), end: const Offset(0, 0))),
                      child: Padding(
                        padding: EdgeInsets.all(2.w),
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 2,
                              crossAxisSpacing: 2,
                              childAspectRatio: 0.70,
                            ),
                            shrinkWrap: true,
                            itemCount: 10,
                            itemBuilder: (ctx, i) =>
                                const ProductCardShimmer()),
                      ),
                    );
                  })
              : (!_.isLoading!.value && _.searchList.isEmpty)
                  ? Center(
                      child: NormalText(
                          text: 'No result for ${_.key!.value}',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    )
                  : SizedBox(
                      height: 90.h,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 2,
                              crossAxisSpacing: 2,
                              childAspectRatio: 0.70,
                            ),
                            shrinkWrap: true,
                            itemCount: _.searchList.length,
                            itemBuilder: (ctx, i) {
                              return ProductCard(
                                item: _.searchList[i],
                                onTap: () {
                                  Get.to(() => DetailProductScreen(
                                        product: _.searchList[i],
                                      ));
                                },
                              );
                            }),
                      ),
                    ),
        ),
      );
    });
  }
}
