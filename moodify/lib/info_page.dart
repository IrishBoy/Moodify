import 'package:flutter/material.dart';
import 'package:moodify/sql_connector.dart';
import 'package:url_launcher/url_launcher.dart';

import 'vars.dart';

class InfoScreen extends StatefulWidget {
  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  late DatabaseHelper dbHelper; // Define DatabaseHelper instance

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper(); // Initialize DatabaseHelper instance
  }

  void _openLinkInBrowser(link) async {
    Uri uriLink = Uri.parse(link);

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

  Future<void> _removeAllMeasurements() async {
    await dbHelper.deleteAllDataModels();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black, // Set the background color of the scaffold
      body: Ink(
        color: Colors.black, // Set the background color of the Ink
        child: ListView(
          children: [
            Container(
              color: Colors.black,
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.2),
                  SizedBox(
                    height: screenHeight * 0.2,
                    child: Text(
                      '''This app was made by Digital babushka to support a project you can donate'''
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
                  ),
                  // SizedBox(
                  //   height: screenHeight * 0.01,
                  // ),
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: () => _openLinkInBrowser(donationUrl),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(217, 217, 217, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
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
                  ),
                  // SizedBox(height: screenHeight * 0.01),
                  SizedBox(
                    height: screenHeight * 0.2,
                    child: Text(
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
                  ),
                  // SizedBox(height: 40),
                  SizedBox(
                    height: screenHeight * 0.1,
                    child: Text(
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
                  ),
                  // SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _openLinkInBrowser(digitalBabushkaUrl),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(217, 217, 217, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: Text('digital babushka'.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        )),
                  ),
                  SizedBox(
                    height: screenHeight * 0.1,
                    child: Text(
                      textWidthBasis: TextWidthBasis.longestLine,
                      '''You also can reset your measurements'''.toUpperCase(),
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.65),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 9.0,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _removeAllMeasurements(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(217, 217, 217, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: Text('Remove all the data'.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        )),
                  ),
                ],
              ),
            ),
            // Add new widgets here
          ],
        ),
      ),
    );
  }
}
