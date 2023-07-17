import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension ColorExtension on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}

class AppThemes {
  AppThemes._(); //this is to prevent anyone from instantiating this object

  static const Color dodgerBlue = Color.fromRGBO(29, 161, 242, 1.0);
  static const Color dodgerPurple = Color.fromRGBO(106, 35, 206, 1.0);
  static const Color whiteLilac = Color.fromRGBO(248, 250, 252, 1);

  // static const Color blackPearl = Color.fromRGBO(30, 31, 43, 1);
  //static Color blackPearl = "#2f3335".toColor();

  static const Color brinkPink = Color.fromRGBO(255, 97, 136, 1);
  static const Color juneBud = Color.fromRGBO(186, 215, 97, 1);
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color nevada = Color.fromRGBO(105, 109, 119, 1);
  static const Color ebonyClay = Color.fromRGBO(40, 42, 58, 1);

  // static const DEEP_ORANGE = Colors.deepOra(nge;

  static const blackPearl = Color(0xff1F1D1F);

  //static const DEEP_ORANGE = Color.fromRGBO(239, 70, 69, 1);
  //static const DEEP_ORANGE = Color(0xFFC7161C);
  static const DEEP_ORANGE = Color(0xffFC2125);
  static const BLACK_TOP_CARD = Color.fromRGBO(47, 51, 53, 1);

  //static const BG_COLOR = Color.fromRGBO(254, 239, 235, 1);
  static const BG_COLOR = Color(0xffFEEFEC);

  //static const BG_COLOR = Color(0xfeefeb);
  static const TABS_BG_COLOR = Color.fromRGBO(251, 212, 207, 1);
  static const PREMIUM_OPTION_COLOR = Color.fromRGBO(244, 141, 38, 1);

  static Color gradientColor_1 = '#ef4645'.toColor();
  static Color gradientColor_2 = '#f16c51'.toColor();

  static Color rightAnswerColor = '#49b85f'.toColor();

  static String font1 = "Montserrat";
  static String font2 = "Poppins";

  //constants color range for light theme
  //main color
  static const Color _lightPrimaryColor = dodgerPurple;

