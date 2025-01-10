import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import for SVG icons

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => LandingScreenState();
}

class LandingScreenState extends State<LandingScreen> {
  static const Color primary = Color(0xFF00AD48);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.5), // Slightly darker at the top
                    Colors.white.withOpacity(0.9), // Slightly
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height * 0.45, // 45% height
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue[700],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0),
                  ),
                ),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.accessibility, 
                      size: 50.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Autism Caregiving',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'Supporting individuals with autism.',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.45, // Below
              left: 20.0, // Add some left padding
              right: 20.0, // Add some right padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, // Align
                children: [
                  const SizedBox(height: 20),
                  // Row 1 - Text with leading check mark
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.blue[700],
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        'Support positive behaviors',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black.withOpacity(0.8),
                            fontFamily: 'Roboto' // Or your preferred font
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15.0), // Add spacing between rows
                  // Row 2 - Text with leading check mark
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.blue[700],
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        'Promote communication skills',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black.withOpacity(0.8),
                          fontFamily: 'Roboto', // Or your preferred font
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15.0), // Add spacing between rows
                  // Row 3 - Text with leading check mark
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.blue[700],
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        'Ensure safety and well-being',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black.withOpacity(0.8),
                          fontFamily: 'Roboto', // Or your preferred font
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40.0), // Add spacing below check marks
                  Text(
                    'Provide specialized care and attention',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.8),
                      fontFamily: 'Roboto', // Or your preferred font
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    '''Assist caregivers with personalized care plans and behavior management strategies''',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black.withOpacity(0.8),
                      fontFamily: 'Roboto', // Or your preferred font
                    ),
                  ),
                  const SizedBox(height: 70),
                  ElevatedButton(
                    onPressed: () {
                      // Handle button press
                      Navigator.pushNamed(context, '/signin');
                    },
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize:
                          Size(MediaQuery.of(context).size.width - 40, 50),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

    );
  }
}
