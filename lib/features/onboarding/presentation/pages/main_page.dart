import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding/index.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  static const _stackPadding = EdgeInsets.only(left: 24, bottom: 42, right: 23);
  static const _mediumSpacing = 16.0;
  static const _pagesCount = 4;
  static const _indicatorDotSize = 8.0;
  static const _buttonSize = 58.0;
  static const _animationDuration = 500;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _pageController = PageController();
  final OnboardingCubit _cubit = OnboardingCubit();

  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      bloc: _cubit,
      builder: (context, state) {
        return state.when(
          scrollable: () {
            return Stack(
              alignment: Alignment.bottomLeft,
              children: [
                PageView(
                  controller: _pageController,
                  children: [
                    OnboardingPage(
                      backgroundColor: AppColors.yellow,
                      title: AppLocalizations.of(context)!.firstTitle,
                      text: AppLocalizations.of(context)!.firstText,
                      image: Assets.images.imgCar1.provider(),
                    ),
                    OnboardingPage(
                      backgroundColor: AppColors.purple,
                      title: AppLocalizations.of(context)!.secondTitle,
                      text: AppLocalizations.of(context)!.secongText,
                      image: Assets.images.imgCar2.provider(),
                    ),
                    OnboardingPage(
                      backgroundColor: AppColors.orange,
                      title: AppLocalizations.of(context)!.thirdTitle,
                      text: AppLocalizations.of(context)!.thirdText,
                      image: Assets.images.imgCar3.provider(),
                    ),
                    OnboardingPage(
                      backgroundColor: AppColors.blue,
                      title: AppLocalizations.of(context)!.forthTitle,
                      text: AppLocalizations.of(context)!.forthText,
                      image: Assets.images.imgCar4.provider(),
                    ),
                  ],
                ),
                Padding(
                  padding: MainPage._stackPadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SmoothPageIndicator(
                            controller: _pageController,
                            count: MainPage._pagesCount,
                            effect: const ExpandingDotsEffect(
                              activeDotColor: AppColors.white,
                              dotColor: AppColors.white40,
                              dotWidth: MainPage._indicatorDotSize,
                              dotHeight: MainPage._indicatorDotSize,
                            ),
                          ),
                          const SizedBox(height: MainPage._mediumSpacing),
                          TextButton(
                            style: const ButtonStyle(
                              alignment: Alignment.centerLeft,
                              minimumSize: WidgetStatePropertyAll(Size.zero),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              padding: WidgetStatePropertyAll(EdgeInsets.zero),
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                            ),
                            onPressed: () => _cubit.setLastState(),
                            child: Text(
                              AppLocalizations.of(context)!.skip,
                              style: AppTextStyles.buttonStyle,
                            ),
                          ),
                        ],
                      ),
                      FutureBuilder(
                        future: initializeController(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return SizedBox(
                              width: MainPage._buttonSize,
                              height: MainPage._buttonSize,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    if (_pageController.page! != 3) {
                                      _pageController.nextPage(
                                        duration: const Duration(
                                          milliseconds:
                                              MainPage._animationDuration,
                                        ),
                                        curve: Curves.linear,
                                      );
                                    } else {
                                      _cubit.setLastState();
                                    }
                                  },
                                  child: CustomPaint(
                                    painter: ArrowButtonPainter(
                                      _pageController.page! + 1,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            );
          },
          last: () {
            return Scaffold(
              backgroundColor: AppColors.blue,
              body: Center(
                child: Text(
                  AppLocalizations.of(context)!.lastTitle,
                  style: AppTextStyles.lastPageTextStyle,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<bool> initializeController() {
    Completer<bool> completer = Completer<bool>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      completer.complete(true);
    });

    return completer.future;
  }
}
