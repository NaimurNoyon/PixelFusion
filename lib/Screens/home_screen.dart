import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pixel_fusion/Screens/splash_screen.dart';

import '../Constants/app_colors.dart';
import 'demo.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            //<-- SEE HERE
            child: new Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            // <-- SEE HERE
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ??
        false;
  }

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  int _index = 0;

  late final screen = [
    Demo(),
    Demo(),
    Demo(),
    Demo(),
  ];

  late final bottomLogo = [
    "assets/images/home_icon.png",
    "assets/images/category_icon.png",
    "assets/images/trending_icon.png",
    "assets/images/profile_icon.png",
  ];

  late final bottomTitle = ['Home', 'Category', 'Trending', 'Profile'];



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: AppColors.colorWhiteHighEmp,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          key: _globalKey,
          backgroundColor: AppColors.colorWhiteHighEmp,
          body: screen[_index],
          bottomNavigationBar: Material(
            elevation: 100,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1), // Shadow color
                    spreadRadius: 2.sp, // Spread radius
                    blurRadius: 5.sp, // Blur radius
                    offset: Offset(0, -2), // Offset position of shadow
                  ),
                ],
              ),
              child: NavigationBarTheme(
                data: NavigationBarThemeData(
                  backgroundColor: AppColors.colorSecondaryLight,
                  //shadowColor: AppColors.colorBlackLowEmp.withOpacity(0.5),
                  indicatorColor: AppColors.colorSecondaryLight,
                  labelTextStyle: MaterialStateProperty.resolveWith(
                        (states) {
                      if (states.contains(MaterialState.selected)) {
                        return TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.colorRed,
                        );
                      } else {
                        return TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.colorWhiteHighEmp,
                        );
                      }
                    },
                  ),
                ),
                child: NavigationBar(
                  height: 70.h,
                  selectedIndex: _index,
                  onDestinationSelected: (index) {
                    if (index == 4) {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: SplashScreen(),
                          duration: const Duration(milliseconds: 400),
                          type: PageTransitionType.rightToLeft,
                        ),
                      );
                    } else {
                      setState(() => _index = index);
                    }

                  },
                  destinations: [
                    ...List.generate(
                      screen.length,
                          (index) => bottomElementBuilder(
                        logo: bottomLogo[index],
                        title: bottomTitle[index],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

NavigationDestination bottomElementBuilder(
    {required String logo, required String title}) {
  return NavigationDestination(
    icon: Image.asset(
      logo,
      color: AppColors.colorPrimary,
      height: 24.h,
    ),
    label: title,
    selectedIcon: Image.asset(
      logo,
      color: AppColors.colorRedLight,
      height: 24.h,
    ),
  );
}