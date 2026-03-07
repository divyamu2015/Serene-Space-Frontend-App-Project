import 'package:flutter/material.dart';
import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:serene_space_project/authentication/patient/login_screen/login_view_page.dart';
import 'package:serene_space_project/hospital_doctor_screen/hospital_home_screen/doctor_dashboard.dart';

class HospaitalDocHomeScreen extends StatefulWidget {
  const HospaitalDocHomeScreen({super.key, required this.doctorId});
  final int doctorId;

  @override
  State<HospaitalDocHomeScreen> createState() => _HospaitalDocHomeScreenState();
}

class _HospaitalDocHomeScreenState extends State<HospaitalDocHomeScreen> {
  int _tabIndex = 0;
  late PageController pageController;
  int? doctorId;

  @override
  void initState() {
    super.initState();
    doctorId = widget.doctorId;
    pageController = PageController(initialPage: _tabIndex);
  }

  Future<void> _showLogoutDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout Alert"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            child: const Text("Yes, Logout", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: CircleNavBar(
          activeIcons: const [
            Icon(Icons.home, color: Colors.deepPurple),
            Icon(Icons.logout, color: Colors.deepPurple),
          ],
          inactiveIcons: const [
            Text("Home"),
            Text("Logout"),
          ],
          color: Colors.white,
          height: 60,
          circleWidth: 60,
          activeIndex: _tabIndex,
          onTap: (index) {
            if (index == 1) {
              _showLogoutDialog(context); // Logout
              return;
            }
            setState(() => _tabIndex = index);
            pageController.jumpToPage(_tabIndex);
          },
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
          cornerRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(24),
            bottomLeft: Radius.circular(24),
          ),
          shadowColor: const Color.fromARGB(255, 248, 219, 175),
          elevation: 10,
        ),
        body: PageView(
          controller: pageController,
          onPageChanged: (index) => setState(() => _tabIndex = index),
          children: [
            DoctorDashboard(doctorId: doctorId!), // Home
          ],
        ),
      ),
    );
  }
}