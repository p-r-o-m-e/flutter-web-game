import 'package:basic/style/palette.dart';
import 'package:basic/style/responsive_screen.dart';
import 'package:basic/utils/customicon.dart';
import 'package:basic/utils/snackBar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../style/my_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _focusNodePassword = FocusNode();

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final palette = context.read<Palette>();
    return Scaffold(
      backgroundColor: palette.backgroundLevelSelection,
      body: ResponsiveScreen(
        squarishMainArea: Column(
          children: [
            Expanded(
              child: SizedBox(
                height: 150,
              ),
            ),
            Text(
              "Welcome,",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Authenticate to continue",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(
              height: 60,
            ),
            TextFormField(
              controller: _usernameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: '\tUsername',
                labelStyle: TextStyle(fontFamily: 'LTC'),
                prefixIcon: Icon(Icons.person_2_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onEditingComplete: () => _focusNodePassword.requestFocus(),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Please enter username.";
                  //TODO : change below condition as per need
                } else if (true) {
                  return "Username is not registered.";
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: _obscurePassword,
              controller: _passwordController,
              focusNode: _focusNodePassword,
              decoration: InputDecoration(
                labelStyle: TextStyle(fontFamily: 'LTC'),
                labelText: "\tPassword",
                prefixIcon: const Icon(Icons.password_outlined),
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    icon: _obscurePassword
                        ? const Icon(Icons.visibility_outlined)
                        : const Icon(Icons.visibility_off_outlined)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Please enter password.";
                  //TODO : Change below condition as needed
                } else if (true) {
                  return "Wrong password.";
                }

                return null;
              },
            ),
            // SizedBox(height : 20),
            // MyButton(child: )
            SizedBox(height: 24),
            MyButton(
              onPressed: () {
                GoRouter.of(context).go('/login/filler');
              },
              child: const Text('Login'),
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Or login with \t'),
                OutlinedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      // shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(30.0))),
                      ),
                  child: Icon(CustomFlutterIcon.google),
                ),
                SizedBox(
                  width: 12,
                ),
                OutlinedButton(
                  child: Icon(CustomFlutterIcon.facebook_f),
                  onPressed: () {},
                ),
                SizedBox(
                  width: 12,
                ),
                OutlinedButton(
                    onPressed: () {
                      if (kIsWeb) {
                        SnackBarTool.showSnackBar(context,
                            'Guest login is disabled on browser platform. You may Sign up so the server remembers you.');
                      } else {
                        GoRouter.of(context).go('/play');
                      }
                    },
                    child: Text(
                      'Guest Account',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'LTC'),
                    ))
              ],
            ),
            Expanded(child: SizedBox())
          ],
        ),
        rectangularMenuArea: MyButton(
          onPressed: () {
            GoRouter.of(context).go('/');
          },
          child: const Text('Back'),
        ),
      ),
    );
  }
}
