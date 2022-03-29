import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onoq/modules/product/search_result_screen.dart';
import 'package:onoq/modules/product/widgets/product_card.dart';
import 'package:onoq/modules/product/widgets/product_card_shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../data/service/network/connectivity_helper.dart';
import '../../utils/styles.dart';
import '../cart/cart_screen.dart';
import '../cart/controllers/cart_controller.dart';
import '../widgets/custom_text.dart';
import 'controllers/product_controller.dart';
import 'detail_product_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductHomeScreen extends StatefulWidget {
  const ProductHomeScreen({Key? key}) : super(key: key);

  @override
  State<ProductHomeScreen> createState() => _ProductHomeScreenState();
}

class _ProductHomeScreenState extends State<ProductHomeScreen> {
  final ConnectivityHelper _connectivity = ConnectivityHelper();
  final ProductController _controller = Get.put(ProductController());
  final CartController _cartController = Get.put(CartController());
  String searchKey = '';
  TextEditingController tSearch = TextEditingController();
  String hintSearch = "Cari...";
  int page = 1;
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    _connectivity.init(context);
    _cartController.getCart();
    delayShimmer();
    super.initState();
  }

  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          if (!_controller.isLoadMore!.value && !_controller.isLoading!.value) {
            page++;
            _controller.getMoreProduct(tSearch.text, page);
          }
        }
      }
    });
  }

  void delayShimmer() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      _controller.getProducts(1, true);
    } else {
      _controller.getProducts(1, false);
    }
  }

  List<String> sliderImages = [
    'assets/images/banner.jpg',
    'assets/images/banner2.jpg',
    'assets/images/banner3.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Image.asset('assets/images/logo.png'),
          ),
          actions: [
            Center(
              child: GetX<CartController>(builder: (cartController) {
                return Badge(
                    badgeContent: NormalText(
                        text: cartController.cartList.length.toString(),
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                    animationType: BadgeAnimationType.fade,
                    animationDuration: const Duration(milliseconds: 300),
                    badgeColor: Colors.white,
                    key: const Key('badgeCart'),
                    position: BadgePosition.topEnd(top: -4, end: 2),
                    child: IconButton(
                      key: const Key('iconCart'),
                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                        size: 32,
                      ),
                      onPressed: () {
                        Get.to(() => const CartScreen());
                      },
                    ));
              }),
            )
          ],
        ),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    textDirection: TextDirection.rtl,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 2.h),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: ColorPalettes.greyLight.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(50)),
                          child: TextField(
                            textDirection: TextDirection.rtl,
                            controller: tSearch,
                            textInputAction: TextInputAction.search,
                            onSubmitted: (value) async {
                              if (value.isNotEmpty) {
                                _controller.searchProduct(value);
                                Get.to(() => const SearchResultScreen());
                              }
                            },
                            key: const Key('searchTextField'),
                            decoration: InputDecoration(
                                hintTextDirection: TextDirection.rtl,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15.sp, vertical: 12.sp),
                                border: InputBorder.none,
                                hintText: 'بحث عن منتج',
                                prefixIcon: GestureDetector(
                                  onTap: () {
                                    if (tSearch.text.isNotEmpty) {
                                      _controller.searchProduct(tSearch.text);
                                    }

                                    Get.to(() => const SearchResultScreen());
                                  },
                                  child: const Icon(Icons.search,
                                      key: Key('searchIcon'),
                                      color: ColorPalettes.greyLight),
                                ),
                                hintStyle: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: ColorPalettes.greyLight)),
                          )),
                      SizedBox(height: 2.h),
                    ],
                  ),
                  CarouselSlider(
                    options: CarouselOptions(
                      reverse: true,
                      height: deviceHeight * .25,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                    ),
                    items: sliderImages.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Image.asset(i),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: NormalText(
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            text: 'الأصناف',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  Container(
                    height: deviceHeight * .17,
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        reverse: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, i) => Container(

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        AssetImage(sliderImages[0]),
                                  ),
                                  NormalText(
                                    textAlign: TextAlign.center,
                                      maxLines: 2,
                                      text: 'العنايه بالبشرة',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: ColorPalettes.blue),
                                ],
                              ),
                            ),
                        separatorBuilder: (_, i) => Container(
                              width: 3.w,
                            ),
                        itemCount: 10),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: NormalText(
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            text: 'أجدد المنتجات',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  GetX<ProductController>(
                      init: ProductController(),
                      builder: (_) {
                        return RefreshIndicator(
                          onRefresh: () async {
                            return delayShimmer();
                          },
                          color: Colors.black,
                          child: _.isLoading!.value && !_.isLoadMore!.value
                              ? SizedBox(
                                  height: 40.h,
                                  width: 200.w,
                                  child: AnimatedList(
                                      scrollDirection: Axis.horizontal,
                                      initialItemCount: 3,
                                      itemBuilder: (context, index, animation) {
                                        return SlideTransition(
                                          position: animation.drive(Tween(
                                              begin: const Offset(1, 0),
                                              end: const Offset(0, 0))),
                                          child: Padding(
                                            padding: EdgeInsets.all(2.w),
                                            child: Container(
                                              height: 40.h,
                                              width: 200.w,
                                              child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  key: const Key(
                                                      'gridViewShimmer'),
                                                  shrinkWrap: true,
                                                  itemCount: 3,
                                                  itemBuilder: (ctx, i) =>
                                                      const ProductCardShimmer()),
                                            ),
                                          ),
                                        );
                                      }),
                                )
                              : SizedBox(
                                  height: 40.h,
                                  width: 200.w,
                                  child: ListView.separated(
                                      reverse: true,
                                      scrollDirection: Axis.horizontal,
                                      separatorBuilder: (_, index) =>
                                          const Divider(),
                                      physics: const BouncingScrollPhysics(),
                                      key: const Key('gridViewProduct'),
                                      controller: scrollController,
                                      shrinkWrap: true,
                                      itemCount: _.products.length,
                                      itemBuilder: (ctx, i) {
                                        return ProductCard(
                                          key: Key('productCard$i'),
                                          item: _.products[i],
                                          onTap: () {
                                            Get.to(() => DetailProductScreen(
                                                  product: _.products[i],
                                                ));
                                          },
                                        );
                                      }),
                                ),
                        );
                      }),

                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: NormalText(
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            text: 'الأكثر طلباً',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  GetX<ProductController>(
                      init: ProductController(),
                      builder: (_) {
                        return RefreshIndicator(
                          onRefresh: () async {
                            return delayShimmer();
                          },
                          color: Colors.black,
                          child: _.isLoading!.value && !_.isLoadMore!.value
                              ? SizedBox(
                            height: 40.h,
                            width: 200.w,
                            child: AnimatedList(
                                scrollDirection: Axis.horizontal,
                                initialItemCount: 3,
                                itemBuilder: (context, index, animation) {
                                  return SlideTransition(
                                    position: animation.drive(Tween(
                                        begin: const Offset(1, 0),
                                        end: const Offset(0, 0))),
                                    child: Padding(
                                      padding: EdgeInsets.all(2.w),
                                      child: Container(
                                        height: 40.h,
                                        width: 200.w,
                                        child: ListView.builder(
                                            scrollDirection:
                                            Axis.horizontal,
                                            physics:
                                            const BouncingScrollPhysics(),
                                            key: const Key(
                                                'gridViewShimmer'),
                                            shrinkWrap: true,
                                            itemCount: 3,
                                            itemBuilder: (ctx, i) =>
                                            const ProductCardShimmer()),
                                      ),
                                    ),
                                  );
                                }),
                          )
                              : SizedBox(
                            height: 40.h,
                            width: 200.w,
                            child: ListView.separated(
                                reverse: true,
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (_, index) =>
                                const Divider(),
                                physics: const BouncingScrollPhysics(),
                                key: const Key('gridViewProduct'),
                                controller: scrollController,
                                shrinkWrap: true,
                                itemCount: _.products.length,
                                itemBuilder: (ctx, i) {
                                  return ProductCard(
                                    key: Key('productCard$i'),
                                    item: _.products[i],
                                    onTap: () {
                                      Get.to(() => DetailProductScreen(
                                        product: _.products[i],
                                      ));
                                    },
                                  );
                                }),
                          ),
                        );
                      }),
                ],
              ),
            )));
  }
}
