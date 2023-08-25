import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'vars.dart';

class InfoScreen extends StatefulWidget {
  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  void _openLinkInBrowser() async {
    Uri uriDonationUrl = Uri.parse(donationUrl);

    // Replace with your actual link
    if (await canLaunchUrl(uriDonationUrl)) {
      await launchUrl(uriDonationUrl);
    } else {
      _showErrorSnackBar();
    }
  }

  void _showErrorSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Could not launch the link.'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '''This app\nwas made\nBy\nDigital babushka\nto support project\nyou can donate'''
                        .toUpperCase(),
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.65),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 9.0,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _openLinkInBrowser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(
                          217, 217, 217, 1), // Button background color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20.0), // Rounded corners
                      ),
                    ),
                    child: Text('DONATE',
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w600,
                          letterSpacing: 32.0,
                          fontSize: 18,
                        )),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '''or just share this\napp with friends'''.toUpperCase(),
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.65),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 9.0,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.only(bottom: 40.0),
                decoration: BoxDecoration(
                    border: Border(
                  top: BorderSide(
                      color: Color.fromRGBO(255, 255, 255, 0.65), width: 5),
                  left: BorderSide(),
                  right: BorderSide(),
                  bottom: BorderSide(
                      color: Color.fromRGBO(255, 255, 255, 0.65), width: 5),
                )),
                alignment: Alignment.center,
                child: Text(
                  '''ABOUT\nAPP''',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.65),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 32.0,
                    fontSize: 50,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(top: 0, bottom: 40),
                // child: CircularOptionsWheel(
                //   options: ['Today', 'Yesterday', 'Week', 'Month', 'All Time'],
                //   dataList: dataList,
                //   // calculateAverage(dataList), // Implement this function
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
