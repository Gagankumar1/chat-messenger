import 'package:chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
//import 'package:flutter/foundation.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const String id='welcome_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{
       late AnimationController controller;
       int? animation;
@override
void initState() {
  super.initState();
  controller =
      AnimationController(duration: const Duration(seconds: 1), vsync: this);
  ColorTween(begin: Colors.blueGrey, end: Colors.white).animate(controller);
  controller.forward();
  controller.addListener(() {
    setState(() {});
  });

}
@override
void dispose() {
  controller.dispose();
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                //Container
                Hero(tag: 'logo',
                  child: SizedBox(
                    height: 60.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                  TypewriterAnimatedTextKit(text:const ['Flash Chat'],

                  textStyle: const TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
           Padding(
             padding: const EdgeInsets.symmetric(vertical: 16.0),
             child: Material(
                  elevation: 5.0,
                  color: Colors.lightBlueAccent,
                   borderRadius: BorderRadius.circular(30.0),
              child: MaterialButton(
                onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
               minWidth: 200.0,
                height: 42.0,
               child: const Text(
                 'Log In',
              ),
             ),
           ),
         ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    //Go to registration screen.
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: const Text(
                    'Register',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
// class RoundedButton extends StatelessWidget {
//   //const RoundedButton({Key? key }) : super(key: key);
//   const RoundedButton({Key? key, required this.title, this.colour, required this.onPressed}) : super(key: key);
//   final Color colour;
//   final String title;
//   final Function onPressed;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 16.0),
//       child: Material(
//         elevation: 5.0,
//         color: Colors.colour,
//         borderRadius: BorderRadius.circular(30.0),
//         child: MaterialButton(
//           onPressed: onPressed;
//           minWidth: 200.0,
//           height: 42.0,
//           child: const Text(
//             title,
//           ),
//         ),
//       ),
//     );






