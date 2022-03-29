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

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: SizedBox(
        width: 100.w,
        height: 100.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        height: 24.sp,
                        // key: const Key('iconImage'),
                      ),
                      Center(
                        child: GetX<CartController>(builder: (cartController) {
                          return Badge(
                              badgeContent: NormalText(
                                  text:
                                      cartController.cartList.length.toString(),
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                              animationType: BadgeAnimationType.fade,
                              animationDuration:
                                  const Duration(milliseconds: 300),
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
                  SizedBox(height: 2.h),
                  Container(
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          color: ColorPalettes.greyLight.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(50)),
                      child: TextField(
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
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12.sp, vertical: 12.sp),
                            border: InputBorder.none,
                            hintText: 'Search...',
                            suffixIcon: GestureDetector(
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
                  NormalText(
                      text: 'Best Products For You',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ],
              ),
            ),
            Flexible(
                flex: 11,
                child: GetX<ProductController>(
                    init: ProductController(),
                    builder: (_) {
                      return Container(
                        height: 150.h,

                        child: RefreshIndicator(
                          onRefresh: () async {
                            return delayShimmer();
                          },
                          color: Colors.black,
                          child: _.isLoading!.value && !_.isLoadMore!.value
                              ? AnimatedList(
                                  initialItemCount: 10,
                                  itemBuilder: (context, index, animation) {
                                    return SlideTransition(
                                      position: animation.drive(Tween(
                                          begin: const Offset(1, 0),
                                          end: const Offset(0, 0))),
                                      child: Padding(
                                        padding: EdgeInsets.all(2.w),
                                        child: GridView.builder(
                                            physics:
                                                const BouncingScrollPhysics(),
                                            key: const Key('gridViewShimmer'),
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              mainAxisSpacing: 2,
                                              crossAxisSpacing: 2,
                                              childAspectRatio: 0.68,
                                            ),
                                            shrinkWrap: true,
                                            itemCount: 10,
                                            itemBuilder: (ctx, i) =>
                                                const ProductCardShimmer()),
                                      ),
                                    );
                                  })
                              : Container(
                                  height: 40.h,
                                  width: 200.w,
                                  child: ListView.separated(
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
                        ),
                      );
                    })),
          ],
        ),
      ),
    ))));
  }
}
