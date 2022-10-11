import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:man_of_heal/models/lab_model.dart';
import 'package:man_of_heal/ui/components/black_rounded_container.dart';
import 'package:man_of_heal/ui/components/custom_container.dart';
import 'package:man_of_heal/ui/components/custom_header_row.dart';
import 'package:man_of_heal/ui/components/form_vertical_spacing.dart';
import 'package:man_of_heal/utils/AppConstant.dart';
import 'package:man_of_heal/utils/app_themes.dart';

class LabDetails extends StatelessWidget {
  final LabModel labModel;

  LabDetails(this.labModel);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: detailsLabBody(context),
      ),
    );
  }

  Widget detailsLabBody(context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          height: 225,
          top: 0,
          right: 0,
          left: 0,
          child: BlackRoundedContainer(),
        ),
        Positioned(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: AlwaysScrollableScrollPhysics(),
            children: [
              FormVerticalSpace(),
              CustomHeaderRow(
                title: "Status",
                hasProfileIcon: true,
              ),
              FormVerticalSpace(),
              Container(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Image.network(
                    labModel.imageIconUrl!,
                  ),
                ),
              ),
              CustomContainer(
                height: AppConstant.getScreenHeight(context) * 0.55,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _headerWidget(),
                        FormVerticalSpace(),
                        SingleChildScrollView(
                          child: Text(
                            labModel.longDescription!,
                            style: AppThemes.normalBlack45Font,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _headerWidget() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${labModel.title}',
              style: GoogleFonts.poppins(
                  fontSize: 22.22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            FormVerticalSpace(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  'By ${labModel.adminName}',
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black45),
                ),
                SizedBox(
                  width: 30,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Image.asset(
                          "assets/icons/estimated_time_green_icon.png",
                          width: 12,
                        ),
                      ),
                      TextSpan(
                        text:
                            "  ${AppConstant.formattedDataTime("MM.dd.yyyy", labModel.createdDate!)}",
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black45),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
