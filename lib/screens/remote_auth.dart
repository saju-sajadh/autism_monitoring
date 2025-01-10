import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../apis/auth_api.dart';
import '../model/user_model.dart';

class RemoteAuth extends StatefulWidget {
  const RemoteAuth({super.key});

  @override
  RemoteAuthState createState() => RemoteAuthState();
}

class RemoteAuthState extends State<RemoteAuth> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.green,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 250,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text(
                      '''Barcode Type: ${result!.format.formatName}   Data: ${result!.code}''')
                  : const Text('Scan a code'),
            ),
          )
        ],
      ),
    );
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;
      });
      controller.pauseCamera();

      final sessionId = result?.code ?? '';

      try {
        final user =
            await getCurrentUserDetails(); 
        final updatedUser = user.copyWith(sessionId: sessionId);
        await updateUserSession(
            updatedUser); 
        Navigator.pushNamed(context, '/panel1');
      } catch (e) {
        print('Error updating session: $e');
      }
    });
  }

  Future<UserModel> getCurrentUserDetails() async {
    return UserModel();
  }

  Future<void> updateUserSession(UserModel updatedUser) async {
    try {
      final authAPI = AuthAPI();
      await authAPI.updateUser(updatedUser);
    } catch (e) {
      print('Error updating session: $e');
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
