import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:frontend/components/atoms/button.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.fromLTRB(10, 80, 10, 80),
      child: Column(
        children: [
          Expanded(
            child: Center(
              // child: SvgPicture.asset(
              //   'images/logo.svg',
              //   width: 300,
              //   height: 300,
              // ),
              child: Image.asset('images/logo.png', width: 300, height: 300),
            ),
          ),
          Button(
            text: '続ける',
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
        ],
      ),
    );
  }
}
