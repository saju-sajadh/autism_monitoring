import 'dart:async';

import 'package:flutter/material.dart';
import '../apis/auth_api.dart';

class PatientEmotionScreen extends StatefulWidget {
  const PatientEmotionScreen({Key? key}) : super(key: key);

  @override
  PatientEmotionScreenState createState() => PatientEmotionScreenState();
}

class PatientEmotionScreenState extends State<PatientEmotionScreen> {
  late bool _isFetchingData = true;
  late Timer _timer;

  late String patientName = '';
  late String patientAge = '';
  late String patientGender = '';
  late String disorderName = '';
  late String emotion = '';

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
    _startPeriodicFetching();
  }

  void _loadUserDetails() async {
    final authAPI = AuthAPI();
    final currentUser = await authAPI.readCurrentUser();
    if (currentUser != null) {
      setState(() {
        patientName = currentUser.patientName!;
        patientAge = currentUser.patientAge!;
        patientGender = currentUser.patientGender!;
        disorderName = currentUser.disorderName!;
        emotion = currentUser.emotion!;
      });
    }
  }

  void _startPeriodicFetching() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _isFetchingData = false;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Emotions'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey[800],
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code),
            onPressed: () {
              Navigator.pushNamed(context, '/remote');
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.blueGrey,
        child: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildDetailRow('Name:', patientName),
                  _buildDetailRow('Age:', patientAge),
                  _buildDetailRow('Gender:', patientGender),
                  _buildDetailRow('Disorder:', disorderName),
                  const SizedBox(height: 20),
                  AnimatedSwitcher(
                    duration: const Duration(seconds: 1),
                    child: _isFetchingData
                        ? Column(
                            children: [
                              const CircularProgressIndicator(
                                  color: Colors.green),
                              const SizedBox(height: 10),
                              Text(
                                'Fetching Emotion...',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(fontSize: 16),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Text(
                                'Emotion: $emotion',
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              _buildLiveStatusIndicator(),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildLiveStatusIndicator() {
    return Row(
      children: [
        const Icon(Icons.cloud_done, color: Colors.green, size: 20),
        const SizedBox(width: 8),
        Text(
          'Data Sync Complete',
          style:
              TextStyle(color: Colors.green[700], fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
