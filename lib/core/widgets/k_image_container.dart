import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

enum ImageType { network, file, asset }

class KImageContainer extends StatelessWidget {
  final ImageType? imageType;
  final String? imageUrl;
  final File? imageFile;
  final double? height;
  final double? width;
  final double? radius;
  final double? padding;
  final String? fallBackText;
  final bool? hasBorder;
  final BoxFit? imageFit;
  final Color? borderClr;
  const KImageContainer({
    Key? key,
    this.imageType = ImageType.asset,
    this.imageUrl,
    this.imageFile,
    this.height,
    this.width,
    this.radius,
    this.padding,
    this.fallBackText,
    this.hasBorder = false,
    this.imageFit,
    this.borderClr,
  }) :
        // assert(
        //         ((imageType == ImageType.file && imageFile != null) ||
        //             (imageType == ImageType.network && imageUrl != null) ||
        //             (imageType == ImageType.asset && imageUrl != null)),
        //       ),
        super(key: key);

  checkImageTypeForAssert() {
    switch (imageType) {
      case ImageType.network:
        return imageUrl != null;
      case ImageType.file:
        return imageFile != null;
      case ImageType.asset:
        return imageUrl != null;
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(radius ?? 20.r),
      child: Container(
        height: height,
        // padding: EdgeInsets.all(padding ?? 15.w),
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(radius ?? 20.r),
          border: hasBorder == true
              ? Border.all(
                  color: borderClr ?? KColors.primary,
                  width: 2,
                )
              : Border.all(
                  color: borderClr ?? Colors.grey.shade100,
                  width: 0,
                ),
        ),
        // child: buildNetworkImage(),
        child: buildImage(imageType),
      ),
    );
  }

  buildImage(ImageType? type) {
    switch (type) {
      case ImageType.network:
        return buildNetworkImage();
      case ImageType.file:
        return buildFileImage();
      case ImageType.asset:
        return buildAssetImage();
      default:
        return buildErrorWidget();
    }
  }

  // file image builder
  Image buildAssetImage() {
    return Image.asset(
      imageUrl ?? '',
      fit: imageFit ?? BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return buildErrorWidget();
      },
    );
  }

  // file image builder
  Image buildFileImage() {
    return Image.file(
      imageFile ?? File(''),
      fit: imageFit ?? BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return buildErrorWidget();
      },
    );
  }

  // network image builder
  CachedNetworkImage buildNetworkImage() {
    return CachedNetworkImage(
      imageUrl: imageUrl ?? '',
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            scale: 1.0,
            fit: imageFit ?? BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => const Center(
        child: CupertinoActivityIndicator(),
      ),
      errorWidget: (context, url, error) {
        return buildErrorWidget();
      },
    );
  }

  // error widget
  Center buildErrorWidget() {
    return Center(
      child: Text(
        fallBackText ?? 'Image not loaded!',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 10.sp,
        ),
      ),
    );
  }
}
