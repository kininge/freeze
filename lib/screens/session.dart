import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:freeze/states/session_token/session_token_bloc.dart';
import 'package:freeze/states/session_token/session_token_event.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

String sessionTokenGettingURL =
    'https://api.icicidirect.com/apiuser/login?api_key=${dotenv.env['apiKey']}';

class SessionTokenScreen extends StatefulWidget {
  const SessionTokenScreen({super.key});

  @override
  State<SessionTokenScreen> createState() => _SessionTokenScreenState();
}

class _SessionTokenScreenState extends State<SessionTokenScreen> {
  String sessionToken = '';

  void _updateSessionToken(String updatedSessionToken) {
    setState(() {
      sessionToken = updatedSessionToken;
    });
  }

  void showErrorTolaunchURL(BuildContext context, String? error) {
    String errorMessage = error ??
        'Something is wrong! You can manually type and get session token.';

    // remove if existing snackbar then open new
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage)),
    );
  }

  void _setSessionToken() {
    SessionTokenBloc sessionTokenBloc = context.read<SessionTokenBloc>();

    sessionTokenBloc.add(
      AddSessionToken(
        sessionToken: int.parse(sessionToken),
      ),
    );

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        content: Text(
          'Session token added, It will be there until session token expire',
          style: GoogleFonts.outfit(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double scrrenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // biometric icons
            SizedBox(
              height: scrrenHeight * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // label
                  Text(
                    'Session Token',
                    style: GoogleFonts.outfit(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),

                  Row(
                    children: [
                      // input field
                      Expanded(
                        child: TextField(
                          style: const TextStyle(),
                          // maxLength: 8,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 0.0,
                              ),
                              border: const OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(6.0),
                                ),
                                borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(6.0),
                                ),
                                borderSide: BorderSide(
                                  width: 2.0,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              focusColor:
                                  Theme.of(context).colorScheme.secondary,
                              hintText: 'session token...',
                              hintStyle: GoogleFonts.outfit(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondary)),
                          keyboardType: TextInputType.number,

                          onChanged: (String value) =>
                              _updateSessionToken(value),
                        ),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      IconButton.filled(
                          onPressed: _setSessionToken,
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(6.0),
                                ),
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color?>(
                                    (Set<MaterialState> states) => sessionToken
                                                .length ==
                                            8
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSurface),
                          ),
                          icon: Icon(
                            Icons.keyboard_arrow_right_outlined,
                            color: Theme.of(context).colorScheme.background,
                          ))
                    ],
                  ),
                ],
              ),
            ),
            // message
            Text(
              'Session Token',
              style: GoogleFonts.outfit(
                fontSize: 24.0,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            // sub text and url
            RichText(
              text: TextSpan(
                text:
                    'SEBI banned automated login process so, You can generate token like this',
                style: GoogleFonts.outfit(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                children: [
                  TextSpan(
                      text: ' $sessionTokenGettingURL',
                      style: GoogleFonts.outfit(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.blueAccent,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          try {
                            final Uri uri = Uri.parse(sessionTokenGettingURL);
                            if (!await launchUrl(
                              uri,
                              mode: LaunchMode.externalApplication,
                            )) {
                              if (context.mounted) {
                                showErrorTolaunchURL(context, null);
                              }
                            }
                          } catch (e) {
                            if (context.mounted) {
                              showErrorTolaunchURL(context, e.toString());
                            }
                          }
                        }),
                  TextSpan(
                    text: ' and provide here',
                    style: GoogleFonts.outfit(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
