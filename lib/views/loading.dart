import 'package:ba_store/views/welcome.dart';
import 'package:flutter/material.dart';

import 'package:ba_store/services/utilities.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    startLoading();
  }

  void startLoading() async {
    // Simulate a 10-second delay
    await Future.delayed(const Duration(seconds: 10));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isLoading
          ? const CircularProgressIndicator(
              color: navyBlue,
            )
          : ElevatedButton(
              onPressed: () {
                setState(() {
                  isLoading = true;
                  startLoading();
                });
              },
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF042e60),
                ),
                child: const Text('Retry'),
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => const Welcome()),
                      (Route<dynamic> route) => false);
                },
              ),
            ),
    );
  }
}
