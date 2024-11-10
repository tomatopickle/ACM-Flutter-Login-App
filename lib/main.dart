import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeData light = FlexThemeData.light(
      scheme: FlexScheme.money,
      subThemesData: const FlexSubThemesData(
        interactionEffects: true,
        tintedDisabledControls: true,
        useM2StyleDividerInM3: true,
        appBarBackgroundSchemeColor: SchemeColor.background ,
        inputDecoratorIsFilled: true,
        inputDecoratorBorderType: FlexInputBorderType.outline,
        alignedDropdown: true,
        navigationRailUseIndicator: true,
        navigationRailLabelType: NavigationRailLabelType.all,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
    );
    ThemeData dark = FlexThemeData.dark(
      scheme: FlexScheme.money,
      subThemesData: const FlexSubThemesData(
        blendOnColors: true,
        inputDecoratorIsFilled: true,
        alignedDropdown: true,
        tooltipRadius: 4,
        tooltipSchemeColor: SchemeColor.inverseSurface,
        tooltipOpacity: 0.9,
        snackBarElevation: 6,
        snackBarBackgroundSchemeColor: SchemeColor.inverseSurface,
        navigationRailUseIndicator: true,
        navigationRailLabelType: NavigationRailLabelType.all,
      ),
      keyColors: const FlexKeyColors(),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
    );
// dark =     ThemeData(
//       useMaterial3: true,
//
//       // Define the default brightness and colors.
//       colorScheme: ColorScheme.fromSeed(
//         seedColor: Colors.greenAccent,
//         // ···
//         brightness: Brightness.dark,
//       ),
//     );
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        title: 'Login App',
        theme: light,
        // The Mandy red, dark theme.
        darkTheme: dark,
        routes: {
          '/loggedInPage': (context) => const LoggedInPage(),
          '/': (context) => const MyHomePage(),
          '/loginPage': (context) => const LoginPage(),
          '/passwordResetPage': (context) => const PasswordResetPage(),
          '/signUpPage': (context) => const SignUpPage(),
        },
      );
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        Navigator.pushNamed(context, '/loggedInPage');
        print(user.uid);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 70,
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset("assets/images/app_logo.jpg"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, bottom: 2),
                  child: Text("ACM App"),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
              top: 0,
              left: MediaQuery.of(context).size.width > 900 ? (35.w) : 45,
              right:  MediaQuery.of(context).size.width > 900 ? (35.w ): 45,
              bottom: 4.h),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 8,
                child: SvgPicture.asset(
                  // height: 52.h,
                  fit: BoxFit.fitHeight,
                  'assets/images/welcome_image.svg',
                  semanticsLabel: 'Welcome Image',
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Welcome",
                  textAlign: TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Opacity(
                      opacity: .5,
                      child: Text(
                          "This is a simple login/register app, your data is saved in a Firebase database"))),
              Spacer(
                flex: 1,
              ),
              FilledButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(
                        50), // fromHeight use double.infinity as width and 40 is the height
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/signUpPage");
                  },
                  child: Text("Sign Up")),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Center(
                  child: Opacity(
                      opacity: .7, child: Text("Already have an account?")),
                ),
              ),
              FilledButton.tonal(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(
                        50), // fromHeight use double.infinity as width and 40 is the height
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/loginPage");
                  },
                  child: Text("Login")),
            ],
          ),
        ));
  }
}

