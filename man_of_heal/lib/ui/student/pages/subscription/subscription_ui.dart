import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:man_of_heal/ui/components/black_rounded_container.dart';
import 'package:man_of_heal/ui/components/custom_container.dart';
import 'package:man_of_heal/ui/components/custom_header_row.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/utils/app_themes.dart';
import 'package:man_of_heal/utils/svgs.dart';

import 'subscription_body.dart';

class SubscriptionUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppThemes.BG_COLOR,
      body: Stack(
        fit: StackFit.expand,
        children: [
          /// black background
          Positioned(
            top: 0,
            height: 225,
            left: 0,
            right: 0,
            child:BlackRoundedContainer(),
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
               CustomHeaderRow(title: "Status", hasProfileIcon: true,),
                CustomContainer(
                  height: 65.h,
                  margin: EdgeInsets.only(
                    left: 17.0.w,
                    right: 17.0.w,
                    top: 80.h,
                  ),
                  padding: EdgeInsets.all(17.0.r),

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
                FormVerticalSpace(height: 30,),
                cardWidget("Standard", buildStandardSvg(), 99),
                cardWidget("Premium", buildPremiumSvg(), 179.99),
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

  Widget cardWidget(title,icon, price){
    return GestureDetector(
      onTap: () {
        Get.to(() => SubscriptionBody());
      },
      child: CustomContainer(
        margin: EdgeInsets.only(
          left: 17.0,
          right: 17.0,
          top: 30,
        ),
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: icon,
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
                          '$title',
                          style: AppThemes.buttonFont.copyWith(color: AppThemes.DEEP_ORANGE),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0.h),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '\$$price/month',
                          style: AppThemes.normalBlackFont,
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
    );
  }
}
