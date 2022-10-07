import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:riverpod_2/main.dart';

class FingerPrintPage extends StatefulWidget {
  const FingerPrintPage({Key? key}) : super(key: key);

  @override
  State<FingerPrintPage> createState() => _FingerPrintPageState();
}

class _FingerPrintPageState extends State<FingerPrintPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: InkResponse(
                  onTap: () {
                    themeMode.value = themeMode.value == ThemeMode.dark
                        ? ThemeMode.light
                        : ThemeMode.dark;
                  },
                  child: const Icon(Icons.dark_mode),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Center(
                  child: ValueListenableBuilder(
                      valueListenable: isAuthenticated,
                      builder: (__, isAuth, _) {
                        if (isAuth) {
                          return const Text('User is Authenticated');
                        }
                        return InkWell(
                          onTap: () {
                            authenticated();
                          },
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(Icons.fingerprint),
                          ),
                        );
                      }),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Authenticate with Figerprint/Face ID',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future authenticated() async {
    try {
      final LocalAuthentication auth = LocalAuthentication();
      // ···
      final canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      final canAuthenticate =
          canAuthenticateWithBiometrics || await auth.isDeviceSupported();
      if (canAuthenticateWithBiometrics && canAuthenticateWithBiometrics) {
        final List<BiometricType> availableBiometrics =
            await auth.getAvailableBiometrics();

        if (availableBiometrics.isNotEmpty) {
          final didAuthenticate = await auth.authenticate(
              localizedReason: 'Please authenticate to login to niaja worker');
          if (didAuthenticate) {
            isAuthenticated.value = true;
          } else {
            isAuthenticated.value = false;
          }
        } else {
          return Exception('No biometrics available');
        }

        // if (availableBiometrics.contains(BiometricType.strong) ||
        //     availableBiometrics.contains(BiometricType.face)) {
        //   // Specific types of biometrics are available.
        //   // Use checks like this with caution!
        // }
      } else {
        throw UnsupportedError('Device not supported');
      }
    } on PlatformException catch (e) {
      print("Error: ${e.message}");
    }
  }
}
