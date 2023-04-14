import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'dart:convert';

class GoogleAuthSuccessScreen extends StatefulWidget {
  final String initialUrl;

  GoogleAuthSuccessScreen({Key? key, required this.initialUrl}) : super(key: key);

  @override
  _GoogleAuthSuccessScreenState createState() => _GoogleAuthSuccessScreenState();
}

class _GoogleAuthSuccessScreenState extends State<GoogleAuthSuccessScreen> {
  String? _accessToken;
  Map<String, dynamic>? _userProfile;

  @override
  void initState() {
    super.initState();

    // Extract access token and user profile from initial URL
    Uri initialUri = Uri.parse(widget.initialUrl);
    _accessToken = initialUri.queryParameters['access_token'];
    String? userJson = initialUri.queryParameters['user'];
    if (userJson != null) {
      _userProfile = json.decode(userJson);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Authentication Success'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Access Token: $_accessToken'),
            SizedBox(height: 16),
            Text('User Profile: ${_userProfile.toString()}'),
          ],
        ),
      ),
    );
  }
}
