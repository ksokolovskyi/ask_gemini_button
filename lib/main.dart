import 'package:ask_gemini_button/ask_gemini_button.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFF8FAFD),
        body: Stack(
          children: [
            const Positioned(
              right: 16,
              bottom: -24,
              child: FlutterLogo(
                size: 100,
                style: FlutterLogoStyle.horizontal,
              ),
            ),
            Center(
              child: AskGeminiButton(
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
