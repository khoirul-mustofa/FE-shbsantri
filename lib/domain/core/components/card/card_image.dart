import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:santrihub/infrastructure/theme/style/style.dart';

import '../../../../infrastructure/theme/color/colors.dart';
import '../../../../infrastructure/theme/theme.dart';

class CardImage extends StatelessWidget {
  const CardImage.circle({
    Key? key,
    this.image,
    this.size = 26,
    this.isCircle = true,
  }) : super(key: key);

  const CardImage.rectangle({
    Key? key,
    this.image,
    this.size = 26,
    this.isCircle = false,
  }) : super(key: key);

  final String? image;
  final double size;
  final bool isCircle;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      cacheManager: CacheManager(
          Config('images_key', maxNrOfCacheObjects: 20, stalePeriod: 3.days)),
      imageUrl: image ?? '',
      imageBuilder: (context, imageProvider) {
        return isCircle
            ? _imageCircle(imageProvider)
            : _imageRectangle(imageProvider);
      },
      placeholder: (context, url) =>
          isCircle ? _circlePlaceholder : _rectanglePlaceholder,
      errorWidget: (context, url, error) =>
          isCircle ? _circleError : _rectangleError,
    );
  }

  Widget _imageCircle(ImageProvider<Object> imageProvider) {
    return CircleAvatar(
      radius: size.r,
      backgroundColor: Colors.blueGrey,
      backgroundImage: imageProvider,
    );
  }

  Widget get _circleError {
    return CircleAvatar(
      radius: size.r,
      backgroundColor: kErrorColor.withOpacity(0.2),
      child: Center(
        child: Icon(
          Icons.error,
          color: kErrorColor,
          size: (size - 6).r,
        ),
      ),
    );
  }

  Widget get _circlePlaceholder {
    return CircleAvatar(
      radius: size.r,
      backgroundColor: Colors.white,
      child: const Center(
        child: CupertinoActivityIndicator(color: kPrimaryAccentColor),
      ),
    );
  }

  Widget _imageRectangle(ImageProvider<Object> imageProvider) {
    return LayoutBuilder(builder: (_, constrain) {
      return ClipRRect(
        borderRadius: constrain.maxWidth < 600
            ? theme.style.borderRadius.allLarge
            : theme.style.borderRadius.allSmall,
        child: Image(
          image: imageProvider,
          width: size.r,
          height: size.r,
          fit: BoxFit.cover,
        ),
      );
    });
  }

  Widget get _rectanglePlaceholder {
    return Container(
      width: size.r,
      height: size.r,
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: theme.style.borderRadius.allSmall,
      ),
      child: const Center(
        child: CupertinoActivityIndicator(color: kPrimaryAccentColor),
      ),
    );
  }

  Widget get _rectangleError {
    return Container(
      width: size.r,
      height: size.r,
      decoration: BoxDecoration(
        color: kErrorColor.withOpacity(0.2),
        borderRadius: theme.style.borderRadius.allSmall,
      ),
      child: Center(
        child: Icon(
          Icons.error,
          color: kErrorColor,
          size: (size - 12).r,
        ),
      ),
    );
  }
}
