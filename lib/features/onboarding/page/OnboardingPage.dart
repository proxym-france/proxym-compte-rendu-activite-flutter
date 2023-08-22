import 'dart:ui';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mycra_timesheet_app/core/route/router_notifier.dart';
import 'package:mycra_timesheet_app/features/onboarding/widget/image_onboarding.dart';

class OnBoardingPage extends ConsumerStatefulWidget {
  OnBoardingPage({super.key});

  late int _selectedPage;
  late PageController _pageController;

  @override
  ConsumerState<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends ConsumerState<OnBoardingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget._selectedPage = 0;
    widget._pageController = PageController(viewportFraction: 1.1);
  }

  @override
  void didUpdateWidget(OnBoardingPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget._selectedPage = oldWidget._selectedPage;
    widget._pageController = oldWidget._pageController;
  }

  @override
  Widget build(BuildContext context) {
    final routerNotifier = ref.read(goRouterNotifierProvider.notifier);
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    var textTheme = Theme.of(context).textTheme;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/rm222-mind-14.jpg'), fit: BoxFit.cover)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: SafeArea(
            child: AdaptiveLayout(
              bottomNavigation: SlotLayout(
                config: {
                  Breakpoints.smallMobile: SlotLayout.from(
                    key: const Key('Key Navigation'),
                    builder: (context) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DotsIndicator(
                          position: widget._selectedPage % 3,
                          dotsCount: 3,
                          onTap: (position) => widget._pageController.animateToPage(
                            position,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeIn,
                          ),
                          decorator: DotsDecorator(
                              activeSize: const Size(36, 8),
                              size: const Size(36, 8),
                              activeColor: colorScheme.primary,
                              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4, left: 32.0, right: 32),
                          child: Row(
                            children: [
                              if (widget._selectedPage < 2)
                                TextButton(
                                  onPressed: () {},
                                  child: const Text('skip'),
                                ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      onNextClicked(context, routerNotifier);
                                    });
                                  },
                                  child: const Text('next'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Breakpoints.mediumAndUp: null
                },
              ),
              body: SlotLayout(
                config: {
                  Breakpoints.smallAndUp: SlotLayout.from(
                    key: const Key("Adaptive Body"),
                    builder: (context) => Column(
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: PageView.builder(
                              itemCount: 3,
                              controller: widget._pageController,
                              onPageChanged: (value) => setState(() {
                                    widget._selectedPage = value;
                                  }),
                              itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.only(top: 16.0, right: 32, left: 32),
                                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                      ImageOnboarding(url: 'https://source.unsplash.com/850x1200?professional?$index'),
                                      SizedBox(
                                        height: size.height * .075,
                                      ),
                                      Text(
                                        "Operations",
                                        style: Theme.of(context).textTheme.headlineLarge,
                                      ),
                                      Text(
                                        "Manage your timesheet and declare your leaves",
                                        style: Theme.of(context).textTheme.titleMedium,
                                        textAlign: TextAlign.center,
                                      ),
                                    ]),
                                  )),
                        ),
                      ],
                    ),
                  )
                },
              ),
              secondaryBody: SlotLayout(
                config: {
                  Breakpoints.smallDesktop: SlotLayout.from(
                    key: const Key("Adaptive Body"),
                    builder: (context) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: PageView.builder(
                              itemCount: 3,
                              controller: widget._pageController,
                              onPageChanged: (value) => setState(() {
                                    widget._selectedPage = value;
                                  }),
                              itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.only(top: 16.0),
                                    child: Center(
                                      child: Column(children: [
                                        ImageOnboarding(url: 'https://source.unsplash.com/850x1200?professional?$index'),
                                        SizedBox(
                                          height: size.height * .075,
                                        ),
                                        Text(
                                          "Operations",
                                          style: Theme.of(context).textTheme.headlineLarge,
                                        ),
                                        Text(
                                          "Manage your timesheet and declare your leaves",
                                          style: Theme.of(context).textTheme.titleMedium,
                                          textAlign: TextAlign.center,
                                        ),
                                      ]),
                                    ),
                                  )),
                        ),
                      ],
                    ),
                  ),
                  Breakpoints.mediumAndUp: SlotLayout.from(
                      key: const Key('dfgdfgdfdsfdsfds'),
                      builder: (context) => Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Welcome To MyCRA App',
                                style: textTheme.headlineLarge,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  DotsIndicator(
                                    position: widget._selectedPage % 3,
                                    dotsCount: 3,
                                    onTap: (position) => widget._pageController.animateToPage(
                                      position,
                                      duration: const Duration(milliseconds: 400),
                                      curve: Curves.easeIn,
                                    ),
                                    decorator: DotsDecorator(
                                        activeSize: const Size(36, 8),
                                        size: const Size(36, 8),
                                        activeColor: colorScheme.primary,
                                        activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 4, left: 32.0, right: 32),
                                    child: Row(
                                      children: [
                                        if (widget._selectedPage < 2)
                                          TextButton(
                                            onPressed: () {},
                                            child: const Text('skip'),
                                          ),
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                onNextClicked(context, routerNotifier);
                                              });
                                            },
                                            child: const Text('next'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ))
                },
              ),
            ),
          ),
        ),
      ),
    );

/*
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: PageView.builder(
                itemCount: 3,
                controller: widget._pageController,
                onPageChanged: (value) => setState(() {
                  widget._selectedPage = value;
                }),
                itemBuilder: (context, index) => OnBoardingPageViewItem(
                  index: index,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DotsIndicator(
                  position: widget._selectedPage % 3,
                  dotsCount: 3,
                  onTap: (position) => widget._pageController.animateToPage(
                    position,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeIn,
                  ),
                  decorator: DotsDecorator(
                      activeSize: const Size(36, 8),
                      size: const Size(36, 8),
                      activeColor: colorScheme.primary,
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
                SizedBox(
                  height: size.height * .02,
                ),
                if (size.height > 600)
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 4, left: 32.0, right: 32),
                    child: Row(
                      children: [
                        if (widget._selectedPage < 2)
                          TextButton(
                            onPressed: () {},
                            child: const Text('skip'),
                          ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                widget._pageController.nextPage(
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeIn);
                              });
                            },
                            child: const Text('next'),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
*/
  }

  void onNextClicked(BuildContext context, GoRouterNotifier routerNotifier) {
    if (widget._selectedPage < 2) {
      widget._pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
    }
  }
}

class OnBoardingPageViewItem extends StatelessWidget {
  final int index;

  const OnBoardingPageViewItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AdaptiveLayout(
      body: SlotLayout(
        config: {
          Breakpoints.small: SlotLayout.from(
            key: const Key("Onboard small"),
            builder: (context) => Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 48.0, right: 48.0),
              child: Center(
                child: Column(children: [
                  ImageOnboarding(url: 'https://source.unsplash.com/850x1200?professional?$index'),
                  SizedBox(
                    height: size.height * .075,
                  ),
                  Text(
                    "Operations",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    "Manage your timesheet and declare your leaves",
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ]),
              ),
            ),
          ),
          Breakpoints.mediumAndUp: SlotLayout.from(
            key: const Key('OnBoard other'),
            builder: (context) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: Center(
                child: ImageOnboarding(
                  url: 'https://source.unsplash.com/850x1200?professional?$index',
                ),
              ),
            ),
          )
        },
      ),
      secondaryBody: SlotLayout(
        config: {
          Breakpoints.small: null,
          Breakpoints.mediumAndUp: SlotLayout.from(
            key: const Key("other"),
            builder: (context) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Operations",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    "Manage your timesheet and declare your leaves",
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ],
              ),
            ),
          )
        },
      ),
    );
  }
}
