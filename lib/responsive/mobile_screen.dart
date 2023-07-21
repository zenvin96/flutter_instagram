import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:instagram/providers/user_provider.dart";
import "package:provider/provider.dart";
import "package:instagram/models/user.dart" as UserModel;
import 'package:instagram/utils/global_variables.dart';
import "package:instagram/utils/colors.dart";

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;

  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    UserModel.User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: homeScreenItems,
      ),
      bottomNavigationBar: CupertinoTabBar(
        height: 60,
        currentIndex: _page,
        activeColor: primaryColor,
        inactiveColor: secondaryColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
                color: _page == 0 ? primaryColor : secondaryColor),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search,
                  color: _page == 1 ? primaryColor : secondaryColor),
              label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box,
                  color: _page == 2 ? primaryColor : secondaryColor),
              label: 'Add'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite,
                  color: _page == 3 ? primaryColor : secondaryColor),
              label: 'Favorite'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person,
                  color: _page == 4 ? primaryColor : secondaryColor),
              label: 'Profile'),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
