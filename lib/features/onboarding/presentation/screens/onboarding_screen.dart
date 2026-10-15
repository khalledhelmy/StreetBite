import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:street_bite/core/constants/app_assets.dart';
import 'package:street_bite/core/widgets/spacing_widgets.dart';
import 'package:street_bite/features/onboarding/presentation/widgets/custom_next_button.dart';
import 'package:street_bite/features/onboarding/presentation/widgets/custom_skip_button.dart';
import 'package:street_bite/features/onboarding/presentation/widgets/get_started_button.dart';
import 'package:street_bite/features/onboarding/presentation/widgets/onboarding_page_content.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<String> titles = [
    'onboarding.title1'.tr(),
    'onboarding.title2'.tr(),
    'onboarding.title3'.tr(),
  ];
  List<String> subtitles = [
    'onboarding.subtitle1'.tr(),
    'onboarding.subtitle2'.tr(),
    'onboarding.subtitle3'.tr(),
  ];
  List<String> images = [
    AppAssets.onboarding1,
    AppAssets.onboarding2,
    AppAssets.onboarding3,
  ];

  int _currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HeightSpace(120),
            CarouselSlider(
              carouselController: _carouselController,
              items: List.generate(titles.length, (index) {
                return OnboardingPageContent(
                  title: titles[index],
                  subtitle: subtitles[index],
                  image: images[index],
                );
              }),
              options: CarouselOptions(
                height: 410.h,
                viewportFraction: 1,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  _currentIndex = index;
                  setState(() {});
                },
              ),
            ),
            HeightSpace(24),
            DotsIndicator(
              dotsCount: 3,
              position: _currentIndex.toDouble(),
              decorator: DotsDecorator(
                size: Size(8.sp, 8.sp),
                activeSize: Size(24.sp, 8.sp),
                color: Theme.of(
                  context,
                ).colorScheme.inverseSurface.withAlpha(100),
                activeColor: Theme.of(context).colorScheme.primary,
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onTap: (position) {
                _carouselController.jumpToPage(position);
              },
            ),
            Spacer(),
            _currentIndex >= 2
                ? GetStartedButton()
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomSkipButton(),
                        CustomNextButton(
                          onTap: () {
                            if (_currentIndex < 2) {
                              _currentIndex++;
                              _carouselController.animateToPage(
                                _currentIndex.toInt(),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
            HeightSpace(24),
          ],
        ),
      ),
    );
  }
}
