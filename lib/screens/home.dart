import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:freeze/components/get_session_token.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Home Screen'),
      // ),
      body: SafeArea(
        child: GetSessionToken(
          child: Column(
            children: [
              Text(
                'api key: ${dotenv.env['apiKey']}',
                style: GoogleFonts.outfit(
                    fontSize: 18.0,
                    color: Theme.of(context).colorScheme.secondary),
              ),
              Text(
                'secret key: ${dotenv.env['secretKey']}',
                style: GoogleFonts.outfit(
                    fontSize: 18.0,
                    color: Theme.of(context).colorScheme.secondary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
