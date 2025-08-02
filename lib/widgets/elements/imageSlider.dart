import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nivaas/core/constants/img_consts.dart';

class ImageSlider extends StatelessWidget {
  final List<String> imageList = [
    slider1,
    slider2,
    slider3,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: CarouselSlider.builder(
        itemCount: imageList.length,
        itemBuilder: (context, index, realIndex) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imageList[index],
              fit: BoxFit.cover,
              cacheWidth: 800,
              cacheHeight: 450,
            ),
          );
        },
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          aspectRatio: 16 / 9,
          viewportFraction: 0.95,
          autoPlayCurve: Curves.easeInOut,
          autoPlayInterval: Duration(seconds: 2),
          autoPlayAnimationDuration: Duration(milliseconds: 500),
          enableInfiniteScroll: true,
        ),
      ),
    );
  }
}
