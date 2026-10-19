import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:street_bite/core/theme/app_colors.dart';
import 'package:street_bite/features/favorites/presentation/screens/favorite_screen.dart';
import 'package:street_bite/features/home/presentation/screens/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      HomeScreen(),
      FavoriteScreen(),
      Container(color: AppColors.info),
      Container(color: AppColors.rating),
    ];
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: _currentIndex != 0
                ? Icon(Icons.home_outlined)
                : Icon(Icons.home),
            label: 'navigation.home'.tr(),
          ),
          BottomNavigationBarItem(
            icon: _currentIndex != 1
                ? Icon(Icons.favorite_border)
                : Icon(Icons.favorite),
            label: 'navigation.favourites'.tr(),
          ),
          BottomNavigationBarItem(
            icon: _currentIndex != 2
                ? Icon(Icons.shopping_cart_outlined)
                : Icon(Icons.shopping_cart),
            label: 'navigation.cart'.tr(),
          ),
          BottomNavigationBarItem(
            icon: _currentIndex != 3
                ? Icon(Icons.person_outline)
                : Icon(Icons.person),
            label: 'navigation.profile'.tr(),
          ),
        ],
      ),
    );
  }
}
