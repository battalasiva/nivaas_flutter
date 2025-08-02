import 'package:flutter/material.dart';
import 'package:nivaas/core/constants/gradients.dart';
import 'package:nivaas/core/constants/img_consts.dart';
import 'package:nivaas/screens/home-profile/community/community.dart';
import 'package:nivaas/screens/home-profile/homeScreen/home_screen.dart';
import 'package:nivaas/screens/home-profile/profile/profile.dart';
import '../../core/constants/colors.dart';

class BottomTab extends StatefulWidget {
  const BottomTab({super.key});

  @override
  State<BottomTab> createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    const Community(),
    // const AddServiceProviders(),
    const ProfileScreen()
  ];
  
  void _onItemTapped(int index) {
    if (index == 0) {
      setState(() {
        _selectedIndex = index;
      });
    } else {
      switch (index) {
        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Community()),
          );
          break;
        // case 2:
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => const AddServiceProviders()),
        //   );
        //   break;
        case 2:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          );
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar: _selectedIndex == 0
            ? Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  gradient: AppGradients.gradient1,
                ),
                child: SafeArea(
                  child: BottomNavigationBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    currentIndex: _selectedIndex,
                    onTap: _onItemTapped,
                    items: [
                      BottomNavigationBarItem(
                          icon: Image.asset(
                            home,
                            width: 24,
                            height: 24,
                          ),
                          label: 'Home'),
                      BottomNavigationBarItem(
                          icon: Image.asset(
                            community,
                            width: 22,
                            height: 22,
                          ),
                          label: 'Community'),
                      // BottomNavigationBarItem(
                      //     icon: Image.asset(
                      //       services,
                      //       width: 22,
                      //       height: 22,
                      //       color: AppColor.white,
                      //     ),
                      //     label: 'Services'),
                      BottomNavigationBarItem(
                          icon: Image.asset(
                            person,
                            width: 24,
                            height: 24,
                          ),
                          label: 'Profile'),
                    ],
                    selectedItemColor: Colors.blue,
                    unselectedItemColor: AppColor.white,
                    showUnselectedLabels: true,
                    type: BottomNavigationBarType.fixed,
                  ),
                ),
              )
            : null);
  }
}
