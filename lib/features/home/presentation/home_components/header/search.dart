import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pos_application/core/common/colors.dart';
import 'package:pos_application/core/common/icon.dart';
import 'package:pos_application/core/images/image.dart';

final List<String> imgList = [
  'Order#',
  'Menu',
  'Customer',
];

final List<Widget> imageSliders = imgList
    .map((item) => Text(
          item,
          style: const TextStyle(fontSize: 14, color: AppColors.iconColor),
        ))
    .toList();

class VerticalSliderDemo extends StatelessWidget {
  const VerticalSliderDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 300,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: AppColors.iconColor.withOpacity(.15),
        ),
        color: AppColors.darkColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          const SizedBox(
            height: 17,
            child: CustomIcon(
              iconPath: AllIcons.search,
              size: 10,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const SizedBox(
            width: 50,
            child: Text(
              'Search',
              style: TextStyle(fontSize: 14, color: AppColors.iconColor),
            ),
          ),
          SizedBox(
            width: 100,
            child: CarouselSlider(
              disableGesture: true,
              options: CarouselOptions(
                aspectRatio: 1.0,
                animateToClosest: true,
                autoPlayCurve: Curves.linear,
                autoPlayAnimationDuration: const Duration(milliseconds: 120),
                enlargeCenterPage: true,
                scrollDirection: Axis.vertical,
                autoPlay: true,
              ),
              items: imageSliders,
            ),
          ),
        ],
      ),
    );
  }
}
