import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freeze/screens/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() {
    return _AuthenticationScreenState();
  }
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool doesDeviceCanCheckBiometrics = true;
  int authenticationTried = 0;
  late final LocalAuthentication auth;

  @override
  void initState() {
    super.initState();

    // checking biometric ids before screen loads
    checkDeviceBiometricCapabilities();
  }

  // findout what are biometric ids present on device
  void checkDeviceBiometricCapabilities() async {
    try {
      auth = LocalAuthentication();

      bool isBiometricAuthPossibleOnDevice = await auth.isDeviceSupported();
      bool isBiometricAuthAddedOnDevice = await auth.canCheckBiometrics;

      if (isBiometricAuthPossibleOnDevice && isBiometricAuthAddedOnDevice) {
        final List<BiometricType> availableBiometricsOnDevice =
            await auth.getAvailableBiometrics();

        if (availableBiometricsOnDevice.isNotEmpty) {
          _authenticate(); // call to authentication
        }
      } else {
        setState(() {
          doesDeviceCanCheckBiometrics = false;
        });
      }
    } catch (error) {}
  }

  void _authenticate() async {
    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to get in',
        options: const AuthenticationOptions(
          useErrorDialogs: false,
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      if (didAuthenticate) {
        if (context.mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext nextPage) => const HomeScreen(),
            ),
          );
        }
      } else {
        // failed tries
        setState(() {
          authenticationTried += 1;
        });

        // print('===> authenticationTried $authenticationTried');
        if (authenticationTried == 5) {
          auth.stopAuthentication();
        }
      }
    } on PlatformException catch (e) {
      // print('===> error $e');
      setState(() {
        authenticationTried += 1;
      });
      // print('===> authenticationTried $authenticationTried');
    }
  }

  @override
  Widget build(BuildContext context) {
    Brightness activeTheme = MediaQuery.of(context).platformBrightness;
    double scrrenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        // status bar style
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).colorScheme.background,
          statusBarBrightness: activeTheme,
          statusBarIconBrightness: activeTheme,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // biometric icons
          SizedBox(
            height: scrrenHeight * 0.6,
            child: Center(
              child: SvgPicture.asset(
                'assets/images/fingerprint.svg',
                semanticsLabel: 'biometric',
                width: 180.0,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          // message
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Biometric Authentication',
                  style: GoogleFonts.outfit(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Login with fingureprint or FaceID to access world of investment',
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
    );
  }
}
