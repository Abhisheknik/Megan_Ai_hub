import 'dart:ui';
import 'package:ai_app/views/ai_tool.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ai_app/const/image_url.dart';
import 'package:ai_app/const/typography.dart';
import 'package:ai_app/views/auth_screens/login_page.dart';

class Onbroadingppage extends StatefulWidget {
  const Onbroadingppage({Key? key}) : super(key: key);

  @override
  State<Onbroadingppage> createState() => _OnbroadingppageState();
}

class _OnbroadingppageState extends State<Onbroadingppage> {
  late PageController _pageController;
  int _pageIndex = 0;
  bool _showLetsGetStarted = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _checkFirstRun();
  }

  Future<void> _checkFirstRun() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstRun = prefs.getBool('isFirstRun') ?? true;

    if (!isFirstRun) {
      // Navigate to home page if not the first run
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AiTool()),
      );
    } else {
      // Set the flag to false so the splash screen won't show again
      await prefs.setBool('isFirstRun', false);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(
                sigmaX: 8, sigmaY: 8), // Adjust blur intensity as needed
            child: Image.asset(
              igvector3, // Replace backgroundImage with your image path
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 5, sigmaY: 5), // Adjust blur intensity as needed
            child: Container(
              color: Colors.black
                  .withOpacity(0.90), // Adjust opacity for brightness
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        itemCount: onbroad_data.length,
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _pageIndex = index;
                            _showLetsGetStarted =
                                index == onbroad_data.length - 1;
                          });
                        },
                        itemBuilder: (context, index) => index == 0
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Image.asset(
                                        igbrain,
                                        height: 120, // Adjust height as needed
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Megan.ai",
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontFamily: regular,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                            : Onbroading(
                                image: onbroad_data[index].image,
                                title: onbroad_data[index].title,
                                description: onbroad_data[index].description,
                                showDescription: index != 0,
                              ),
                      ),
                    ),
                    Row(
                      children: [
                        ...List.generate(
                          onbroad_data.length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Dotindicator(isActive: index == _pageIndex),
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          height: 45,
                          width: 75,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_pageIndex < onbroad_data.length - 1) {
                                _pageController.nextPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.ease,
                                );
                              } else {
                                setState(() {
                                  _showLetsGetStarted = true;
                                });
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              backgroundColor: Color(0xFFFFFFFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            child: _showLetsGetStarted
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.arrow_forward),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(width: 8),
                                      Visibility(
                                        visible: !_showLetsGetStarted,
                                        child: Icon(Icons.arrow_forward),
                                      ),
                                      SizedBox(width: 8),
                                    ],
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Dotindicator extends StatelessWidget {
  const Dotindicator({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: isActive ? 12 : 4,
      width: 4,
      decoration: BoxDecoration(
        color: isActive ? Colors.purple : Colors.purple.withOpacity(0.4),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

class Onbroad {
  final String image, title, description;
  Onbroad({
    required this.image,
    required this.title,
    required this.description,
  });
}

final List<Onbroad> onbroad_data = [
  Onbroad(
    image: igbrain,
    title: "Megan.ai",
    description: "",
  ),
  Onbroad(
    image: igvector11,
    title: "Unlock AI Innovation Every Day",
    description:
        "Discover cutting-edge AI tools daily, and watch as our database evolves with the latest advancements.",
  ),
  Onbroad(
    image: igvector12,
    title: "Discover the AI Solution You've Been Seeking",
    description:
        "Explore our extensive database of AI tools and find the solution you need, with updates reflecting the forefront of AI technology.",
  ),
  Onbroad(
    image: igvector13,
    title: "Explore AI Innovations Tailored for You",
    description:
        "Fall in love with the AI tools you discover here, knowing that our database grows and adapts alongside the rapidly evolving AI landscape.",
  )
];

class Onbroading extends StatelessWidget {
  const Onbroading({
    required this.image,
    required this.title,
    required this.description,
    this.showDescription = true,
    this.imageHeight = 200, // Default height for image
    this.titleFontSize = 20, // Default font size for title
    Key? key,
  }) : super(key: key);

  final String image, title, description;
  final bool showDescription;
  final double imageHeight; // Height for the image
  final double titleFontSize; // Font size for the title

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Expanded(
          child: Center(
            child: Image.asset(
              image,
              height: imageHeight, // Use the provided image height
            ),
          ),
        ),
        Spacer(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontFamily: semibold, // Use the provided font family
            fontSize: titleFontSize, // Use the provided title font size
          ),
        ),
        if (showDescription) SizedBox(height: 16),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontFamily: regular,
          ),
        ),
        Spacer(),
      ],
    );
  }
}
