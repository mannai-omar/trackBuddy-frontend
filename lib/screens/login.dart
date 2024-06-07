import 'package:flutter/material.dart';
import 'package:trackbuddy/widgets/bottomNav.dart';
import 'package:trackbuddy/widgets/clipPathShadow.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f6f6),
      body: SafeArea(
        child: ListView(
          children: [
            stackedPapers(context),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sign in',
                    style: TextStyle(
                        color: Color(0xff000000),
                        fontSize: 30,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Email..',
                    ),
                    cursorColor: Color(0xffF26E56),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  const TextField(
                    
                    decoration: InputDecoration(
                      hintText: 'Password..',
                    ),
                    cursorColor: Color(0xffF26E56),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  loginButton(context)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector loginButton(BuildContext context) {
    return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomNav()),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    decoration: BoxDecoration(
                        color: const Color(0xffF26E56),
                        borderRadius: BorderRadius.circular(15)),
                    child: const Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Color(0xffffffff),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1),
                      ),
                    ),
                  ),
                );
  }

  Stack stackedPapers(BuildContext context) {
    return Stack(
      children: [
        ClipShadowPath(
          shadow: BoxShadow(
            color: Colors.grey.shade700,
            offset: Offset(4, 4),
            blurRadius: 4,
            spreadRadius: 4,
          ),
          clipper: Clipper(0.9, 0.7),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.45,
            decoration: const BoxDecoration(
              color: Color(0xff5694F2),
            ),
          ),
        ),
        ClipShadowPath(
          shadow: BoxShadow(
            color: Colors.grey.shade700,
            offset: Offset(4, 4),
            blurRadius: 4,
            spreadRadius: 4,
          ),
          clipper: Clipper(0.85, 0.8),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: const BoxDecoration(
              color: Color(0xffFFEC347),
            ),
          ),
        ),
        ClipShadowPath(
          shadow: BoxShadow(
            color: Colors.grey.shade700,
            offset: Offset(4, 4),
            blurRadius: 4,
            spreadRadius: 4,
          ),
          clipper: Clipper(0.7, 0.8),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: const BoxDecoration(
              color: Color(0xff52C0C3),
            ),
          ),
        ),
        ClipShadowPath(
          shadow: BoxShadow(
            color: Colors.grey.shade700,
            offset: Offset(4, 4),
            blurRadius: 4,
            spreadRadius: 4,
          ),
          clipper: Clipper(0.5, 0.75),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: const BoxDecoration(
              color: Color(0xffF06D55),
            ),
            child: Center( 
            child: Image.asset(
              'assets/logo.png',
              width: 150, 
              height: 150, 
            ),
          ),
          ),
        ),
      ],
    );
  }
}

class Clipper extends CustomClipper<Path> {
  final double h;
  final double w;
  Clipper(this.h, this.w);
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height);
    path_0.quadraticBezierTo(
        size.width / 5, size.height * 0.8, size.width / 2, size.height * 0.9);
    path_0.quadraticBezierTo(
        size.width * w, size.height, size.width, size.height * h);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(0, 0);
    path_0.close();

    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
