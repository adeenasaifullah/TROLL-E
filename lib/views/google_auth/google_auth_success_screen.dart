// import 'package:flutter/material.dart';
// import 'package:flutter_web_auth/flutter_web_auth.dart';
// import 'dart:convert';
//
// class GoogleAuthSuccessScreen extends StatefulWidget {
//   final String initialUrl;
//
//   GoogleAuthSuccessScreen({Key? key, required this.initialUrl}) : super(key: key);
//
//   @override
//   _GoogleAuthSuccessScreenState createState() => _GoogleAuthSuccessScreenState();
// }
//
// // class _GoogleAuthSuccessScreenState extends State<GoogleAuthSuccessScreen> {
// //   String? _accessToken;
// //   Map<String, dynamic>? _userProfile;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //
// //     // Extract access token and user profile from initial URL
// //     Uri initialUri = Uri.parse(widget.initialUrl);
// //     _accessToken = initialUri.queryParameters['access_token'];
// //     String? userJson = initialUri.queryParameters['user'];
// //     if (userJson != null) {
// //       _userProfile = json.decode(userJson);
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Google Authentication Success'),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Text('Access Token: $_accessToken'),
// //             SizedBox(height: 16),
// //             Text('User Profile: ${_userProfile.toString()}'),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// class _GoogleAuthSuccessScreenState extends State<GoogleAuthSuccessScreen> {
//   String? _accessToken;
//   Map<String, dynamic>? _userProfile;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Extract access token and user profile from initial URL
//     Uri initialUri = Uri.parse(widget.initialUrl);
//     if (initialUri.path == '/auth/google/callback') {
//       _accessToken = initialUri.queryParameters['access_token'];
//       String? userJson = initialUri.queryParameters['user'];
//       if (userJson != null) {
//         _userProfile = json.decode(userJson);
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Google Authentication Success'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Access Token: $_accessToken'),
//             SizedBox(height: 16),
//             Text('User Profile: ${_userProfile.toString()}'),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GoogleAuthSuccessScreen extends StatefulWidget {
  final String initialUrl;
  final String code;

  GoogleAuthSuccessScreen({
    Key? key,
    required this.initialUrl,
    required this.code}) : super(key: key);

  @override
  _GoogleAuthSuccessScreenState createState() => _GoogleAuthSuccessScreenState();
}

class _GoogleAuthSuccessScreenState extends State<GoogleAuthSuccessScreen> {
  String? _accessToken;
  Map<String, dynamic>? _userProfile;

  @override
  void initState() {
    super.initState();

    _getAccessToken();
  }

  Future<void> _getAccessToken() async {
    final response = await http.post(Uri.parse('https://oauth2.googleapis.com/token'), body: {
      'code': widget.code,
      'client_id': '495548594516-lm6q0h79bifcchod2ii9dpl7hrcf3fuk.apps.googleusercontent.com',
      'client_secret': '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',
      'redirect_uri': 'http://3.106.170.176:3000/auth/google/callback',
      'grant_type': 'authorization_code',
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final String? accessToken = data['access_token'];
      final String? tokenType = data['token_type'];

      if (accessToken != null && tokenType != null) {
        _getUserProfile(accessToken, tokenType);
      }
    }
  }

  Future<void> _getUserProfile(String accessToken, String tokenType) async {
    final response = await http.get(
      Uri.parse('https://www.googleapis.com/oauth2/v1/userinfo?alt=json'),
      headers: {'Authorization': '$tokenType $accessToken'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      _accessToken = accessToken;
      _userProfile = data;
      setState(() {});
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
            if (_accessToken != null) Text('Access Token: $_accessToken'),
            SizedBox(height: 16),
            if (_userProfile != null) Text('User Profile: ${_userProfile.toString()}'),
          ],
        ),
      ),
    );
  }
}
