import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:food_app/functionalities/home/widget/cards/card1.dart';
import 'package:food_app/functionalities/home/widget/cards/card2.dart';
import 'package:food_app/functionalities/home/widget/cards/card3.dart';

class CarouselCards extends StatelessWidget {
  const CarouselCards({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return CarouselSlider(
      options: CarouselOptions(
        animateToClosest: true,
        scrollPhysics: const BouncingScrollPhysics(),
        pageSnapping: true,
        autoPlay: true,
        aspectRatio: 1,
        height: height / 4.5,
        enlargeCenterPage: true,
        autoPlayCurve: Curves.easeInOutCubic,
      ),
      disableGesture: false,
      items: const [Card1(), Card2(), Card3()],
    );
  }
}
