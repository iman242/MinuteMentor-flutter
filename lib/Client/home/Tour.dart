import 'package:codebooter_study_app/utils/Dimensions.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_controller.dart' as carousel_slider;
import 'package:go_router/go_router.dart';

class CarouselScreen extends StatefulWidget {
  const CarouselScreen({Key? key}) : super(key: key);

  @override
  _CarouselScreenState createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen> {
  final List<String> imagePaths = [
    'assets/images/tour1.png',
    'assets/images/tour2.png',
    'assets/images/tour3.png',
  ];

  int currentIndex = 0;
  final carousel_slider.CarouselController _carouselController = 
      carousel_slider.CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            top: 10, // Distance added at the top
            child: CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                enableInfiniteScroll: false,
                autoPlayInterval: const Duration(seconds: 2),
                height: dimension.screenHeight * 0.8, // Adjusted image height
                autoPlay: false,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                  if (index == imagePaths.length - 1) {
                    Future.delayed(const Duration(seconds: 1), () {
                      GoRouter.of(context).go('/log');
                    });
                  }
                },
              ),
              items: imagePaths.map((path) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Image.asset(
                        path,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          Positioned(
            top: dimension.height100,
            right: dimension.width50,
            child: InkWell(
              onTap: () {
                final int nextIndex = currentIndex + 1;
                if (nextIndex < imagePaths.length) {
                  setState(() {
                    currentIndex = nextIndex;
                  });
                  _carouselController.animateToPage(nextIndex);
                } else {
                  GoRouter.of(context).go('/log');
                }
              },
              child: Container(
                padding: EdgeInsets.only(left: dimension.width10),
                child: Text(
                  currentIndex == imagePaths.length - 1 ? 'Finish' : 'Next',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 80, 80, 81),
                    fontSize: dimension.font24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: dimension.height50,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imagePaths.map((url) {
                int index = imagePaths.indexOf(url);
                return Container(
                  width: dimension.width10,
                  height: dimension.height10,
                  margin: EdgeInsets.symmetric(
                    vertical: dimension.height10,
                    horizontal: dimension.width5,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex == index
                        ? const Color.fromARGB(255, 0, 0, 0)
                        : const Color.fromARGB(255, 200, 200, 200),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}