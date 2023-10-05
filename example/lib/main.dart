import 'package:apple_pay_flutter/models/enums/enums.dart';
import 'package:flutter/material.dart';

import 'main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const SDKModePage(),
    );
  }
}

class SDKModePage extends StatelessWidget {
  const SDKModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: () {
                print("Clicked");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainPage(
                      sdkMode: SdkMode.production,
                    ),
                  ),
                );
              },
              style: FilledButton.styleFrom(
                fixedSize: Size(
                  MediaQuery.sizeOf(context).width,
                  45,
                ),
              ),
              child: const Text("Production mode"),
            ),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainPage(
                      sdkMode: SdkMode.sandbox,
                    ),
                  ),
                );
              },
              style: FilledButton.styleFrom(
                fixedSize: Size(
                  MediaQuery.sizeOf(context).width,
                  45,
                ),
              ),
              child: const Text("Sandbox mode"),
            ),
          ],
        ),
      ),
    );
  }
}
