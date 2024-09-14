import 'package:flutter/material.dart';
import 'package:smart_cradle_infants_app/view/last_record_page.dart';
import 'package:smart_cradle_infants_app/view/profile_page.dart';

import 'alerts_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const LastRecordPage(),
    const AlertsPage(),
    const ProfilePage(),
  ];
  final List<String> _titles = [
    "البيانات الحالية للطفل",
    "التنبيهات",
    "الملف الشخصي",
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black12,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ClipOval(
                child: Image(
                  image: AssetImage('Assets/logo.jpeg'),
                  // Ensure the path is correct
                  height: 40,
                  width: 40,
                  // Width should match height for a perfect circle
                  fit: BoxFit.cover, // Use cover to ensure the image fits well
                ),
              ),
              Text(
                _titles[_selectedIndex],
                style: TextStyle(color: Colors.blueAccent, fontSize: 16),
              ),
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  Navigator.pushNamed(context, 'logout');
                },
              )
            ],
          ),
        ),
        body: Center(
          child: Directionality(
              textDirection: TextDirection.rtl, // Set RTL direction
              child: _pages[_selectedIndex]),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.manage_accounts_sharp),
              label: '',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