class LoggedInPage extends StatelessWidget {
  const LoggedInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              size: 180,
              color: Colors.greenAccent,
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "Logged in as",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              height: 15,
            ),
            StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  return Text(
                      style: Theme.of(context).textTheme.titleLarge,
                      snapshot.data?.email ?? "Error");
                }),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamed(context, '/');
                },
                child: Text("Log Out"))
          ],
        ),
      ),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width > 900 ? (33.w) : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Card(
                  child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Opacity(
                        opacity: .8,
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Sign Up",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(fontSize: 25),
                            )),
                      ),
                      SizedBox(height: 35),
                      TextFormField(
                        controller: EmailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            label: Text("Email"),
                            filled: true,
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          RegExp emailRegex = RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                          if (!emailRegex.hasMatch(value)) {
                            return "Invalid email address";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        controller: PasswordController,
                        decoration: InputDecoration(
                            label: Text("Password"),
                            errorMaxLines: 2,
                            filled: true,
                            border: OutlineInputBorder()),
                        validator: (value) {
                          RegExp regex =
                              RegExp(r'^(?=.*[0-9])(?=.*[a-zA-Z]{8,}).+$');
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          } else if (value.length < 9) {
                            return 'Password have at least 9 characters';
                          } else if (!regex.hasMatch(value)) {
                            return 'Password needs to have at least 8 alphabets and a number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      FilledButton(
                        style: FilledButton.styleFrom(
                          minimumSize: Size.fromHeight(50),
                        ),
                        onPressed: loading
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  try {
                                    final credential = await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                      email: EmailController
                                          .text, //fake email given so that firebase accepts it
                                      password: PasswordController.text,
                                    );
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'weak-password') {
                                      print('The password provided is too weak.');
                                    } else if (e.code == 'email-already-in-use') {
                                      print(
                                          'The account already exists for that email.');
                                      _showMyDialog('Registration Error',
                                          'Username taken.', context);
                                    }
                                  } catch (e) {
                                    print(e);
                                  }

                                  setState(() {
                                    loading = false;
                                  });
                                }
                              },
                        child: loading
                            ? Transform.scale(
                                scale: .7,
                                child: CircularProgressIndicator(),
                              )
                            : Text('Register'),
                      ),
                    ],
                  ),
                ),
              )),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _showMyDialog(
    String title, String error, BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(error),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController EmailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Password Reset"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Enter email:")),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: EmailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            label: Text("Email"),
                            filled: true,
                            border: OutlineInputBorder()),
                        validator: (value) {
                          RegExp emailRegex = RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          if (!emailRegex.hasMatch(value)) {
                            return "Invalid email address";
                          }

                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: Opacity(
                          opacity: .7,
                          child: Text(
                              "If the email is connected to a user, we will send an email where you can reset the password")),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    FilledButton(
                        style: FilledButton.styleFrom(
                          minimumSize: Size.fromHeight(50),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            try {
                              FirebaseAuth.instance
                                  .sendPasswordResetEmail(
                                      email: EmailController.text)
                                  .then((value) => {
                                        _showMyDialog(
                                                "Email Sent",
                                                "Check your inbox for the reset password mail",
                                                context)
                                            .then((value) =>
                                                Navigator.pushNamed(
                                                    context, '/'))
                                      })
                                  .catchError((e) => _showMyDialog(
                                      "Invalid Email",
                                      "This email has not made an account",
                                      context));
                            } catch (e) {
                              ;
                            }
                            ;
                          }
                        },
                        child: Text("Reset Password"))
                  ],
                )
              ]),
        ));
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width > 900 ? (33.w) : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Card(
                  child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Opacity(
                        opacity: .8,
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Login",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(fontSize: 25),
                            )),
                      ),
                      SizedBox(height: 35),
                      TextFormField(
                        controller: EmailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            label: Text("Email"),
                            filled: true,
                            border: OutlineInputBorder()),
                        validator: (value) {
                          RegExp emailRegex = RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          if (!emailRegex.hasMatch(value)) {
                            return "Invalid email address";
                          }

                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        controller: PasswordController,
                        decoration: InputDecoration(
                            label: Text("Password"),
                            errorMaxLines: 2,
                            filled: true,
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/passwordResetPage");
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 7.5, horizontal: 2),
                            child: Opacity(
                                opacity: .5, child: Text("Forgot Password?")),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      FilledButton(
                        style: FilledButton.styleFrom(
                          minimumSize: Size.fromHeight(50),
                        ),
                        onPressed: loading
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  try {
                                    UserCredential userCredential =
                                        await FirebaseAuth
                                            .instance
                                            .signInWithEmailAndPassword(
                                                email: EmailController.text,
                                                password:
                                                    PasswordController.text);
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'user-not-found') {
                                      print('No user found for that email.');
                                      _showMyDialog("Login Error",
                                          "Invalid Email", context);
                                    } else if (e.code == 'wrong-password') {
                                      _showMyDialog("Login Error",
                                          "Wrong Password", context);
                                      print(
                                          'Wrong password provided for that user.');
                                    }
                                  } catch (e) {
                                    // Handle other exceptions, e.g., network errors, etc.
                                    _showMyDialog(
                                        "Error",
                                        "An error occurred. Please try again later.",
                                        context);
                                  }
                                  setState(() {
                                    loading = false;
                                  });
                                }
                              },
                        child: loading
                            ? Transform.scale(
                                scale: .7,
                                child: CircularProgressIndicator(),
                              )
                            : const Text('Login'),
                      ),
                    ],
                  ),
                ),
              )),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
