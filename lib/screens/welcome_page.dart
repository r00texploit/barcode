import 'package:barcodesystem/screens/sign_in_page.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 40, bottom: 10, left: 10, right: 10),
              child: Column(
                children: const [
                  Text(
                    'Bar Code System',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrangeAccent),
                  )
                ],
              ),
            ),
            Center(
              child: TextButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.only(
                        top: 10, bottom: 10, left: 60, right: 60)),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blueAccent),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ))),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: const Text(
                  'sign in ',
                  style: TextStyle(fontSize: 14.0, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