  /// Fonts
  static var headerTitleFont = GoogleFonts.poppins(
    fontSize: 23.85,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static var headerTitleBlackFont = GoogleFonts.poppins(
    fontSize: 23.85,
    fontWeight: FontWeight.bold,
    color: blackPearl,
  );

  static var dialogTitleHeader = GoogleFonts.poppins(
      color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold);

  static var headerItemTitle = GoogleFonts.poppins(
      fontSize: 16.73,
      fontWeight: FontWeight.w600,
      color: AppThemes.blackPearl);

  static var header1 = GoogleFonts.poppins(
      fontWeight: FontWeight.w700, fontSize: 28, color: AppThemes.DEEP_ORANGE);

  static var buttonFont = GoogleFonts.poppins(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static var header2 =
      GoogleFonts.poppins(fontSize: 14.24, fontWeight: FontWeight.w700);
  static var header4 = GoogleFonts.poppins(
    fontSize: 14.28,
    color: Colors.black.withOpacity(0.7),
    fontWeight: FontWeight.w500,
  );

  static var headerTitle = GoogleFonts.poppins(
      fontSize: 17.46,
      color: AppThemes.DEEP_ORANGE,
      fontWeight: FontWeight.w700);
  static var header3 =
      GoogleFonts.poppins(fontSize: 15.94, fontWeight: FontWeight.bold);

  /// normal size
  static var normalBlackFont = GoogleFonts.poppins(
      color: blackPearl, fontSize: 13, fontWeight: FontWeight.w600);
  static var normalBlack45Font = GoogleFonts.poppins(
      color: Colors.black45, fontSize: 13, fontWeight: FontWeight.w600);
  static var normalORANGEFont = GoogleFonts.poppins(
      color: DEEP_ORANGE, fontSize: 13, fontWeight: FontWeight.w600);

  static var captionFont = GoogleFonts.poppins(
      color: blackPearl,
      fontSize: 11,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.italic);

  //Background Colors
  static const Color _lightBackgroundColor = whiteLilac;
  static const Color _lightBackgroundAppBarColor = _lightPrimaryColor;
  static const Color _lightBackgroundSecondaryColor = white;
  static Color _lightBackgroundAlertColor = blackPearl;
  static const Color _lightBackgroundActionTextColor = white;

  // static const Color _lightBackgroundErrorColor = brinkPink;
//  static const Color _lightBackgroundSuccessColor = juneBud;

  //Text Colors
  static const Color _lightTextColor = Colors.black;

  //static const Color _lightAlertTextColor = Colors.black;
  //static const Color _lightTextSecondaryColor = Colors.black;

  //Border Color
  static const Color _lightBorderColor = nevada;

  //Icon Color
  static const Color _lightIconColor = nevada;

  //form input colors
  //static const Color _lightInputFillColor = _lightBackgroundSecondaryColor;
  static const Color _lightBorderActiveColor = _lightPrimaryColor;
  static const Color _lightBorderErrorColor = brinkPink;

  //constants color range for dark theme
  static const Color _darkPrimaryColor = dodgerPurple;

  //Background Colors
  static const Color _darkBackgroundColor = BG_COLOR;
  static const Color _darkBackgroundAppBarColor = _darkPrimaryColor;
  static const Color _darkBackgroundSecondaryColor =
      Color.fromRGBO(0, 0, 0, .6);
  static Color _darkBackgroundAlertColor = blackPearl;
  static const Color _darkBackgroundActionTextColor = white;

  //static const Color _darkBackgroundErrorColor = Color.fromRGBO(255, 97, 136, 1);
  //static const Color _darkBackgroundSuccessColor = Color.fromRGBO(186, 215, 97, 1);

  //Text Colors
  static const Color _darkTextColor = Colors.white;

  //static const Color _darkAlertTextColor = Colors.black;
  // static const Color _darkTextSecondaryColor = Colors.black;

  //Border Color
  static const Color _darkBorderColor = nevada;

  //Icon Color
  static const Color _darkIconColor = nevada;

  static const Color _darkInputFillColor = _darkBackgroundSecondaryColor;
  static const Color _darkBorderActiveColor = _darkPrimaryColor;
  static const Color _darkBorderErrorColor = brinkPink;

  //text theme for light theme
  static final TextTheme _lightTextTheme = TextTheme(
    headlineLarge: TextStyle(fontSize: 20.0, color: _lightTextColor),
    bodyLarge: TextStyle(fontSize: 16.0, color: _lightTextColor),
    bodyMedium: TextStyle(fontSize: 14.0, color: Colors.grey),
    labelLarge: TextStyle(
        fontSize: 15.0, color: _lightTextColor, fontWeight: FontWeight.w600),
    headlineSmall: TextStyle(fontSize: 16.0, color: _lightTextColor),
    labelMedium: TextStyle(fontSize: 13.0, color: _lightTextColor),
    labelSmall: TextStyle(fontSize: 12.0, color: _lightBackgroundAppBarColor),
  );

  //the light theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: font1,
    scaffoldBackgroundColor: _lightBackgroundColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _lightPrimaryColor,
    ),
    appBarTheme: AppBarTheme(
      color: _lightBackgroundAppBarColor,
      iconTheme: IconThemeData(color: _lightTextColor),
      toolbarTextStyle: _lightTextTheme.bodyMedium,
      titleTextStyle: _lightTextTheme.headlineSmall,
    ),
    colorScheme: ColorScheme.light(
      primary: _lightPrimaryColor,
      // secondary: _lightSecondaryColor,
    ),
    snackBarTheme: SnackBarThemeData(
        backgroundColor: _lightBackgroundAlertColor,
        actionTextColor: _lightBackgroundActionTextColor),
    iconTheme: IconThemeData(
      color: _lightIconColor,
    ),
    popupMenuTheme: PopupMenuThemeData(color: _lightBackgroundAppBarColor),
    textTheme: _lightTextTheme,
    buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        buttonColor: _lightPrimaryColor,
        textTheme: ButtonTextTheme.primary),
    unselectedWidgetColor: _lightPrimaryColor,
    inputDecorationTheme: InputDecorationTheme(
      //prefixStyle: TextStyle(color: _lightIconColor),
      border: OutlineInputBorder(
          borderSide: BorderSide(width: 1.0),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          )),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _lightBorderColor, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _lightBorderActiveColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _lightBorderErrorColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _lightBorderErrorColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      fillColor: _lightBackgroundSecondaryColor,
      //focusColor: _lightBorderActiveColor,
    ),
  );

