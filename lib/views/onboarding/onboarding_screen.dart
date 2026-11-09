import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../auth/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingContent> _contents = [
    OnboardingContent(
      title: "Find Events That Inspire You",
      description:
      "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
      image: "assets/images/onboarding_1.png",
    ),
    OnboardingContent(
      title: "Effortless Event Planning",
      description:
      "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we've got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
      image: "assets/images/onboarding_2.png",
    ),
    OnboardingContent(
      title: "Connect with Friends & Share Moments",
      description:
      "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",
      image: "assets/images/onboarding_3.png",
    ),
  ];

  static const Color backgroundColor = Color(0xFFF4F7FF);
  static const Color primaryColor = Color(0xFF163FA8);
  static const Color titleColor = Color(0xFF171717);
  static const Color descriptionColor = Color(0xFF656565);

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  void _nextPage() {
    if (_currentIndex == _contents.length - 1) {
      _goToLogin();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _currentIndex > 0
                        ? IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 40,
                        minHeight: 40,
                      ),
                      onPressed: _previousPage,
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: primaryColor,
                        size: 22,
                      ),
                    )
                        : const SizedBox(width: 40),

                    SizedBox(
                      height: 165,
                      child: Image.asset(
                        'assets/images/app_logo.png',
                        fit: BoxFit.fitHeight,
                      ),
                    ),

                    _currentIndex < 2
                        ? GestureDetector(
                      onTap: _goToLogin,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFFE2E8F0),
                            width: 1.2,
                          ),
                        ),
                        child: const Text(
                          "Skip",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                        : const SizedBox(width: 40),
                  ],
                ),
              ),

              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _contents.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image.asset(
                              _contents[index].image,
                              height: 350,
                              fit: BoxFit.contain,
                            ),
                          ),

                          const SizedBox(height: 2),

                          Center(
                            child: SmoothPageIndicator(
                              controller: _pageController,
                              count: _contents.length,
                              effect: const ExpandingDotsEffect(
                                activeDotColor: primaryColor,
                                dotColor: Color(0xFFE0E0E0),
                                dotHeight: 8,
                                dotWidth: 8,
                                expansionFactor: 3,
                                spacing: 6,
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            _contents[index].title,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: titleColor,
                              height: 1.2,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            _contents[index].description,
                            style: const TextStyle(
                              fontSize: 15.5,
                              color: descriptionColor,
                              height: 1.45,
                            ),
                          ),

                          const SizedBox(height: 14),
                        ],
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(24.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      _currentIndex == _contents.length - 1
                          ? "Get started"
                          : "Next",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingContent {
  final String title;
  final String description;
  final String image;

  OnboardingContent({
    required this.title,
    required this.description,
    required this.image,
  });
}