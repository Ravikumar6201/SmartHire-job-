import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class LinkedInAuth {
  final String clientId =
      '78lrg4eubozl2c'; // Replace with your LinkedIn app's client ID
  final String clientSecret =
      'WPL_AP1.D5rZnovzW0KPe7uL.cw8JZA=='; // Replace with your LinkedIn app's client secret
  final String redirectUri =
      'https://www.linkedin.com/'; // Replace with your app's redirect URI

  // Step 1: Generate the authentication URL
  Future<void> loginWithLinkedIn() async {
    final authUrl = Uri.https('www.linkedin.com', '/oauth/v2/authorization', {
      'response_type': 'code',
      'client_id': clientId,
      'redirect_uri': redirectUri,
      'state': 'linkedin_auth', // A random string for CSRF protection
      'scope':
          'r_liteprofile r_emailaddress', // Requesting profile and email info
    });

    // Step 2: Use the Flutter WebAuth to open the LinkedIn login page
    final result = await FlutterWebAuth.authenticate(
      url: authUrl.toString(),
      callbackUrlScheme:
          'com.linkedin.oauth', // This must match your redirect URI
    );

    // Step 3: Extract the code from the URL after successful authentication
    final code = Uri.parse(result).queryParameters['code'];
    if (code != null) {
      // Step 4: Exchange the authorization code for an access token
      final accessToken = await getAccessToken(code);
      print('Access Token: $accessToken');

      // Step 5: Fetch LinkedIn user data (e.g., profile, email)
      final userData = await fetchUserData(accessToken);
      print('User Data: $userData');
    }
  }

  // Step 4: Exchange the authorization code for an access token
  Future<String> getAccessToken(String code) async {
    final tokenUrl = Uri.https('www.linkedin.com', '/oauth/v2/accessToken');
    final response = await http.post(
      tokenUrl,
      body: {
        'grant_type': 'authorization_code',
        'code': code,
        'redirect_uri': redirectUri,
        'client_id': clientId,
        'client_secret': clientSecret,
      },
    );

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      return responseJson['access_token'];
    } else {
      throw Exception('Failed to fetch access token');
    }
  }

  // Step 5: Fetch LinkedIn user data
  Future<Map<String, dynamic>> fetchUserData(String accessToken) async {
    final profileUrl = Uri.https('api.linkedin.com', '/v2/me');
    final emailUrl = Uri.https('api.linkedin.com', '/v2/emailAddress');

    final profileResponse = await http.get(
      profileUrl,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    final emailResponse = await http.get(
      emailUrl,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (profileResponse.statusCode == 200 && emailResponse.statusCode == 200) {
      final profileData = json.decode(profileResponse.body);
      final emailData = json.decode(emailResponse.body);
      return {
        'profile': profileData,
        'email': emailData['elements'][0]['handle~']['emailAddress'],
      };
    } else {
      throw Exception('Failed to fetch user data');
    }
  }
}
