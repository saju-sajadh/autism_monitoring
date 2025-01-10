import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileScreen extends StatefulWidget {
  final User? user;
  const ProfileScreen(this.user, {Key? key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  late String userEmail = 'N/A';
  late String userUid = 'N/A';
  late String photoUrl = '';

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      userEmail = widget.user!.email ?? 'N/A';
      userUid = widget.user!.uid;
      photoUrl = widget.user!.photoURL ?? '';
    }
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('UID copied to clipboard!')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: 2, child: TopPortion(photoURL: photoUrl)),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height:20),
                  Text(
                    'Email: $userEmail',
                    style: const TextStyle(
                        fontSize: 20, fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height:20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'UID: $userUid',
                        style: const TextStyle(
                            fontSize: 15, fontStyle: FontStyle.italic),
                      ),
                      IconButton(
                        icon: const Icon(Icons.copy),
                        onPressed: () => _copyToClipboard(userUid),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton.extended(
                        onPressed: () {
                          Navigator.pushNamed(context, '/patient');
                        },
                        heroTag: 'Patient Data',
                        elevation: 0,
                        backgroundColor: const Color(0xff0043ba),
                        label: const Text('Patient Data',
                            style: TextStyle(color: Colors.white)),
                        icon: const Icon(Icons.person_add_alt_1,
                            color: Colors.white),
                      ),
                      const SizedBox(width: 16.0),
                      FloatingActionButton.extended(
                        onPressed: () {},
                        heroTag: 'Chat',
                        elevation: 0,
                        backgroundColor: const Color(0xff0043ba),
                        label: const Text('Chat',
                            style: TextStyle(color: Colors.white)),
                        icon: const Icon(Icons.message_rounded,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



  Widget singleItem(BuildContext context, ProfileInfoItem item) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.value.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Text(
            item.title,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      );


class ProfileInfoItem {
  final String title;
  final int value;
  const ProfileInfoItem(this.title, this.value);
}

class TopPortion extends StatelessWidget {
  final String? photoURL;
  const TopPortion({Key? key, this.photoURL}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Color(0xff0043ba), Color(0xff006df1)],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: CircleAvatar(
              backgroundColor: Colors.grey[300], 
              backgroundImage: (photoURL != null && photoURL!.isNotEmpty)
                  ? NetworkImage(photoURL!) 
                  : const AssetImage('assets/images/medical_team.png')
                      as ImageProvider,
            ),
          ),
        ),
      ],
    );
  }
}
