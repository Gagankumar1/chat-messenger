import 'package:chat/screens/chat_screen.dart';
import 'package:chat/screens/login_screen.dart';
import 'package:chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:chat/screens/welcome_screen.dart';
 //import 'package:chat/screens/chat_screen.dart';

void main() => runApp(const FlashChat());

class FlashChat extends StatelessWidget {
  const FlashChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context)=>const WelcomeScreen(),
        LoginScreen.id: (context)=>const LoginScreen(),
        RegistrationScreen.id: (context)=>const RegistrationScreen(),
        ChatScreen.id: (context)=> const ChatScreen(),
      },
    );
  }
}