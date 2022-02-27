import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:man_of_heal/controllers/controllers_base.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/ui/components/primary_button.dart';
import 'package:man_of_heal/ui/profile/profile_ui.dart';
import 'package:man_of_heal/utils/app_themes.dart';
import 'package:man_of_heal/utils/svgs.dart';

import 'standart_subscription.dart';

class SubscriptionUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
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
            top: 50.sp,
            left: 10.sp,
            right: 10.sp,
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
                      flex: 4,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Status',
                            style: GoogleFonts.poppins(
                              fontSize: 23.85.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )),
                    ),
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            Get.to(ProfileUI());
                          },
                          child: Container(
                            height: 50.sp,
                            width: 50.sp,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Image.network(
                                  "https://cdn-icons-png.flaticon.com/128/3011/3011270.png"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 65.h,
                  margin: EdgeInsets.only(
                    left: 17.0.w,
                    right: 17.0.w,
                    top: 80.h,
                  ),
                  padding: EdgeInsets.all(17.0.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11.86.r),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFC7161C).withOpacity(0.22),
                        offset: Offset(0, 0),
                        blurRadius: 10.78,
                      ),
                    ],
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Pick your plan',
                      style: GoogleFonts.poppins(
                        fontSize: 23.85.sp,
                        color: Color(0xff1F1D1F).withOpacity(0.7),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(StandardSubscription());
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 17.0,
                      right: 17.0,
                      top: 60,
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
                    child: Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: buildStandardSvg(),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: 50.sp,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Standard',
                                      style: GoogleFonts.poppins(
                                        fontSize: 17.46.sp,
                                        color: Color(0xffFC2125),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.0.h),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '\$20/month',
                                      style: GoogleFonts.poppins(
                                        fontSize: 13.0.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(StandardSubscription());
                  },
                  child: Container(
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
                    child: Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: buildPremiumSvg(),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: 50.sp,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Premium',
                                      style: GoogleFonts.poppins(
                                        fontSize: 17.46.sp,
                                        color: Color(0xffFC2125),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.0.h),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '\$30/month',
                                      style: GoogleFonts.poppins(
                                        fontSize: 13.0.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: 20.0.sp,
                    top: 30.0.sp,
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Select and continue ',
                      style: TextStyle(
                        fontFamily: 'Poppins-Medium',
                        fontSize: 12.0.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 80.0.sp,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Text(
                        'Not now',
                        style: GoogleFonts.poppins(
                          fontSize: 23.85.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

// Widget _subscriptionPlans(_title, _noOfQuestions, _price, onPress) {
//   return Container(
//     width: 170,
//     child: Card(
//       elevation: 10,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       margin: EdgeInsets.all(10),
//       child: Column(
//         children: [
//           FormVerticalSpace(
//             height: 10,
//           ),
//           Container(
//             child: Text(
//               _title,
//               style: TextStyle(fontSize: 18, color: Colors.black),
//             ),
//           ),
//           FormVerticalSpace(),
//           Container(
//             child: Text(
//               '$_noOfQuestions Question in 72 hours.',
//               style: TextStyle(fontSize: 14),
//             ),
//           ),
//           FormVerticalSpace(
//             height: 10,
//           ),
//           Container(
//             child: Text(
//               '\$$_price /month',
//               style: TextStyle(fontSize: 20, color: Colors.deepPurple),
//             ),
//           ),
//           FormVerticalSpace(
//             height: 15,
//           ),
//           PrimaryButton(
//             labelText: "Select",
//             onPressed: () {
//               subscriptionController.createSubscription(
//                   _title, _price, _noOfQuestions);
//               Get.back();
//             },
//           ),
//         ],
//       ),
//     ),
//   );
// }
}