//text theme for dark theme
  /*static final TextStyle _darkScreenHeadingTextStyle =
      _lightScreenHeadingTextStyle.copyWith(color: _darkTextColor);
  static final TextStyle _darkScreenTaskNameTextStyle =
      _lightScreenTaskNameTextStyle.copyWith(color: _darkTextColor);
  static final TextStyle _darkScreenTaskDurationTextStyle =
      _lightScreenTaskDurationTextStyle;
  static final TextStyle _darkScreenButtonTextStyle = TextStyle(
      fontSize: 14.0, color: _darkTextColor, fontWeight: FontWeight.w500);
  static final TextStyle _darkScreenCaptionTextStyle = TextStyle(
      fontSize: 12.0,
      color: _darkBackgroundAppBarColor,
      fontWeight: FontWeight.w100);*/

  static final TextTheme _darkTextTheme = TextTheme(
    headlineLarge: TextStyle(fontSize: 30.0, color: _darkTextColor),
    headlineMedium: TextStyle(fontSize: 22.0, color: _darkTextColor),
    headlineSmall: TextStyle(fontSize: 16.0, color: _darkTextColor),
    bodyLarge: TextStyle(fontSize: 16.0, color: _darkTextColor),
    bodySmall: TextStyle(fontSize: 14.0, color: Colors.grey),
    bodyMedium: TextStyle(
        fontSize: 15.0, color: _darkTextColor, fontWeight: FontWeight.w600),
    labelLarge: TextStyle(fontSize: 16.0, color: _darkTextColor),
    labelSmall: TextStyle(fontSize: 12.0, color: _darkBackgroundAppBarColor),
  );

  //the dark theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    //prefix icon color form input on focus
    fontFamily: font1,
    scaffoldBackgroundColor: _darkBackgroundColor,

    chipTheme: ChipThemeData(
      backgroundColor: Colors.white,
      selectedColor: Colors.red,
      secondaryLabelStyle: TextStyle(),
      brightness: Brightness.dark,
      disabledColor: Colors.transparent,
      labelStyle: TextStyle(),
      padding: EdgeInsets.all(10),
      secondarySelectedColor: Colors.black,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _darkPrimaryColor,
    ),
    appBarTheme: AppBarTheme(
      //color: _darkBackgroundAppBarColor,
      iconTheme: IconThemeData(color: _darkTextColor),
      toolbarTextStyle: _darkTextTheme.bodyMedium,
      titleTextStyle: _darkTextTheme.headlineMedium,
    ),
    snackBarTheme: SnackBarThemeData(
        contentTextStyle: TextStyle(color: Colors.white),
        backgroundColor: _darkBackgroundAlertColor,
        actionTextColor: _darkBackgroundActionTextColor),
    iconTheme: IconThemeData(
      color: _darkIconColor, //_darkIconColor,
    ),
    popupMenuTheme: PopupMenuThemeData(color: _darkBackgroundAppBarColor),
    textTheme: _darkTextTheme,
    buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        buttonColor: _darkPrimaryColor,
        textTheme: ButtonTextTheme.primary),
    unselectedWidgetColor: _darkPrimaryColor,
    inputDecorationTheme: InputDecorationTheme(
      prefixStyle: TextStyle(color: _darkIconColor),
      //labelStyle: TextStyle(color: nevada),
      border: OutlineInputBorder(
          borderSide: BorderSide(width: 1.0),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          )),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _darkBorderColor, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _darkBorderActiveColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _darkBorderErrorColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _darkBorderErrorColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      fillColor: _darkInputFillColor,
      //focusColor: _darkBorderActiveColor,
    ),
    colorScheme: ColorScheme.dark(
      primary: _darkPrimaryColor,

      // secondary: _darkSecondaryColor,
    ).copyWith(secondary: _darkPrimaryColor),
  );
}
