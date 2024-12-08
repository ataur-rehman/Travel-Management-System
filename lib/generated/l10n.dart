// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Choose date`
  String get chooseDate {
    return Intl.message(
      'Choose date',
      name: 'chooseDate',
      desc: '',
      args: [],
    );
  }

  /// `/per night`
  String get perNight {
    return Intl.message(
      '/per night',
      name: 'perNight',
      desc: '',
      args: [],
    );
  }

  /// `Your Email`
  String get yourEmail {
    return Intl.message(
      'Your Email',
      name: 'yourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get forgotYourPassword {
    return Intl.message(
      'Forgot your password?',
      name: 'forgotYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Facebook`
  String get facebook {
    return Intl.message(
      'Facebook',
      name: 'facebook',
      desc: '',
      args: [],
    );
  }

  /// `Twitter`
  String get twitter {
    return Intl.message(
      'Twitter',
      name: 'twitter',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get logIn {
    return Intl.message(
      'Log in',
      name: 'logIn',
      desc: '',
      args: [],
    );
  }

  /// `or log in with email`
  String get orLogInWithEmail {
    return Intl.message(
      'or log in with email',
      name: 'orLogInWithEmail',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstName {
    return Intl.message(
      'First Name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get lastName {
    return Intl.message(
      'Last Name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signUp {
    return Intl.message(
      'Sign up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `By signing up, you agreed with our terms of\nServices and privacy Policy`
  String get bySigningUpYouAgreedWithOurTermsOfnservicesAnd {
    return Intl.message(
      'By signing up, you agreed with our terms of\nServices and privacy Policy',
      name: 'bySigningUpYouAgreedWithOurTermsOfnservicesAnd',
      desc: '',
      args: [],
    );
  }

  /// `Already have account?.`
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have account?.',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Explore`
  String get explore {
    return Intl.message(
      'Explore',
      name: 'explore',
      desc: '',
      args: [],
    );
  }

  /// `Trips`
  String get trips {
    return Intl.message(
      'Trips',
      name: 'trips',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Popular Destinations`
  String get popularDestinations {
    return Intl.message(
      'Popular Destinations',
      name: 'popularDestinations',
      desc: '',
      args: [],
    );
  }

  /// `Best Deals`
  String get bestDeals {
    return Intl.message(
      'Best Deals',
      name: 'bestDeals',
      desc: '',
      args: [],
    );
  }

  /// `View all`
  String get viewAll {
    return Intl.message(
      'View all',
      name: 'viewAll',
      desc: '',
      args: [],
    );
  }

  /// `View Hotels`
  String get viewHotels {
    return Intl.message(
      'View Hotels',
      name: 'viewHotels',
      desc: '',
      args: [],
    );
  }

  /// `Where are you going?`
  String get whereAreYouGoing {
    return Intl.message(
      'Where are you going?',
      name: 'whereAreYouGoing',
      desc: '',
      args: [],
    );
  }

  /// `Summary`
  String get summary {
    return Intl.message(
      'Summary',
      name: 'summary',
      desc: '',
      args: [],
    );
  }

  /// `Read more`
  String get readMore {
    return Intl.message(
      'Read more',
      name: 'readMore',
      desc: '',
      args: [],
    );
  }

  /// `less`
  String get less {
    return Intl.message(
      'less',
      name: 'less',
      desc: '',
      args: [],
    );
  }

  /// `Photos`
  String get photos {
    return Intl.message(
      'Photos',
      name: 'photos',
      desc: '',
      args: [],
    );
  }

  /// `Reviews (8)`
  String get reviews8 {
    return Intl.message(
      'Reviews (8)',
      name: 'reviews8',
      desc: '',
      args: [],
    );
  }

  /// `More Details`
  String get moreDetails {
    return Intl.message(
      'More Details',
      name: 'moreDetails',
      desc: '',
      args: [],
    );
  }

  /// `Book now`
  String get bookNow {
    return Intl.message(
      'Book now',
      name: 'bookNow',
      desc: '',
      args: [],
    );
  }

  /// `Number of Rooms`
  String get numberOfRooms {
    return Intl.message(
      'Number of Rooms',
      name: 'numberOfRooms',
      desc: '',
      args: [],
    );
  }

  /// `London...`
  String get london {
    return Intl.message(
      'London...',
      name: 'london',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message(
      'Filter',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `create account`
  String get createAccount {
    return Intl.message(
      'create account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Otelier`
  String get motel {
    return Intl.message(
      'Otelier',
      name: 'motel',
      desc: '',
      args: [],
    );
  }

  /// `Best hotel deals for your holiday`
  String get bestHotelDealsForYourHoliday {
    return Intl.message(
      'Best hotel deals for your holiday',
      name: 'bestHotelDealsForYourHoliday',
      desc: '',
      args: [],
    );
  }

  /// `Get started`
  String get getStarted {
    return Intl.message(
      'Get started',
      name: 'getStarted',
      desc: '',
      args: [],
    );
  }

  /// `Already have account? Log in`
  String get alreadyHaveAccountLogIn {
    return Intl.message(
      'Already have account? Log in',
      name: 'alreadyHaveAccountLogIn',
      desc: '',
      args: [],
    );
  }

  /// `Enter your new password and\nconfirm your password`
  String get enterYourNewPasswordAndnconfirmYourPassword {
    return Intl.message(
      'Enter your new password and\nconfirm your password',
      name: 'enterYourNewPasswordAndnconfirmYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email to receive an email to\nreset your password`
  String get enterYourEmailToReceiveAnEmailTonresetYourPassword {
    return Intl.message(
      'Enter your email to receive an email to\nreset your password',
      name: 'enterYourEmailToReceiveAnEmailTonresetYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `How can we help?`
  String get howCanWeHelp {
    return Intl.message(
      'How can we help?',
      name: 'howCanWeHelp',
      desc: '',
      args: [],
    );
  }

  /// `Search help articles`
  String get searchHelpArticles {
    return Intl.message(
      'Search help articles',
      name: 'searchHelpArticles',
      desc: '',
      args: [],
    );
  }

  /// `Invite Your Friends`
  String get inviteYourFriends {
    return Intl.message(
      'Invite Your Friends',
      name: 'inviteYourFriends',
      desc: '',
      args: [],
    );
  }

  /// `Are you one of those who makes everything\n at the last moment?`
  String get areYouOneOfThoseWhoMakesEverythingnAtThe {
    return Intl.message(
      'Are you one of those who makes everything\n at the last moment?',
      name: 'areYouOneOfThoseWhoMakesEverythingnAtThe',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Amanda`
  String get amanda {
    return Intl.message(
      'Amanda',
      name: 'amanda',
      desc: '',
      args: [],
    );
  }

  /// `View and edit profile`
  String get viewAndEditProfile {
    return Intl.message(
      'View and edit profile',
      name: 'viewAndEditProfile',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `Currency`
  String get currency {
    return Intl.message(
      'Currency',
      name: 'currency',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Popular filters`
  String get popularFilters {
    return Intl.message(
      'Popular filters',
      name: 'popularFilters',
      desc: '',
      args: [],
    );
  }

  /// `Type of Accommodation`
  String get typeOfAccommodation {
    return Intl.message(
      'Type of Accommodation',
      name: 'typeOfAccommodation',
      desc: '',
      args: [],
    );
  }

  /// `Distance from city center`
  String get distanceFromCityCenter {
    return Intl.message(
      'Distance from city center',
      name: 'distanceFromCityCenter',
      desc: '',
      args: [],
    );
  }

  /// `Price (for 1 night)`
  String get priceFor1Night {
    return Intl.message(
      'Price (for 1 night)',
      name: 'priceFor1Night',
      desc: '',
      args: [],
    );
  }

  /// `Filters`
  String get filters {
    return Intl.message(
      'Filters',
      name: 'filters',
      desc: '',
      args: [],
    );
  }

  /// `Last searches`
  String get lastSearches {
    return Intl.message(
      'Last searches',
      name: 'lastSearches',
      desc: '',
      args: [],
    );
  }

  /// `Clear all`
  String get clearAll {
    return Intl.message(
      'Clear all',
      name: 'clearAll',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Upcoming`
  String get upcoming {
    return Intl.message(
      'Upcoming',
      name: 'upcoming',
      desc: '',
      args: [],
    );
  }

  /// `Finished`
  String get finished {
    return Intl.message(
      'Finished',
      name: 'finished',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get favorites {
    return Intl.message(
      'Favorites',
      name: 'favorites',
      desc: '',
      args: [],
    );
  }

  /// `My Trips`
  String get myTrips {
    return Intl.message(
      'My Trips',
      name: 'myTrips',
      desc: '',
      args: [],
    );
  }

  /// `Reply`
  String get reply {
    return Intl.message(
      'Reply',
      name: 'reply',
      desc: '',
      args: [],
    );
  }

  /// `Overall Rating`
  String get overallRating {
    return Intl.message(
      'Overall Rating',
      name: 'overallRating',
      desc: '',
      args: [],
    );
  }

  /// `Room`
  String get room {
    return Intl.message(
      'Room',
      name: 'room',
      desc: '',
      args: [],
    );
  }

  /// `Service`
  String get service {
    return Intl.message(
      'Service',
      name: 'service',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get from {
    return Intl.message(
      'From',
      name: 'from',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get to {
    return Intl.message(
      'To',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `Reviews (20)`
  String get reviews20 {
    return Intl.message(
      'Reviews (20)',
      name: 'reviews20',
      desc: '',
      args: [],
    );
  }

  /// `Validation successful.`
  String get validationSuccessful {
    return Intl.message(
      'Validation successful.',
      name: 'validationSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Please enter email.`
  String get pleaseEnterEmail {
    return Intl.message(
      'Please enter email.',
      name: 'pleaseEnterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter password.`
  String get pleaseEnterPassword {
    return Intl.message(
      'Please enter password.',
      name: 'pleaseEnterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid email.`
  String get pleaseEnterValidEmail {
    return Intl.message(
      'Please enter valid email.',
      name: 'pleaseEnterValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password must be with in 6-20 characters.`
  String get passwordMustBeWithIn620Characters {
    return Intl.message(
      'Password must be with in 6-20 characters.',
      name: 'passwordMustBeWithIn620Characters',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your first name.`
  String get pleaseEnterYourFirstName {
    return Intl.message(
      'Please enter your first name.',
      name: 'pleaseEnterYourFirstName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your last name`
  String get pleaseEnterYourLastName {
    return Intl.message(
      'Please enter your last name',
      name: 'pleaseEnterYourLastName',
      desc: '',
      args: [],
    );
  }

  /// `Password must include one character & one numeric digit.`
  String get passwordMustIncludeOneCharacterOneNumericDigit {
    return Intl.message(
      'Password must include one character & one numeric digit.',
      name: 'passwordMustIncludeOneCharacterOneNumericDigit',
      desc: '',
      args: [],
    );
  }

  /// `Hotel`
  String get hotel {
    return Intl.message(
      'Hotel',
      name: 'hotel',
      desc: '',
      args: [],
    );
  }

  /// `Password must include at least one upper & lower case, one special character & one numeric digit.`
  String get passwordMustIncludeAtLeastOneUpperLowerCaseOne {
    return Intl.message(
      'Password must include at least one upper & lower case, one special character & one numeric digit.',
      name: 'passwordMustIncludeAtLeastOneUpperLowerCaseOne',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
