import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'vars.dart';

class InfoScreen extends StatefulWidget {
  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  void _openLinkInBrowser(link) async {
    Uri uriLink = Uri.parse(link);

    // Replace with your actual link
    if (await canLaunchUrl(uriLink)) {
      await launchUrl(uriLink);
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '''This app was made by Digital babushka to support project you can donate'''
                        .toUpperCase(),
                    textWidthBasis: TextWidthBasis.longestLine,
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.65),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 9.0,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _openLinkInBrowser(donationUrl),
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
                    textWidthBasis: TextWidthBasis.longestLine,
                    '''or just share this\napp with friends'''.toUpperCase(),
                    style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.65),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 9.0,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                  Text(
                    textWidthBasis: TextWidthBasis.longestLine,
                    '''about authors'''.toUpperCase(),
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
                    onPressed: () => _openLinkInBrowser(digitalBabushkaUrl),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(
                          217, 217, 217, 1), // Button background color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20.0), // Rounded corners
                      ),
                    ),
                    child: Text('digital babushka'.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w600,
                          // letterSpacing: 32.0,
                          fontSize: 18,
                        )),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.only(bottom: 20.0),
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
                  textWidthBasis: TextWidthBasis.longestLine,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  "About Moodify".trim().toUpperCase(),
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.65),
                    fontWeight: FontWeight.w600,
                    // letterSpacing: 32.0,
                    fontSize: 50,
                  ),
                  // textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(top: 0, bottom: 40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
