import 'package:bluetailor_app/core/theme/app_strings.dart';
import 'package:bluetailor_app/features/custom_made/domain/entities/product_entities.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/app_colors.dart';

class ProductBox extends StatelessWidget {
  final ProductEntities? product;
  const ProductBox({
    super.key,
    this.product,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (product != null) {
          Navigator.pushNamed(context, "/product-details", arguments: product);
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                spreadRadius: 0,
                blurRadius: 4,
                offset: const Offset(0, 4),
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                    child: CachedNetworkImage(imageUrl: product?.images.firstOrNull ?? emtyImage,)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product?.title ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                        color: surfaceBlack),
                  ),
                  Text(
                   "₹${product?.price ?? ""}",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                        color: surfaceBlack),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
