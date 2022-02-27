import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DailyActivityScreen extends StatefulWidget {
  const DailyActivityScreen({Key? key}) : super(key: key);

  @override
  _DailyActivityScreenState createState() => _DailyActivityScreenState();
}

class _DailyActivityScreenState extends State<DailyActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFEEFEC),
      body: Stack(
        fit: StackFit.expand,
        children: [
          /// black background
          Positioned(
            top: 0,
            height: 225,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20.04),
                ),
                color: Color(0xff1F1D1F),
              ),
            ),
          ),

          Positioned(
            top: 50,
            left: 10,
            right: 10,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        // child: Icon(
                        //   Icons.arrow_back_ios,
                        //   color: Colors.white,
                        // ),
                        child: IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: Icon(Icons.arrow_back_ios),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Daily Activity',
                            style: GoogleFonts.poppins(
                              fontSize: 23.85,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.calendar_today_sharp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 90,
                  margin: EdgeInsets.only(
                    left: 17.0,
                    right: 17.0,
                    top: 90,
                  ),
                  padding: EdgeInsets.all(17.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11.86),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFC7161C).withOpacity(0.22),
                        offset: Offset(0, 0),
                        blurRadius: 10.78,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Term Of The Day',
                            style: GoogleFonts.poppins(
                              fontSize: 17.46,
                              color: Color(0xffFC2125),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'DVT',
                            style: GoogleFonts.poppins(
                              fontSize: 14.28,
                              color: Colors.black.withOpacity(0.7),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 17.0,
                    right: 17.0,
                    top: 30,
                  ),
                  padding: EdgeInsets.all(17.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11.86),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFC7161C).withOpacity(0.22),
                        offset: Offset(0, 0),
                        blurRadius: 10.78,
                      ),
                    ],
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Question of the day',
                          style: GoogleFonts.poppins(
                            fontSize: 17.46,
                            color: Color(0xffFC2125),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo',
                          style: GoogleFonts.poppins(
                            fontSize: 14.28,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
