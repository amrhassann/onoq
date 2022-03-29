import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../data/model/cart_model.dart';
import '../../data/model/product_detail_model.dart';
import '../../data/model/product_model.dart';
import '../../utils/helpers.dart';
import '../../utils/styles.dart';
import '../cart/cart_screen.dart';
import '../cart/controllers/cart_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import 'checkout_result_page.dart';
import 'controllers/product_controller.dart';

class DetailProductScreen extends StatefulWidget {
  final Product product;
  const DetailProductScreen({Key? key, required this.product})
      : super(key: key);

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  int? _currentIndex = 0;
  final CartController _cartController = Get.put(CartController());
  @override
  void initState() {
    _cartController.getCart();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: NormalText(
            text: 'Detail Product',
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: Colors.black),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Center(
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
                      position: BadgePosition.topEnd(top: -4, end: 2),
                      child: IconButton(
                        icon: const Icon(
                          Icons.shopping_cart_outlined,
                          size: 32,
                        ),
                        onPressed: () {
                          Get.to(() => const CartScreen());
                        },
                      ));
                }),
              ))
        ],
      ),
      body: GetX<ProductController>(builder: (_) {
        DetailProduct detail = widget.product.detailProduct!;
        List<String?> imageList = [
          detail.prdImage01,
          detail.prdImage02,
          detail.prdImage03,
          detail.prdImage04,
        ];
        return SafeArea(
            child: _.isLoading!.value
                ? const Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.black)),
                  )
                : Stack(
                    children: [
                      SizedBox(
                        height: 100.h,
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            Stack(
                              children: [
                                CarouselSlider(
                                  options: CarouselOptions(
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          _currentIndex = index;
                                        });
                                      },
                                      height: 400.0,
                                      viewportFraction: 1),
                                  items: imageList.map((i) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: CachedNetworkImage(
                                            imageUrl: i!,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              width: 200,
                                              height: 160,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(
                                                                10)),
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                SizedBox(
                                              height: 160,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      const AlwaysStoppedAnimation<
                                                          Color>(Colors.black),
                                                  value:
                                                      downloadProgress.progress,
                                                ),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Image.asset(
                                              'assets/images/image_error.jpeg',
                                              height: 160,
                                              width: 200,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }).toList(),
                                ),
                                Positioned(
                                  top: 240.sp,
                                  right: 10.sp,
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle),
                                    child: NormalText(
                                        text:
                                            '${_currentIndex! + 1} / ${imageList.length} ',
                                        fontSize: 8.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                            Container(
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
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    NormalText(
                                        text: detail.prdNm,
                                        fontSize: 16.sp,
                                        maxLines: 3,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                    NormalText(
                                        text:
                                            '${detail.productOption!.stckQty!} Stock',
                                        fontSize: 10.sp,
                                        maxLines: 3,
                                        fontWeight: FontWeight.w400,
                                        color: ColorPalettes.greyLight),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    NormalText(
                                        text: Helper().formatRupiah(
                                            int.tryParse(detail.selPrc!)!),
                                        fontSize: 16.sp,
                                        maxLines: 2,
                                        fontWeight: FontWeight.w400,
                                        color: ColorPalettes.bluePrimary),
                                    SizedBox(height: 1.h),
                                    NormalText(
                                        text: 'Description Product',
                                        fontSize: 14.sp,
                                        maxLines: 3,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                    SizedBox(height: 1.h),
                                    Html(
                                      data: detail.htmlDetail!,
                                    ),
                                    SizedBox(height: 1.h),
                                    NormalText(
                                        text: 'Additional Information',
                                        fontSize: 14.sp,
                                        maxLines: 3,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                    SizedBox(height: 1.h),
                                    Html(
                                      data: detail.asDetail!,
                                    ),
                                    SizedBox(height: 1.h),
                                    NormalText(
                                        text: 'Delivery Service',
                                        fontSize: 14.sp,
                                        maxLines: 3,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                    SizedBox(height: 1.h),
                                    NormalText(
                                        text: _.deliveryList
                                            .where((element) =>
                                                element.dlvTmpltSeq ==
                                                detail.tmpltSeq)
                                            .first
                                            .dlvTmpltNm!,
                                        fontSize: 12.sp,
                                        maxLines: 3,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                    SizedBox(
                                      height: 12.h,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
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
                                    flex: 2,
                                    child: Center(
                                      child: GestureDetector(
                                        key: const Key('cartButtonDetail'),
                                        onTap: () {
                                          _.quantitySelectedProduct!.value = 1;
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return StatefulBuilder(builder:
                                                  (BuildContext context,
                                                      StateSetter setState) {
                                                return Container(
                                                  width: 100.w,
                                                  height: 40.h,
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black
                                                              .withOpacity(0.1),
                                                          spreadRadius: 5,
                                                          blurRadius: 7,
                                                          offset: const Offset(
                                                              0,
                                                              3), // changes position of shadow
                                                        ),
                                                      ]),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          NormalText(
                                                              text:
                                                                  'Add to cart',
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  Colors.black),
                                                          IconButton(
                                                              onPressed: () {
                                                                Get.back();
                                                              },
                                                              icon: const Icon(
                                                                  Icons.close)),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Flexible(
                                                            flex: 3,
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl: detail
                                                                  .prdImage01!,
                                                              imageBuilder:
                                                                  (context,
                                                                          imageProvider) =>
                                                                      Container(
                                                                width: 100,
                                                                height: 80,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius: const BorderRadius
                                                                          .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              10),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              10)),
                                                                  image:
                                                                      DecorationImage(
                                                                    image:
                                                                        imageProvider,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                              progressIndicatorBuilder:
                                                                  (context, url,
                                                                          downloadProgress) =>
                                                                      SizedBox(
                                                                height: 160,
                                                                child: Center(
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    valueColor: const AlwaysStoppedAnimation<
                                                                            Color>(
                                                                        Colors
                                                                            .black),
                                                                    value: downloadProgress
                                                                        .progress,
                                                                  ),
                                                                ),
                                                              ),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  Image.asset(
                                                                'assets/images/image_error.jpeg',
                                                                height: 160,
                                                                width: 200,
                                                              ),
                                                            ),
                                                          ),
                                                          Flexible(
                                                            flex: 8,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  NormalText(
                                                                      text: detail
                                                                          .prdNm,
                                                                      fontSize:
                                                                          10.sp,
                                                                      maxLines:
                                                                          2,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: Colors
                                                                          .black),
                                                                  NormalText(
                                                                      text: Helper().formatRupiah(int.tryParse(
                                                                          detail
                                                                              .selPrc!)!),
                                                                      fontSize:
                                                                          10.sp,
                                                                      maxLines:
                                                                          2,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: ColorPalettes
                                                                          .greyLight),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 100.w,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            NormalText(
                                                                text: 'Qty',
                                                                fontSize: 10.sp,
                                                                maxLines: 2,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black),
                                                            IconButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    _.decreaseQuantity();
                                                                  });
                                                                },
                                                                icon: const Icon(
                                                                    Icons
                                                                        .remove)),
                                                            NormalText(
                                                                text: _
                                                                    .quantitySelectedProduct
                                                                    .toString(),
                                                                fontSize: 10.sp,
                                                                maxLines: 2,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black),
                                                            IconButton(
                                                                key: const Key(
                                                                    'increaseQty'),
                                                                onPressed: () {
                                                                  setState(() {
                                                                    _.increaseQuantity();
                                                                  });
                                                                },
                                                                icon: const Icon(
                                                                    Icons
                                                                        .remove))
                                                          ],
                                                        ),
                                                      ),
                                                      CustomPrimaryButton(
                                                        key: const Key(
                                                            'addToCartButton'),
                                                        label: 'Add to cart',
                                                        onPressed: () async {
                                                          Get.back();
                                                          bool? result = await _cartController
                                                              .addItemToCart(CartModel(
                                                                  product: widget
                                                                      .product,
                                                                  quantity: _
                                                                      .quantitySelectedProduct!
                                                                      .value));
                                                          if (result!) {
                                                            Get.dialog(
                                                                Container(
                                                                  width: 100.w,
                                                                  margin: EdgeInsets.symmetric(
                                                                      vertical:
                                                                          180
                                                                              .sp,
                                                                      horizontal:
                                                                          40.sp),
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color: Colors
                                                                              .black
                                                                              .withOpacity(0.1),
                                                                          spreadRadius:
                                                                              5,
                                                                          blurRadius:
                                                                              7,
                                                                          offset: const Offset(
                                                                              0,
                                                                              3), // changes position of shadow
                                                                        ),
                                                                      ]),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      const Icon(
                                                                          Icons
                                                                              .check_circle_outline_outlined,
                                                                          size:
                                                                              100),
                                                                      NormalText(
                                                                          text:
                                                                              'Successfully added to cart',
                                                                          fontSize: 12
                                                                              .sp,
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          color:
                                                                              Colors.black)
                                                                    ],
                                                                  ),
                                                                ),
                                                                barrierDismissible:
                                                                    false);
                                                            Future.delayed(
                                                                const Duration(
                                                                    milliseconds:
                                                                        1000),
                                                                () {
                                                              Get.back();
                                                            });
                                                          } else {
                                                            Get.dialog(
                                                                Container(
                                                                  width: 100.w,
                                                                  margin: EdgeInsets.symmetric(
                                                                      vertical:
                                                                          180
                                                                              .sp,
                                                                      horizontal:
                                                                          40.sp),
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color: Colors
                                                                              .black
                                                                              .withOpacity(0.1),
                                                                          spreadRadius:
                                                                              5,
                                                                          blurRadius:
                                                                              7,
                                                                          offset: const Offset(
                                                                              0,
                                                                              3), // changes position of shadow
                                                                        ),
                                                                      ]),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      const Icon(
                                                                          Icons
                                                                              .clear_sharp,
                                                                          color: Colors
                                                                              .red,
                                                                          size:
                                                                              100),
                                                                      NormalText(
                                                                          text:
                                                                              'Already in cart',
                                                                          fontSize: 12
                                                                              .sp,
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          color:
                                                                              Colors.black)
                                                                    ],
                                                                  ),
                                                                ),
                                                                barrierDismissible:
                                                                    false);
                                                            Future.delayed(
                                                                const Duration(
                                                                    milliseconds:
                                                                        1000),
                                                                () {
                                                              Get.back();
                                                            });
                                                          }
                                                        },
                                                        type: ButtonType.large,
                                                        style: ButtonStyleFill
                                                            .outlined,
                                                        rounded: false,
                                                      )
                                                    ],
                                                  ),
                                                );
                                              });
                                            },
                                          );
                                        },
                                        child: const Icon(
                                            Icons.add_shopping_cart_sharp,
                                            size: 32),
                                      ),
                                    )),
                                Flexible(
                                  flex: 10,
                                  child: CustomPrimaryButton(
                                    key: const Key('buyNowButton'),
                                    label: 'Buy Now',
                                    rounded: false,
                                    type: ButtonType.large,
                                    onPressed: () {
                                      _.quantitySelectedProduct!.value = 1;
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return StatefulBuilder(builder:
                                              (BuildContext context,
                                                  StateSetter setState) {
                                            return Container(
                                              width: 100.w,
                                              height: 40.h,
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.1),
                                                      spreadRadius: 5,
                                                      blurRadius: 7,
                                                      offset: const Offset(0,
                                                          3), // changes position of shadow
                                                    ),
                                                  ]),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      NormalText(
                                                          text: 'Buy product',
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.black),
                                                      IconButton(
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          icon: const Icon(
                                                              Icons.close)),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Flexible(
                                                        flex: 3,
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: detail
                                                              .prdImage01!,
                                                          imageBuilder: (context,
                                                                  imageProvider) =>
                                                              Container(
                                                            width: 100,
                                                            height: 80,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius: const BorderRadius
                                                                      .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10)),
                                                              image:
                                                                  DecorationImage(
                                                                image:
                                                                    imageProvider,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                          progressIndicatorBuilder:
                                                              (context, url,
                                                                      downloadProgress) =>
                                                                  SizedBox(
                                                            height: 160,
                                                            child: Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                                valueColor:
                                                                    const AlwaysStoppedAnimation<
                                                                            Color>(
                                                                        Colors
                                                                            .black),
                                                                value:
                                                                    downloadProgress
                                                                        .progress,
                                                              ),
                                                            ),
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Image.asset(
                                                            'assets/images/image_error.jpeg',
                                                            height: 160,
                                                            width: 200,
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        flex: 8,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              NormalText(
                                                                  text: detail
                                                                      .prdNm,
                                                                  fontSize:
                                                                      10.sp,
                                                                  maxLines: 2,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .black),
                                                              NormalText(
                                                                  text: Helper().formatRupiah(
                                                                      int.tryParse(
                                                                          detail
                                                                              .selPrc!)!),
                                                                  fontSize:
                                                                      10.sp,
                                                                  maxLines: 2,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: ColorPalettes
                                                                      .greyLight),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 100.w,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        NormalText(
                                                            text: 'Qty',
                                                            fontSize: 10.sp,
                                                            maxLines: 2,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Colors.black),
                                                        IconButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                _.decreaseQuantity();
                                                              });
                                                            },
                                                            icon: const Icon(
                                                                Icons.remove)),
                                                        NormalText(
                                                            text: _
                                                                .quantitySelectedProduct
                                                                .toString(),
                                                            fontSize: 10.sp,
                                                            maxLines: 2,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Colors.black),
                                                        IconButton(
                                                            key: const Key(
                                                                'increaseQtyBuy'),
                                                            onPressed: () {
                                                              setState(() {
                                                                _.increaseQuantity();
                                                              });
                                                            },
                                                            icon: const Icon(
                                                                Icons.remove))
                                                      ],
                                                    ),
                                                  ),
                                                  CustomPrimaryButton(
                                                    key: const Key(
                                                        'checkoutNow'),
                                                    label: 'Checkout now',
                                                    onPressed: () {
                                                      Get.back();
                                                      Get.to(() =>
                                                          const CheckoutResultPage(
                                                            result:
                                                                CheckoutResult
                                                                    .success,
                                                          ));
                                                    },
                                                    type: ButtonType.large,
                                                    style: ButtonStyleFill
                                                        .outlined,
                                                    rounded: false,
                                                  )
                                                ],
                                              ),
                                            );
                                          });
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ]),
                        ),
                      )
                    ],
                  ));
      }),
    );
  }
}
