import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class ProductImage extends StatelessWidget {
  final double height;
  final double width;
  final int tag;
  final String url;

  const ProductImage({
    super.key,
    required this.height,
    required this.width,
    required this.tag,
    required this.url,
  });

  @override
  Widget build(BuildContext context) => Hero(
    tag: tag,
    child: ClipRect(
      child: ColoredBox(
        color: Colors.white,
        child: CachedNetworkImage(
          errorWidget: (context, url, error) => const Icon(Icons.error_outline),
          height: height,
          width: width,
          imageUrl: url,
          placeholder: (context, url) => const CircularProgressIndicator(),
        ),
      ),
    )
  );
}