import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/Apptheme.dart';
import '../widgets/coder_helper.dart';
import '../widgets/round_corner_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// Assuming SliderData is a model with imageData, titleText, subText
class SliderData {
  final String? assetsImage;
  final String? titleText;
  final String? subText;

  SliderData({this.assetsImage, this.titleText, this.subText});

  static List<SliderData> introSliderData = [
    SliderData(assetsImage: 'assets/images/introduction1.png', titleText: 'Welcome', subText: 'Welcome to the app'),
    SliderData(assetsImage: 'assets/images/introduction2.png', titleText: 'Explore', subText: 'Explore amazing features'),
    SliderData(assetsImage: 'assets/images/introduction3.png', titleText: 'Get Started', subText: 'Get started with your journey'),
  ];
}

class IntroductionPage extends StatefulWidget {
  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  var pageController = PageController(initialPage: 0);
  List<SliderData> pageViewModelData = [];  // List to hold slider data

  Timer? sliderTimer;
  var currentShowIndex = 0;

  @override
  void initState() {
    super.initState();
    pageViewModelData.addAll(SliderData.introSliderData);  // Load slider data

    // Auto slide every 4 seconds
    sliderTimer = Timer.periodic(Duration(seconds: 4), (timer) {
      setState(() {
        if (currentShowIndex == 0) {
          pageController.animateTo(MediaQuery.of(context).size.width,
              duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
        } else if (currentShowIndex == 1) {
          pageController.animateTo(MediaQuery.of(context).size.width * 2,
              duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
        } else if (currentShowIndex == 2) {
          pageController.animateTo(0,
              duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
        }
        currentShowIndex = (currentShowIndex + 1) % 3; // Loop through the pages
      });
    });
  }

  @override
  void dispose() {
    sliderTimer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.getTheme().colorScheme.background,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              pageSnapping: true,
              onPageChanged: (index) {
                setState(() {
                  currentShowIndex = index;
                });
              },
              scrollDirection: Axis.horizontal,
              children: pageViewModelData.map((data) {
                return PagePopup(imageData: data); // Pass slider data
              }).toList(),
            ),
          ),
          SmoothPageIndicator(
            count: 3,
            effect: WormEffect(
                radius: 10.0,
                spacing: 5.0,
                dotColor: AppTheme.getTheme().dividerColor,
                activeDotColor: AppTheme.getTheme().primaryColor),
            controller: pageController,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 48, right: 48, bottom: 8, top: 32),
            child: RoundCornerButtonWidget(
              buttonKey: Key('btn_login'),
              bgColor: ColorHelper.primaryColor,
              title: 'Login',  // Replace with your localization method if needed
              onTap: () {
                Navigator.pushNamed(context, '/login');  // Replace with your route
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 48, right: 48, bottom: 32, top: 8),
            child: RoundCornerButtonWidget(
              buttonKey: Key('btn_create_acc'),
              bgColor: ColorHelper.bgColor,
              onTap: () {
                Navigator.pushNamed(context, '/signup');  // Replace with your route
              },
              textColor: ColorHelper.darkColor,
              title: 'Create Account',  // Replace with your localization method if needed
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          ),
        ],
      ),
    );
  }
}

class PagePopup extends StatelessWidget {
  final SliderData? imageData;

  const PagePopup({Key? key, this.imageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ensure imageData is not null before using its properties
    if (imageData == null) return SizedBox();

    return Column(
      children: <Widget>[
        Expanded(
          flex: 8,
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 120,
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.asset(
                  imageData?.assetsImage ?? '',  // Null safe
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            child: Text(
              imageData?.titleText ?? '',  // Null safe
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            child: Text(
              imageData?.subText ?? '',  // Null safe
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppTheme.getTheme().disabledColor,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(),
        ),
      ],
    );
  }
}
