import 'package:flutter/material.dart';
import '../apis/auth_api.dart';
import '../model/user_model.dart';

class PatientDetailsScreen extends StatefulWidget {
  const PatientDetailsScreen({Key? key}) : super(key: key);

  @override
  PatientDetailsScreenState createState() => PatientDetailsScreenState();
}

class PatientDetailsScreenState extends State<PatientDetailsScreen> {
  final TextEditingController patientNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController patientAgeController = TextEditingController();
  final TextEditingController patientGenderController = TextEditingController();
  final TextEditingController disorderNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  void _loadUserDetails() async {
    final authAPI = AuthAPI();
    final user = await authAPI.readCurrentUser();
    if (user != null) {
      setState(() {
        patientAgeController.text = user.patientAge!;
        disorderNameController.text = user.disorderName!;
        patientGenderController.text = user.patientGender!;
        patientNameController.text = user.patientName!;
        emailController.text = user.email!;
        phoneNumberController.text = user.phoneNumber!;
      });
    }
  }

  void updatePatientDetails() async {
    final updatedPatientName = patientNameController.text;
    final updatedEmail = emailController.text;
    final updatedAge = patientAgeController.text;
    final updatedGender = patientGenderController.text;
    final updatedDisorder = disorderNameController.text;
    final updatedPhone = phoneNumberController.text;

    final userData = UserModel(
      disorderName: updatedDisorder,
      email: updatedEmail,
      patientAge: updatedAge,
      patientGender: updatedGender,
      patientName: updatedPatientName,
      phoneNumber: updatedPhone,
    );
    final authAPI = AuthAPI();
    await authAPI.updateUser(userData);
  }

  Widget _buildEditableField(String label, TextEditingController controller,
      {bool enabled = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: TextFormField(
              controller: controller,
              enabled: enabled,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 8.0),
              ),
              keyboardType:
                  label == 'Age' ? TextInputType.number : TextInputType.text,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Details'),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildEditableField('Patient Name', patientNameController),
            _buildEditableField('Age', patientAgeController),
            _buildEditableField('Gender', patientGenderController),
            _buildEditableField('Disorder Name', disorderNameController),
            _buildEditableField(
              'Email ID',
              emailController,
              enabled: false,
            ),
            _buildEditableField('Phone Number', phoneNumberController),
            const SizedBox(height: 20), // Add some space before the button
            ElevatedButton(
              onPressed: updatePatientDetails,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Update Details',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
