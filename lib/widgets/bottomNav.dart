import 'package:flutter/material.dart';
import 'package:trackbuddy/screens/homePage.dart';
import 'package:trackbuddy/screens/addTask.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0; 
  final List<Widget> _children = [
    HomePage(),
    CalenderScreen(),
    AddTask(),
    /*NotificationsScreen(),
    ProfileScreen(), */
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.black, // Color of the top border
              width: 1, // Width of the top border
            ),
          ),
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: const Color(0xffF26E56),
          unselectedItemColor: const Color(0xffF26E56).withOpacity(0.5),
          currentIndex: _currentIndex,
          onTap: onTabTapped,
          type: BottomNavigationBarType.fixed,
          items: [
            _buildNavItem(Icons.home_outlined),
            _buildNavItem(Icons.calendar_today),
            _buildCenterNavItem(),
            _buildNavItem(Icons.file_copy_outlined),
            _buildNavItem(Icons.person_2_outlined),
          ],  
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _children,
      ),
    );
  }

  

  BottomNavigationBarItem _buildNavItem(IconData icon) {
    return BottomNavigationBarItem(
      icon: Icon(icon,size: 25,),
      label: '',

    );
  }

  BottomNavigationBarItem _buildCenterNavItem() {
    return BottomNavigationBarItem(
      icon: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xffF26E56), // Customize the color as needed
        ),
        child: Icon(Icons.add, size: 40, color: Colors.white), // Customize the icon size and color
      ),
      label: '', // Empty label for the center item
    );
  }

}

class CalenderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Calender Screen'),
    );
  }
}
