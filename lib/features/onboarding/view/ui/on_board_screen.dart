import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/common/color.dart';
import 'package:todo/features/landing/view/ui/landing_screen.dart';
import 'package:todo/features/onboarding/domain/data/on_board_data.dart';
import 'package:todo/features/onboarding/view/bloc/on_board_bloc.dart';
import 'package:todo/features/onboarding/view/widget/on_board_content.dart';

import '../widget/custom_button.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  //page controller initialization
  final PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OnBoardBloc, OnBoardState>(
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  PageView(
                    controller: _controller,
                    onPageChanged: (value) {
                      // state.pageIndex = value;
                      log("Page changed to: $value");
                      context.read<OnBoardBloc>().add(
                            OnPageChangedEvent(
                              pageIndex: value,
                            ),
                          );
                    },
                    children: onBoardModel
                        .map((e) => OnBoardContent(
                            image: e.image,
                            title: e.title,
                            description: e.description))
                        .toList(),
                  ),

                  //arrow icon and skip
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //finish button

                        //back arrow
                        GestureDetector(
                          onTap: (state.pageIndex > 0)
                              ? () {
                                  _controller.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              : null,
                          child: (state.pageIndex > 0)
                              ? const Icon(
                                  Icons.chevron_left,
                                  color: AppColor.backgroundColor,
                                )
                              : const Opacity(
                                  opacity: .5,
                                  child: Icon(
                                    Icons.chevron_left,
                                    color: AppColor.backgroundColor,
                                  ),
                                ),
                        ),
                        //skip
                        // TextButton(
                        //   onPressed: () {},
                        //   child: const Text('Skip'),
                        // ),
                      ],
                    ),
                  ),

                  //next button
                  Positioned(
                    bottom: 20,
                    left: 50,
                    right: 50,
                    child: GestureDetector(
                      onTap: () {
                        if (state.pageIndex < onBoardModel.length - 1) {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          context
                              .read<OnBoardBloc>()
                              .add(NavigateToLandingPageEvent());
                        }
                      },
                      child: CustomButton(
                        text: (state.pageIndex < onBoardModel.length - 1)
                            ? 'Next'
                            : 'Finish',
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is NavigateToLandingPageState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LandingScreen(),
              ),
            );
          }
        },
      ),
    );
  }
}
