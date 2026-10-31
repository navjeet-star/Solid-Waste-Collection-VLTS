import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Solid Waste Collection VLTS'**
  String get appTitle;

  /// No description provided for @vltsOnline.
  ///
  /// In en, this message translates to:
  /// **'VLTS ONLINE'**
  String get vltsOnline;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @loginToYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Login to your account'**
  String get loginToYourAccount;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter email'**
  String get enterEmail;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get enterPassword;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterYourEmail;

  /// No description provided for @enterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterYourPassword;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @forgotPasswordPrompt.
  ///
  /// In en, this message translates to:
  /// **'Please contact your Fleet Supervisor or Administrator to reset your password.'**
  String get forgotPasswordPrompt;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @loginSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Login successfully'**
  String get loginSuccessfully;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @signUpToGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Sign up to get started'**
  String get signUpToGetStarted;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @enterFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter full name'**
  String get enterFullName;

  /// No description provided for @enterYourFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get enterYourFullName;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @enterConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get enterConfirmPassword;

  /// No description provided for @enterYourConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get enterYourConfirmPassword;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @signUpSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully'**
  String get signUpSuccessfully;

  /// No description provided for @departmentName.
  ///
  /// In en, this message translates to:
  /// **'Urban Development & Housing Department'**
  String get departmentName;

  /// No description provided for @footerTagline.
  ///
  /// In en, this message translates to:
  /// **'Fleet Tracking & Route Monitoring • v1.0.4'**
  String get footerTagline;

  /// No description provided for @switchToLightMode.
  ///
  /// In en, this message translates to:
  /// **'Switch to Light Mode'**
  String get switchToLightMode;

  /// No description provided for @switchToDarkMode.
  ///
  /// In en, this message translates to:
  /// **'Switch to Dark Mode'**
  String get switchToDarkMode;

  /// No description provided for @profileClicked.
  ///
  /// In en, this message translates to:
  /// **'Profile clicked'**
  String get profileClicked;

  /// No description provided for @notificationsClicked.
  ///
  /// In en, this message translates to:
  /// **'Notifications clicked'**
  String get notificationsClicked;

  /// No description provided for @homeScreen.
  ///
  /// In en, this message translates to:
  /// **'Home Screen'**
  String get homeScreen;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @preview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get preview;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @overviewTitle1.
  ///
  /// In en, this message translates to:
  /// **'Door-to-Door Waste Collection and Monitoring System'**
  String get overviewTitle1;

  /// No description provided for @overviewDesc1.
  ///
  /// In en, this message translates to:
  /// **'A smart system designed to manage, monitor, and track door-to-door waste collection activities efficiently, ensuring cleaner surroundings and better waste management.'**
  String get overviewDesc1;

  /// No description provided for @overviewTitle2.
  ///
  /// In en, this message translates to:
  /// **'SBM Waste Collection Management System'**
  String get overviewTitle2;

  /// No description provided for @overviewDesc2.
  ///
  /// In en, this message translates to:
  /// **'An integrated waste collection management system that helps monitor collection activities, manage operations, and support the vision of a clean and sustainable India under the Swachh Bharat Mission (SBM).'**
  String get overviewDesc2;

  /// No description provided for @overviewTitle3.
  ///
  /// In en, this message translates to:
  /// **'Real-Time Vehicle Tracking & Route Analytics'**
  String get overviewTitle3;

  /// No description provided for @overviewDesc3.
  ///
  /// In en, this message translates to:
  /// **'Track waste collection vehicles in real time with GPS, optimize daily pickup routes, and monitor landfill operations with complete transparency.'**
  String get overviewDesc3;

  /// No description provided for @doorToDoorService.
  ///
  /// In en, this message translates to:
  /// **'DOOR-TO-DOOR SERVICE'**
  String get doorToDoorService;

  /// No description provided for @collecting.
  ///
  /// In en, this message translates to:
  /// **'COLLECTING'**
  String get collecting;

  /// No description provided for @routeTracked.
  ///
  /// In en, this message translates to:
  /// **'ROUTE TRACKED'**
  String get routeTracked;

  /// No description provided for @wetWaste.
  ///
  /// In en, this message translates to:
  /// **'WET'**
  String get wetWaste;

  /// No description provided for @dryWaste.
  ///
  /// In en, this message translates to:
  /// **'DRY'**
  String get dryWaste;

  /// No description provided for @swachhBharatMission.
  ///
  /// In en, this message translates to:
  /// **'SWACHH BHARAT MISSION (SBM)'**
  String get swachhBharatMission;

  /// No description provided for @bioWaste.
  ///
  /// In en, this message translates to:
  /// **'BIO'**
  String get bioWaste;

  /// No description provided for @recycleWaste.
  ///
  /// In en, this message translates to:
  /// **'RECYCLE'**
  String get recycleWaste;

  /// No description provided for @hazardWaste.
  ///
  /// In en, this message translates to:
  /// **'HAZARD'**
  String get hazardWaste;

  /// No description provided for @sbmHub.
  ///
  /// In en, this message translates to:
  /// **'SBM VLTS HUB'**
  String get sbmHub;

  /// No description provided for @cleanCityKpi.
  ///
  /// In en, this message translates to:
  /// **'Clean City KPI'**
  String get cleanCityKpi;

  /// No description provided for @smartSanitation.
  ///
  /// In en, this message translates to:
  /// **'SMART SANITATION'**
  String get smartSanitation;

  /// No description provided for @realTimeTracking.
  ///
  /// In en, this message translates to:
  /// **'REAL-TIME GPS TRACKING'**
  String get realTimeTracking;

  /// No description provided for @activeFleet.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE FLEET'**
  String get activeFleet;

  /// No description provided for @onRoute.
  ///
  /// In en, this message translates to:
  /// **'ON ROUTE'**
  String get onRoute;

  /// No description provided for @routeOptimized.
  ///
  /// In en, this message translates to:
  /// **'ROUTE OPTIMIZED'**
  String get routeOptimized;

  /// No description provided for @transferStation.
  ///
  /// In en, this message translates to:
  /// **'TRANSFER STATION'**
  String get transferStation;

  /// No description provided for @fleetTrackingSample.
  ///
  /// In en, this message translates to:
  /// **'Fleet #08 • Sector 4B'**
  String get fleetTrackingSample;

  /// No description provided for @wasteCollectedThisMonth.
  ///
  /// In en, this message translates to:
  /// **'Waste Collected This Month'**
  String get wasteCollectedThisMonth;

  /// No description provided for @targetProgressSummary.
  ///
  /// In en, this message translates to:
  /// **'of 3,500 MT Target • 67% • 8 Zones Active'**
  String get targetProgressSummary;

  /// No description provided for @totalUlbs.
  ///
  /// In en, this message translates to:
  /// **'Total ULB(s)'**
  String get totalUlbs;

  /// No description provided for @totalWards.
  ///
  /// In en, this message translates to:
  /// **'Total Wards'**
  String get totalWards;

  /// No description provided for @registeredFleet.
  ///
  /// In en, this message translates to:
  /// **'Registered Fleet'**
  String get registeredFleet;

  /// No description provided for @collectionTrend.
  ///
  /// In en, this message translates to:
  /// **'Collection Trend • October'**
  String get collectionTrend;

  /// No description provided for @collectionTrendRange.
  ///
  /// In en, this message translates to:
  /// **'0 — 140 MT daily'**
  String get collectionTrendRange;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @wetWasteTitle.
  ///
  /// In en, this message translates to:
  /// **'Wet / Organic Waste'**
  String get wetWasteTitle;

  /// No description provided for @wetWasteSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Kitchen, food & market organic waste'**
  String get wetWasteSubtitle;

  /// No description provided for @dryWasteTitle.
  ///
  /// In en, this message translates to:
  /// **'Dry / Recyclable Waste'**
  String get dryWasteTitle;

  /// No description provided for @dryWasteSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Plastic, paper, metal & glass items'**
  String get dryWasteSubtitle;

  /// No description provided for @hazardousWasteTitle.
  ///
  /// In en, this message translates to:
  /// **'Hazardous & Sanitary'**
  String get hazardousWasteTitle;

  /// No description provided for @hazardousWasteSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Chemical, medical & sanitary waste'**
  String get hazardousWasteSubtitle;

  /// No description provided for @inertWasteTitle.
  ///
  /// In en, this message translates to:
  /// **'Inert & Construction Debris'**
  String get inertWasteTitle;

  /// No description provided for @inertWasteSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Road dust, silt, building rubble'**
  String get inertWasteSubtitle;

  /// No description provided for @fleetOperations.
  ///
  /// In en, this message translates to:
  /// **'Live Fleet & Ward Status'**
  String get fleetOperations;

  /// No description provided for @wardNorth.
  ///
  /// In en, this message translates to:
  /// **'Ward 12 • North Zone'**
  String get wardNorth;

  /// No description provided for @wardCentral.
  ///
  /// In en, this message translates to:
  /// **'Ward 07 • Central Market'**
  String get wardCentral;

  /// No description provided for @wardEast.
  ///
  /// In en, this message translates to:
  /// **'Ward 04 • East Enclave'**
  String get wardEast;

  /// No description provided for @truckCollectingStatus.
  ///
  /// In en, this message translates to:
  /// **'Collecting • 88% complete'**
  String get truckCollectingStatus;

  /// No description provided for @truckEnRouteStatus.
  ///
  /// In en, this message translates to:
  /// **'En route to Transfer Station'**
  String get truckEnRouteStatus;

  /// No description provided for @truckCompletedStatus.
  ///
  /// In en, this message translates to:
  /// **'Route Completed • 24.2 MT'**
  String get truckCompletedStatus;

  /// No description provided for @monthSelector.
  ///
  /// In en, this message translates to:
  /// **'October 2026'**
  String get monthSelector;

  /// No description provided for @compactHeaderTitle.
  ///
  /// In en, this message translates to:
  /// **'Waste Summary • 2,348 MT'**
  String get compactHeaderTitle;

  /// No description provided for @profileRole.
  ///
  /// In en, this message translates to:
  /// **'Fleet Operations Manager'**
  String get profileRole;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @routeAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Route Analytics'**
  String get routeAnalytics;

  /// No description provided for @vehicleTracking.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Tracking'**
  String get vehicleTracking;

  /// No description provided for @reports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reports;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
