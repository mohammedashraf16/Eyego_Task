import 'package:cached_network_image/cached_network_image.dart';
import 'package:eyego_task/core/utils/app_colors.dart';
import 'package:eyego_task/features/products/data/models/sub_models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomListViewItem extends StatelessWidget {
  const CustomListViewItem({super.key, required this.product});

  final Products? product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 1.0),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.kBordersideColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(8.r),
          leading: product?.thumbnail != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: CachedNetworkImage(
                    width: 100.w,
                    height: 100.h,
                    imageUrl: product!.thumbnail!,
                    placeholder: (context, url) =>
                        Container(color: Colors.grey[300]),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                )
              : Container(width: 100.w, height: 100.h, color: Colors.grey[300]),
          title: Text(
            product?.title ?? 'Title Placeholder',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4.h),
              if (product?.category != null)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: AppColors.kPrimaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    product!.category!,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.kPrimaryColor,
                    ),
                  ),
                ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Text(
                    '\$${product?.price ?? '00.00'}',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                  const Spacer(),
                  if (product?.rating != null)
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16.sp),
                        SizedBox(width: 4.w),
                        Text(
                          product!.rating!.toStringAsFixed(1),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
