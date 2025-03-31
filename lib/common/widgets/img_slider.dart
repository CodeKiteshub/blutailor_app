import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:sizer/sizer.dart';

class ImgSlider extends StatefulWidget {
  final List<String> imgList;
  final double height;
  const ImgSlider({super.key, required this.imgList, required this.height});

  @override
  State<ImgSlider> createState() => _ImgSliderState();
}

class _ImgSliderState extends State<ImgSlider> {
  final CarouselSliderController _controller = CarouselSliderController();



  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: widget.imgList.map((item) {
        return CachedNetworkImage(
          imageUrl: 
          item,
          // fit: BoxFit.fill,
          width: 100.w,
        );
      }).toList(),
      controller: _controller,
      options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 1,
          height: widget.height,
          aspectRatio: 2.0,
          onPageChanged: (index, reason) {
          
          }),
    );
  }
}