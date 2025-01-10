import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../apis/auth_api.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  late Future<User?> _user;

  @override
  void initState() {
    super.initState();
    setState(() {
      final authAPI = AuthAPI();
      _user = authAPI.getCurrentUserInstance();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[700],
        automaticallyImplyLeading: false,
        title: const Text(
          'Control Panel',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
        ),
        elevation: 8.0, // Added shadow to AppBar
      ),
      body: Container(
        color: Colors.blueGrey[800],
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Greeting section
              _buildGreetingSection(),

              const SizedBox(height: 20),

              // Status Indicator section (new component)
              _buildStatusIndicator(),

              const SizedBox(height: 20),

              // Quick Access Buttons
              _buildQuickAccessButtons(context),

              const SizedBox(height: 20),

              // Latest Updates section
              _buildLatestUpdatesSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGreetingSection() {
    return FutureBuilder<User?>(
      future: _user,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Text(
            'Error: ${snapshot.error}',
            style: const TextStyle(color: Colors.white),
          );
        }

        final user = snapshot.data;

        return Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8.0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Welcome ${user?.displayName ?? 'back!'}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Icon(
                Icons.accessibility,
                size: 30.0,
                color: Colors.white,
              ),
            ],
          ),
        );
      },
    );
  }

  // New Status Indicator Widget
  Widget _buildStatusIndicator() {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(
            Icons.circle,
            color: Colors.blue, // Green color for active status
            size: 12.0,
          ),
          const SizedBox(width: 10.0),
          const Text(
            'Status: Inactive', // You can change this to "Node" or other status
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccessButtons(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Change to 3 columns to fit 6 buttons
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
      ),
      itemCount: 6, // Number of quick access buttons
      itemBuilder: (context, index) {
        final icons = [
          Icons.crisis_alert,
          Icons.accessibility_new, // Icon for caregiving assistance
          Icons.favorite_border, // Icon for heart rate monitoring
          Icons.chat_bubble_outline, // Icon for chat (caregiver support)
          Icons.local_hospital, // Icon for medical services
          Icons.person, // Icon for service status
        ];

        final texts = [
          'Detect Fall',
          'Emotion Analyzer', // Text for caregiving assistance
          'Heart Rate Monitoring', // Text for heart rate monitoring
          'Chat', // Text for caregiver chat
          'Status',
          'Profile' // Text for service status
        ];

        return GestureDetector(
          onTap: () {
            // Navigate to the appropriate page
            Navigator.pushNamed(context, '/panel${index + 1}');
          },
          child: Container(
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: Colors.blue[700],
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8.0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icons[index], // Use icons list
                  color: Colors.white,
                  size: 30.0,
                ),
                const SizedBox(height: 8.0),
                Text(
                  texts[index], // Use texts list
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLatestUpdatesSection() {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Latest Updates',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10.0),
          _buildUpdateItem(
              'Caregiver advisory service now available', Icons.update),
          _buildUpdateItem(
              'Check your caregiving support status', Icons.notifications),
          _buildUpdateItem(
              'New caregiving support system available', Icons.check_circle),
          _buildUpdateItem('Explore our new caregiver resource center',
              Icons.account_balance),
      
        ],
      ),
    );
  }

  Widget _buildUpdateItem(String text, IconData icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0), 
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 20.0),
        const SizedBox(width: 20.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    ),
  );
}

}
