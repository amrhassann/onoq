import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/custom_shimmer.dart';

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomShimmer(height: 160, width: 200),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomShimmer(
                      height: 12.sp,
                      width: 60.sp,
                    ),
                    SizedBox(height: 1.5.h),
                    CustomShimmer(
                      height: 12.sp,
                      width: 90.sp,
                    ),
                    SizedBox(height: 1.5.h),
                    CustomShimmer(
                      height: 12.sp,
                      width: 90.sp,
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
