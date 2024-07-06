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

  /// `Invalid email`
  String get wrongEmail {
    return Intl.message(
      'Invalid email',
      name: 'wrongEmail',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get cart {
    return Intl.message(
      'Cart',
      name: 'cart',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get fav {
    return Intl.message(
      'Favorites',
      name: 'fav',
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

  /// `My Orders`
  String get myOrder {
    return Intl.message(
      'My Orders',
      name: 'myOrder',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please create an account`
  String get pleasCreateAccount {
    return Intl.message(
      'Please create an account',
      name: 'pleasCreateAccount',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get userName {
    return Intl.message(
      'Username',
      name: 'userName',
      desc: '',
      args: [],
    );
  }

  /// `Home Address`
  String get homeAddress {
    return Intl.message(
      'Home Address',
      name: 'homeAddress',
      desc: '',
      args: [],
    );
  }

  /// `Region`
  String get region {
    return Intl.message(
      'Region',
      name: 'region',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
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

  /// `Confirm Password`
  String get rePassword {
    return Intl.message(
      'Confirm Password',
      name: 'rePassword',
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

  /// `Full Name`
  String get fullName {
    return Intl.message(
      'Full Name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Please check your internet connection`
  String get noInternet {
    return Intl.message(
      'Please check your internet connection',
      name: 'noInternet',
      desc: '',
      args: [],
    );
  }

  /// `Name field is required`
  String get nameEmpty {
    return Intl.message(
      'Name field is required',
      name: 'nameEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Phone number field is required`
  String get phoneNumberEmpty {
    return Intl.message(
      'Phone number field is required',
      name: 'phoneNumberEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Email field is required`
  String get emailEmpty {
    return Intl.message(
      'Email field is required',
      name: 'emailEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Password field is required`
  String get passwordEmpty {
    return Intl.message(
      'Password field is required',
      name: 'passwordEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Password does not match`
  String get passwordNotMatch {
    return Intl.message(
      'Password does not match',
      name: 'passwordNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgetPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueTo {
    return Intl.message(
      'Continue',
      name: 'continueTo',
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

  /// `Enter Confirmation Code`
  String get confirmCode {
    return Intl.message(
      'Enter Confirmation Code',
      name: 'confirmCode',
      desc: '',
      args: [],
    );
  }

  /// `Confirmation code sent to email: `
  String get codeSentToEmail {
    return Intl.message(
      'Confirmation code sent to email: ',
      name: 'codeSentToEmail',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
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

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notification {
    return Intl.message(
      'Notifications',
      name: 'notification',
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

  /// `Terms of Use and Privacy Policy`
  String get policy {
    return Intl.message(
      'Terms of Use and Privacy Policy',
      name: 'policy',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get policyJust {
    return Intl.message(
      'Privacy Policy',
      name: 'policyJust',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contact {
    return Intl.message(
      'Contact Us',
      name: 'contact',
      desc: '',
      args: [],
    );
  }

  /// `Change Name`
  String get changeName {
    return Intl.message(
      'Change Name',
      name: 'changeName',
      desc: '',
      args: [],
    );
  }

  /// `Change Phone Number`
  String get changePhone {
    return Intl.message(
      'Change Phone Number',
      name: 'changePhone',
      desc: '',
      args: [],
    );
  }

  /// `Change Address`
  String get changeAddress {
    return Intl.message(
      'Change Address',
      name: 'changeAddress',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePass {
    return Intl.message(
      'Change Password',
      name: 'changePass',
      desc: '',
      args: [],
    );
  }

  /// `Phone number cannot be changed`
  String get phoneNumberCanNotBeChange {
    return Intl.message(
      'Phone number cannot be changed',
      name: 'phoneNumberCanNotBeChange',
      desc: '',
      args: [],
    );
  }

  /// `Continue Sign Up`
  String get continueSignUp {
    return Intl.message(
      'Continue Sign Up',
      name: 'continueSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Invalid phone number`
  String get wrongPhone {
    return Intl.message(
      'Invalid phone number',
      name: 'wrongPhone',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back!`
  String get welcomeBack {
    return Intl.message(
      'Welcome Back!',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Sign In To Continue`
  String get signInToContinue {
    return Intl.message(
      'Sign In To Continue',
      name: 'signInToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Remember Me`
  String get rememberMe {
    return Intl.message(
      'Remember Me',
      name: 'rememberMe',
      desc: '',
      args: [],
    );
  }

  /// `Sign In With Social Networks:`
  String get signInWithSocial {
    return Intl.message(
      'Sign In With Social Networks:',
      name: 'signInWithSocial',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `name`
  String get name {
    return Intl.message(
      'name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `birthday`
  String get birthday {
    return Intl.message(
      'birthday',
      name: 'birthday',
      desc: '',
      args: [],
    );
  }

  /// `The Phone Number Is 11 Digits`
  String get need11 {
    return Intl.message(
      'The Phone Number Is 11 Digits',
      name: 'need11',
      desc: '',
      args: [],
    );
  }

  /// `The Password Is More Than 8 Letters And Numbers`
  String get need8 {
    return Intl.message(
      'The Password Is More Than 8 Letters And Numbers',
      name: 'need8',
      desc: '',
      args: [],
    );
  }

  /// `confirm password`
  String get confirmPassword {
    return Intl.message(
      'confirm password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Already Have An Account?`
  String get alreadyHaveAnAccount {
    return Intl.message(
      'Already Have An Account?',
      name: 'alreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign In.`
  String get sgnIn {
    return Intl.message(
      'Sign In.',
      name: 'sgnIn',
      desc: '',
      args: [],
    );
  }

  /// `Please Choose How You Would Like To Send The Verification Code`
  String get confirmMethod {
    return Intl.message(
      'Please Choose How You Would Like To Send The Verification Code',
      name: 'confirmMethod',
      desc: '',
      args: [],
    );
  }

  /// `Phone Call`
  String get phoneCall {
    return Intl.message(
      'Phone Call',
      name: 'phoneCall',
      desc: '',
      args: [],
    );
  }

  /// `Phone SMS`
  String get phoneSms {
    return Intl.message(
      'Phone SMS',
      name: 'phoneSms',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your OTP Code Here.`
  String get enterOTP {
    return Intl.message(
      'Enter Your OTP Code Here.',
      name: 'enterOTP',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get resend {
    return Intl.message(
      'Resend',
      name: 'resend',
      desc: '',
      args: [],
    );
  }

  /// `verify`
  String get verify {
    return Intl.message(
      'verify',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `Account Created!`
  String get accountCreated {
    return Intl.message(
      'Account Created!',
      name: 'accountCreated',
      desc: '',
      args: [],
    );
  }

  /// `Your Account Had Been Created`
  String get haveBeenCreated {
    return Intl.message(
      'Your Account Had Been Created',
      name: 'haveBeenCreated',
      desc: '',
      args: [],
    );
  }

  /// `Successfully.`
  String get successfully {
    return Intl.message(
      'Successfully.',
      name: 'successfully',
      desc: '',
      args: [],
    );
  }

  /// `Confirmation`
  String get confirmation {
    return Intl.message(
      'Confirmation',
      name: 'confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Number Phone`
  String get numberPhone {
    return Intl.message(
      'Number Phone',
      name: 'numberPhone',
      desc: '',
      args: [],
    );
  }

  /// `Your Password Has\nBeen Reset!`
  String get passwordReset {
    return Intl.message(
      'Your Password Has\nBeen Reset!',
      name: 'passwordReset',
      desc: '',
      args: [],
    );
  }

  /// `save change`
  String get saveChange {
    return Intl.message(
      'save change',
      name: 'saveChange',
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

  /// `Your Address`
  String get yourAddress {
    return Intl.message(
      'Your Address',
      name: 'yourAddress',
      desc: '',
      args: [],
    );
  }

  /// `Your Phone`
  String get yourPhone {
    return Intl.message(
      'Your Phone',
      name: 'yourPhone',
      desc: '',
      args: [],
    );
  }

  /// `Your Name`
  String get yourName {
    return Intl.message(
      'Your Name',
      name: 'yourName',
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

  /// `Current Password`
  String get currentPassword {
    return Intl.message(
      'Current Password',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// `confirm New Password`
  String get confirmNewPassword {
    return Intl.message(
      'confirm New Password',
      name: 'confirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `first name`
  String get firstName {
    return Intl.message(
      'first name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get lastName {
    return Intl.message(
      'Last name',
      name: 'lastName',
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

  /// `Use Current Location`
  String get useCurrentLocation {
    return Intl.message(
      'Use Current Location',
      name: 'useCurrentLocation',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message(
      'Other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Registered Before`
  String get registeredBefore {
    return Intl.message(
      'Registered Before',
      name: 'registeredBefore',
      desc: '',
      args: [],
    );
  }

  /// `Change Email`
  String get changeEmail {
    return Intl.message(
      'Change Email',
      name: 'changeEmail',
      desc: '',
      args: [],
    );
  }

  /// `My Info`
  String get myInfo {
    return Intl.message(
      'My Info',
      name: 'myInfo',
      desc: '',
      args: [],
    );
  }

  /// `My Orders`
  String get myOrders {
    return Intl.message(
      'My Orders',
      name: 'myOrders',
      desc: '',
      args: [],
    );
  }

  /// `WishList`
  String get wishList {
    return Intl.message(
      'WishList',
      name: 'wishList',
      desc: '',
      args: [],
    );
  }

  /// `F.A.Q`
  String get faq {
    return Intl.message(
      'F.A.Q',
      name: 'faq',
      desc: '',
      args: [],
    );
  }

  /// `Terms And Conditions`
  String get termsAndConditions {
    return Intl.message(
      'Terms And Conditions',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get aboutUs {
    return Intl.message(
      'About Us',
      name: 'aboutUs',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get support {
    return Intl.message(
      'Support',
      name: 'support',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
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

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Done resend code`
  String get doneResendCode {
    return Intl.message(
      'Done resend code',
      name: 'doneResendCode',
      desc: '',
      args: [],
    );
  }

  /// `Search In All`
  String get searchInAll {
    return Intl.message(
      'Search In All',
      name: 'searchInAll',
      desc: '',
      args: [],
    );
  }

  /// `Flash Deal`
  String get flashDeal {
    return Intl.message(
      'Flash Deal',
      name: 'flashDeal',
      desc: '',
      args: [],
    );
  }

  /// `Offer`
  String get offer {
    return Intl.message(
      'Offer',
      name: 'offer',
      desc: '',
      args: [],
    );
  }

  /// `Days`
  String get days {
    return Intl.message(
      'Days',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `Hours`
  String get hours {
    return Intl.message(
      'Hours',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// `seconds`
  String get seconds {
    return Intl.message(
      'seconds',
      name: 'seconds',
      desc: '',
      args: [],
    );
  }

  /// `Min`
  String get min {
    return Intl.message(
      'Min',
      name: 'min',
      desc: '',
      args: [],
    );
  }

  /// `Minutes`
  String get minutes {
    return Intl.message(
      'Minutes',
      name: 'minutes',
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

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Reviews`
  String get reviews {
    return Intl.message(
      'Reviews',
      name: 'reviews',
      desc: '',
      args: [],
    );
  }

  /// `Sizes`
  String get sizes {
    return Intl.message(
      'Sizes',
      name: 'sizes',
      desc: '',
      args: [],
    );
  }

  /// `Max`
  String get max {
    return Intl.message(
      'Max',
      name: 'max',
      desc: '',
      args: [],
    );
  }

  /// `Apply filters`
  String get applyFilters {
    return Intl.message(
      'Apply filters',
      name: 'applyFilters',
      desc: '',
      args: [],
    );
  }

  /// `Color`
  String get color {
    return Intl.message(
      'Color',
      name: 'color',
      desc: '',
      args: [],
    );
  }

  /// `Colors`
  String get colors {
    return Intl.message(
      'Colors',
      name: 'colors',
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

  /// `New Check Your Email For\nConfirmation Link`
  String get newCheckEmail {
    return Intl.message(
      'New Check Your Email For\nConfirmation Link',
      name: 'newCheckEmail',
      desc: '',
      args: [],
    );
  }

  /// `Expiration`
  String get expiration {
    return Intl.message(
      'Expiration',
      name: 'expiration',
      desc: '',
      args: [],
    );
  }

  /// `Save For Later?`
  String get saveForLater {
    return Intl.message(
      'Save For Later?',
      name: 'saveForLater',
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

  /// `Confirm Address`
  String get confirmAddress {
    return Intl.message(
      'Confirm Address',
      name: 'confirmAddress',
      desc: '',
      args: [],
    );
  }

  /// `Cvc`
  String get cvc {
    return Intl.message(
      'Cvc',
      name: 'cvc',
      desc: '',
      args: [],
    );
  }

  /// `Card Name`
  String get cardName {
    return Intl.message(
      'Card Name',
      name: 'cardName',
      desc: '',
      args: [],
    );
  }

  /// `Card Number`
  String get cardNumber {
    return Intl.message(
      'Card Number',
      name: 'cardNumber',
      desc: '',
      args: [],
    );
  }

  /// `Payment Summary`
  String get paymentSummary {
    return Intl.message(
      'Payment Summary',
      name: 'paymentSummary',
      desc: '',
      args: [],
    );
  }

  /// `Subtotal`
  String get subtotal {
    return Intl.message(
      'Subtotal',
      name: 'subtotal',
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

  /// `Additional service`
  String get additionalService {
    return Intl.message(
      'Additional service',
      name: 'additionalService',
      desc: '',
      args: [],
    );
  }

  /// `Order summary`
  String get orderSummary {
    return Intl.message(
      'Order summary',
      name: 'orderSummary',
      desc: '',
      args: [],
    );
  }

  /// `Coupon Code`
  String get couponCode {
    return Intl.message(
      'Coupon Code',
      name: 'couponCode',
      desc: '',
      args: [],
    );
  }

  /// `This Code Is Invalid CODE`
  String get codeInvalid {
    return Intl.message(
      'This Code Is Invalid CODE',
      name: 'codeInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Wishlist`
  String get wishlist {
    return Intl.message(
      'Wishlist',
      name: 'wishlist',
      desc: '',
      args: [],
    );
  }

  /// `Related Products`
  String get relatedProducts {
    return Intl.message(
      'Related Products',
      name: 'relatedProducts',
      desc: '',
      args: [],
    );
  }

  /// `Add To Cart`
  String get addToCart {
    return Intl.message(
      'Add To Cart',
      name: 'addToCart',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `New Arrival`
  String get newArrival {
    return Intl.message(
      'New Arrival',
      name: 'newArrival',
      desc: '',
      args: [],
    );
  }

  /// `Required`
  String get isRequired {
    return Intl.message(
      'Required',
      name: 'isRequired',
      desc: '',
      args: [],
    );
  }

  /// `Oops!`
  String get oops {
    return Intl.message(
      'Oops!',
      name: 'oops',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter New Password And Confirm.`
  String get enterNewPasswordAndConfirm {
    return Intl.message(
      'Enter New Password And Confirm.',
      name: 'enterNewPasswordAndConfirm',
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

  /// `update`
  String get update {
    return Intl.message(
      'update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `governor`
  String get governor {
    return Intl.message(
      'governor',
      name: 'governor',
      desc: '',
      args: [],
    );
  }

  /// `receiverPhone`
  String get receiverPhone {
    return Intl.message(
      'receiverPhone',
      name: 'receiverPhone',
      desc: '',
      args: [],
    );
  }

  /// `Select Governor`
  String get selectGovernor {
    return Intl.message(
      'Select Governor',
      name: 'selectGovernor',
      desc: '',
      args: [],
    );
  }

  /// `From Map`
  String get selectFromMap {
    return Intl.message(
      'From Map',
      name: 'selectFromMap',
      desc: '',
      args: [],
    );
  }

  /// `My Location`
  String get myLocation {
    return Intl.message(
      'My Location',
      name: 'myLocation',
      desc: '',
      args: [],
    );
  }

  /// `start with 07 and 11 digit`
  String get helperPhoneText {
    return Intl.message(
      'start with 07 and 11 digit',
      name: 'helperPhoneText',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, Your Search Is \nNot Available`
  String get emptySearch {
    return Intl.message(
      'Sorry, Your Search Is \nNot Available',
      name: 'emptySearch',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, There Are \nNo Requests`
  String get emptyCart {
    return Intl.message(
      'Sorry, There Are \nNo Requests',
      name: 'emptyCart',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, There Are \nNo Requests`
  String get emptyFav {
    return Intl.message(
      'Sorry, There Are \nNo Requests',
      name: 'emptyFav',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, There Are \nNo Offers`
  String get emptyOffers {
    return Intl.message(
      'Sorry, There Are \nNo Offers',
      name: 'emptyOffers',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, There Are \nNo Notifications`
  String get emptyNotifications {
    return Intl.message(
      'Sorry, There Are \nNo Notifications',
      name: 'emptyNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, There Are \nNo Orders`
  String get emptyOrders {
    return Intl.message(
      'Sorry, There Are \nNo Orders',
      name: 'emptyOrders',
      desc: '',
      args: [],
    );
  }

  /// `Cash Payment`
  String get cashPayment {
    return Intl.message(
      'Cash Payment',
      name: 'cashPayment',
      desc: '',
      args: [],
    );
  }

  /// `E-Payment`
  String get ePayment {
    return Intl.message(
      'E-Payment',
      name: 'ePayment',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get paymentMethod {
    return Intl.message(
      'Payment Method',
      name: 'paymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Order Created`
  String get donePending {
    return Intl.message(
      'Order Created',
      name: 'donePending',
      desc: '',
      args: [],
    );
  }

  /// `Order Processed`
  String get doneProcessing {
    return Intl.message(
      'Order Processed',
      name: 'doneProcessing',
      desc: '',
      args: [],
    );
  }

  /// `Order Was Ready`
  String get doneReady {
    return Intl.message(
      'Order Was Ready',
      name: 'doneReady',
      desc: '',
      args: [],
    );
  }

  /// `Order Shipped`
  String get doneShipping {
    return Intl.message(
      'Order Shipped',
      name: 'doneShipping',
      desc: '',
      args: [],
    );
  }

  /// `Order Completed`
  String get doneCompleted {
    return Intl.message(
      'Order Completed',
      name: 'doneCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Order Canceled`
  String get doneCanceled {
    return Intl.message(
      'Order Canceled',
      name: 'doneCanceled',
      desc: '',
      args: [],
    );
  }

  /// ` PaymentFailed`
  String get donePaymentFailed {
    return Intl.message(
      ' PaymentFailed',
      name: 'donePaymentFailed',
      desc: '',
      args: [],
    );
  }

  /// `Order Returned`
  String get doneReturned {
    return Intl.message(
      'Order Returned',
      name: 'doneReturned',
      desc: '',
      args: [],
    );
  }

  /// `At`
  String get at {
    return Intl.message(
      'At',
      name: 'at',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get pending {
    return Intl.message(
      'Pending',
      name: 'pending',
      desc: '',
      args: [],
    );
  }

  /// `Processing`
  String get processing {
    return Intl.message(
      'Processing',
      name: 'processing',
      desc: '',
      args: [],
    );
  }

  /// `Ready`
  String get ready {
    return Intl.message(
      'Ready',
      name: 'ready',
      desc: '',
      args: [],
    );
  }

  /// `Shipping`
  String get shipping {
    return Intl.message(
      'Shipping',
      name: 'shipping',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message(
      'Completed',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `Canceled`
  String get canceled {
    return Intl.message(
      'Canceled',
      name: 'canceled',
      desc: '',
      args: [],
    );
  }

  /// `Payment Failed`
  String get paymentFailed {
    return Intl.message(
      'Payment Failed',
      name: 'paymentFailed',
      desc: '',
      args: [],
    );
  }

  /// `Returned`
  String get returned {
    return Intl.message(
      'Returned',
      name: 'returned',
      desc: '',
      args: [],
    );
  }

  /// `Not Yet`
  String get notYet {
    return Intl.message(
      'Not Yet',
      name: 'notYet',
      desc: '',
      args: [],
    );
  }

  /// `Tracking Order`
  String get trackingOrder {
    return Intl.message(
      'Tracking Order',
      name: 'trackingOrder',
      desc: '',
      args: [],
    );
  }

  /// `Your Order`
  String get yourOrder {
    return Intl.message(
      'Your Order',
      name: 'yourOrder',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Date`
  String get deliveryDate {
    return Intl.message(
      'Delivery Date',
      name: 'deliveryDate',
      desc: '',
      args: [],
    );
  }

  /// `Ready To Deliver`
  String get readyToDeliver {
    return Intl.message(
      'Ready To Deliver',
      name: 'readyToDeliver',
      desc: '',
      args: [],
    );
  }

  /// `Estimated For`
  String get estimatedFor {
    return Intl.message(
      'Estimated For',
      name: 'estimatedFor',
      desc: '',
      args: [],
    );
  }

  /// `Pleas Set Your Address`
  String get pleasSetYourAddress {
    return Intl.message(
      'Pleas Set Your Address',
      name: 'pleasSetYourAddress',
      desc: '',
      args: [],
    );
  }

  /// `Review Order`
  String get reviewOrder {
    return Intl.message(
      'Review Order',
      name: 'reviewOrder',
      desc: '',
      args: [],
    );
  }

  /// `Your Location`
  String get yourLocation {
    return Intl.message(
      'Your Location',
      name: 'yourLocation',
      desc: '',
      args: [],
    );
  }

  /// `Alphabetical A-Z`
  String get alphabeticalAZ {
    return Intl.message(
      'Alphabetical A-Z',
      name: 'alphabeticalAZ',
      desc: '',
      args: [],
    );
  }

  /// `Alphabetical Z-A`
  String get alphabeticalZA {
    return Intl.message(
      'Alphabetical Z-A',
      name: 'alphabeticalZA',
      desc: '',
      args: [],
    );
  }

  /// `Most Popularً`
  String get mostPopular {
    return Intl.message(
      'Most Popularً',
      name: 'mostPopular',
      desc: '',
      args: [],
    );
  }

  /// `Playing Days (more first)`
  String get playingDays_moreFirst {
    return Intl.message(
      'Playing Days (more first)',
      name: 'playingDays_moreFirst',
      desc: '',
      args: [],
    );
  }

  /// `Playing Days (less first)`
  String get playingDays_lessFirst {
    return Intl.message(
      'Playing Days (less first)',
      name: 'playingDays_lessFirst',
      desc: '',
      args: [],
    );
  }

  /// `minute`
  String get minute {
    return Intl.message(
      'minute',
      name: 'minute',
      desc: '',
      args: [],
    );
  }

  /// `Plan`
  String get planProg {
    return Intl.message(
      'Plan',
      name: 'planProg',
      desc: '',
      args: [],
    );
  }

  /// `Private Session`
  String get privateSessionProg {
    return Intl.message(
      'Private Session',
      name: 'privateSessionProg',
      desc: '',
      args: [],
    );
  }

  /// `subscription payment`
  String get subscriptionPayment {
    return Intl.message(
      'subscription payment',
      name: 'subscriptionPayment',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Your Email To Receive Activation Code`
  String get plsEnterEmail {
    return Intl.message(
      'Please Enter Your Email To Receive Activation Code',
      name: 'plsEnterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailOrPhone {
    return Intl.message(
      'Email',
      name: 'emailOrPhone',
      desc: '',
      args: [],
    );
  }

  /// `Set the new password to this account`
  String get setNewPass {
    return Intl.message(
      'Set the new password to this account',
      name: 'setNewPass',
      desc: '',
      args: [],
    );
  }

  /// `Re-Enter New Password`
  String get reEnterPass {
    return Intl.message(
      'Re-Enter New Password',
      name: 'reEnterPass',
      desc: '',
      args: [],
    );
  }

  /// `Email Verification`
  String get emailVerification {
    return Intl.message(
      'Email Verification',
      name: 'emailVerification',
      desc: '',
      args: [],
    );
  }

  /// `Email Verification`
  String get phoneVerification {
    return Intl.message(
      'Email Verification',
      name: 'phoneVerification',
      desc: '',
      args: [],
    );
  }

  /// `We have sent a 5-digit code to your email`
  String get sent6Digit {
    return Intl.message(
      'We have sent a 5-digit code to your email',
      name: 'sent6Digit',
      desc: '',
      args: [],
    );
  }

  /// `Resend Code`
  String get resendCode {
    return Intl.message(
      'Resend Code',
      name: 'resendCode',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign in as a Trainer`
  String get signInTrainer {
    return Intl.message(
      'Sign in as a Trainer',
      name: 'signInTrainer',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password ?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password ?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Not a Member ?`
  String get notMember {
    return Intl.message(
      'Not a Member ?',
      name: 'notMember',
      desc: '',
      args: [],
    );
  }

  /// `By signing up, you are agreeing to our policies`
  String get bySingingUpYouAreAgreeingToOur {
    return Intl.message(
      'By signing up, you are agreeing to our policies',
      name: 'bySingingUpYouAreAgreeingToOur',
      desc: '',
      args: [],
    );
  }

  /// `Terms Of Conditions`
  String get termsOfConditions {
    return Intl.message(
      'Terms Of Conditions',
      name: 'termsOfConditions',
      desc: '',
      args: [],
    );
  }

  /// `and`
  String get and {
    return Intl.message(
      'and',
      name: 'and',
      desc: '',
      args: [],
    );
  }

  /// `Already a Member ?`
  String get alreadyAMember {
    return Intl.message(
      'Already a Member ?',
      name: 'alreadyAMember',
      desc: '',
      args: [],
    );
  }

  /// `Fitness Survey`
  String get fitnessSurvey {
    return Intl.message(
      'Fitness Survey',
      name: 'fitnessSurvey',
      desc: '',
      args: [],
    );
  }

  /// `Take this survey to get more personalized workout plan recommendations.`
  String get takeThisSurvey {
    return Intl.message(
      'Take this survey to get more personalized workout plan recommendations.',
      name: 'takeThisSurvey',
      desc: '',
      args: [],
    );
  }

  /// `How often do you exercise?`
  String get howOftenDoYouExercise {
    return Intl.message(
      'How often do you exercise?',
      name: 'howOftenDoYouExercise',
      desc: '',
      args: [],
    );
  }

  /// `You Prefer to workout in`
  String get youPreferToWorkoutIn {
    return Intl.message(
      'You Prefer to workout in',
      name: 'youPreferToWorkoutIn',
      desc: '',
      args: [],
    );
  }

  /// `Gym`
  String get gym {
    return Intl.message(
      'Gym',
      name: 'gym',
      desc: '',
      args: [],
    );
  }

  /// `What"s your training level ?`
  String get whatYourTrainingLevel {
    return Intl.message(
      'What"s your training level ?',
      name: 'whatYourTrainingLevel',
      desc: '',
      args: [],
    );
  }

  /// `Beginner`
  String get beginner {
    return Intl.message(
      'Beginner',
      name: 'beginner',
      desc: '',
      args: [],
    );
  }

  /// `Professional`
  String get professional {
    return Intl.message(
      'Professional',
      name: 'professional',
      desc: '',
      args: [],
    );
  }

  /// `What is your training goal ?`
  String get whatIsYourTrainingGoal {
    return Intl.message(
      'What is your training goal ?',
      name: 'whatIsYourTrainingGoal',
      desc: '',
      args: [],
    );
  }

  /// `Lose weight`
  String get loseWeight {
    return Intl.message(
      'Lose weight',
      name: 'loseWeight',
      desc: '',
      args: [],
    );
  }

  /// `Build muscle`
  String get buildMuscle {
    return Intl.message(
      'Build muscle',
      name: 'buildMuscle',
      desc: '',
      args: [],
    );
  }

  /// `Stay fit`
  String get stayFit {
    return Intl.message(
      'Stay fit',
      name: 'stayFit',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Bookmarked Plans`
  String get bookmarkedPlans {
    return Intl.message(
      'Bookmarked Plans',
      name: 'bookmarkedPlans',
      desc: '',
      args: [],
    );
  }

  /// `Bookmarked`
  String get bookmarked {
    return Intl.message(
      'Bookmarked',
      name: 'bookmarked',
      desc: '',
      args: [],
    );
  }

  /// `Reset Filters`
  String get resetFilters {
    return Intl.message(
      'Reset Filters',
      name: 'resetFilters',
      desc: '',
      args: [],
    );
  }

  /// `FITNESS LEVEL`
  String get fITNESSLEVEL {
    return Intl.message(
      'FITNESS LEVEL',
      name: 'fITNESSLEVEL',
      desc: '',
      args: [],
    );
  }

  /// `LOCATION`
  String get lOCATION {
    return Intl.message(
      'LOCATION',
      name: 'lOCATION',
      desc: '',
      args: [],
    );
  }

  /// `TRAINING TYPE`
  String get tRAININGTYPE {
    return Intl.message(
      'TRAINING TYPE',
      name: 'tRAININGTYPE',
      desc: '',
      args: [],
    );
  }

  /// `SORT BY`
  String get sORTBY {
    return Intl.message(
      'SORT BY',
      name: 'sORTBY',
      desc: '',
      args: [],
    );
  }

  /// `Available sessions`
  String get availableSessions {
    return Intl.message(
      'Available sessions',
      name: 'availableSessions',
      desc: '',
      args: [],
    );
  }

  /// `WHAT WILL YOU GET IN THIS PRIVATE SESSION ?`
  String get whatWillYouGetInThisPrivateSession {
    return Intl.message(
      'WHAT WILL YOU GET IN THIS PRIVATE SESSION ?',
      name: 'whatWillYouGetInThisPrivateSession',
      desc: '',
      args: [],
    );
  }

  /// `will provide personalized guidance and support. You"ll receive one-on-one attention, and form corrections. Reserve your session today to take your fitness journey to the next level.`
  String get willProvidePersonalized {
    return Intl.message(
      'will provide personalized guidance and support. You"ll receive one-on-one attention, and form corrections. Reserve your session today to take your fitness journey to the next level.',
      name: 'willProvidePersonalized',
      desc: '',
      args: [],
    );
  }

  /// `CHOOSE TIME`
  String get cHOOSETIME {
    return Intl.message(
      'CHOOSE TIME',
      name: 'cHOOSETIME',
      desc: '',
      args: [],
    );
  }

  /// `Chat`
  String get chat {
    return Intl.message(
      'Chat',
      name: 'chat',
      desc: '',
      args: [],
    );
  }

  /// `Customer Service`
  String get customerService {
    return Intl.message(
      'Customer Service',
      name: 'customerService',
      desc: '',
      args: [],
    );
  }

  /// `Last message`
  String get lastMessage {
    return Intl.message(
      'Last message',
      name: 'lastMessage',
      desc: '',
      args: [],
    );
  }

  /// `Exercise`
  String get exercise {
    return Intl.message(
      'Exercise',
      name: 'exercise',
      desc: '',
      args: [],
    );
  }

  /// `Start Workout`
  String get startWorkout {
    return Intl.message(
      'Start Workout',
      name: 'startWorkout',
      desc: '',
      args: [],
    );
  }

  /// `Set`
  String get set {
    return Intl.message(
      'Set',
      name: 'set',
      desc: '',
      args: [],
    );
  }

  /// `Reps`
  String get reps {
    return Intl.message(
      'Reps',
      name: 'reps',
      desc: '',
      args: [],
    );
  }

  /// `second`
  String get second {
    return Intl.message(
      'second',
      name: 'second',
      desc: '',
      args: [],
    );
  }

  /// `Our Workout`
  String get ourWorkout {
    return Intl.message(
      'Our Workout',
      name: 'ourWorkout',
      desc: '',
      args: [],
    );
  }

  /// `pull up load`
  String get pullUpLoad {
    return Intl.message(
      'pull up load',
      name: 'pullUpLoad',
      desc: '',
      args: [],
    );
  }

  /// `Load Failed!Click retry!`
  String get loadFailedClickRetry {
    return Intl.message(
      'Load Failed!Click retry!',
      name: 'loadFailedClickRetry',
      desc: '',
      args: [],
    );
  }

  /// `release to load more`
  String get releaseToLoadMore {
    return Intl.message(
      'release to load more',
      name: 'releaseToLoadMore',
      desc: '',
      args: [],
    );
  }

  /// `No more Data`
  String get noMoreData {
    return Intl.message(
      'No more Data',
      name: 'noMoreData',
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

  /// `Reset`
  String get reset {
    return Intl.message(
      'Reset',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `LEVEL`
  String get lEVEL {
    return Intl.message(
      'LEVEL',
      name: 'lEVEL',
      desc: '',
      args: [],
    );
  }

  /// `Intermediate`
  String get intermediate {
    return Intl.message(
      'Intermediate',
      name: 'intermediate',
      desc: '',
      args: [],
    );
  }

  /// `Advanced`
  String get advanced {
    return Intl.message(
      'Advanced',
      name: 'advanced',
      desc: '',
      args: [],
    );
  }

  /// `Weight lifting`
  String get weightlifting {
    return Intl.message(
      'Weight lifting',
      name: 'weightlifting',
      desc: '',
      args: [],
    );
  }

  /// `Body Weight`
  String get bodyWeight {
    return Intl.message(
      'Body Weight',
      name: 'bodyWeight',
      desc: '',
      args: [],
    );
  }

  /// `HIIT Training`
  String get hiitTraining {
    return Intl.message(
      'HIIT Training',
      name: 'hiitTraining',
      desc: '',
      args: [],
    );
  }

  /// `Strength Training`
  String get strengthTraining {
    return Intl.message(
      'Strength Training',
      name: 'strengthTraining',
      desc: '',
      args: [],
    );
  }

  /// `Functional Training`
  String get functionalTraining {
    return Intl.message(
      'Functional Training',
      name: 'functionalTraining',
      desc: '',
      args: [],
    );
  }

  /// `Mobility Training`
  String get mobilityTraining {
    return Intl.message(
      'Mobility Training',
      name: 'mobilityTraining',
      desc: '',
      args: [],
    );
  }

  /// `Sports Training`
  String get sportsTraining {
    return Intl.message(
      'Sports Training',
      name: 'sportsTraining',
      desc: '',
      args: [],
    );
  }

  /// `Dynamic Training`
  String get dynamicTraining {
    return Intl.message(
      'Dynamic Training',
      name: 'dynamicTraining',
      desc: '',
      args: [],
    );
  }

  /// `Follow Along`
  String get folloAlong {
    return Intl.message(
      'Follow Along',
      name: 'folloAlong',
      desc: '',
      args: [],
    );
  }

  /// `Body building`
  String get bodybuilding {
    return Intl.message(
      'Body building',
      name: 'bodybuilding',
      desc: '',
      args: [],
    );
  }

  /// `Prenatal Training`
  String get prenatalTraining {
    return Intl.message(
      'Prenatal Training',
      name: 'prenatalTraining',
      desc: '',
      args: [],
    );
  }

  /// `Hands-Free`
  String get handsFree {
    return Intl.message(
      'Hands-Free',
      name: 'handsFree',
      desc: '',
      args: [],
    );
  }

  /// `Pilates`
  String get pilates {
    return Intl.message(
      'Pilates',
      name: 'pilates',
      desc: '',
      args: [],
    );
  }

  /// `SEE ALL`
  String get seeAll {
    return Intl.message(
      'SEE ALL',
      name: 'seeAll',
      desc: '',
      args: [],
    );
  }

  /// `Weeks`
  String get weeks {
    return Intl.message(
      'Weeks',
      name: 'weeks',
      desc: '',
      args: [],
    );
  }

  /// `Times/Week`
  String get timesWeek {
    return Intl.message(
      'Times/Week',
      name: 'timesWeek',
      desc: '',
      args: [],
    );
  }

  /// `Next Up`
  String get nextUp {
    return Intl.message(
      'Next Up',
      name: 'nextUp',
      desc: '',
      args: [],
    );
  }

  /// `Day`
  String get day {
    return Intl.message(
      'Day',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `Continue Training`
  String get continueTraining {
    return Intl.message(
      'Continue Training',
      name: 'continueTraining',
      desc: '',
      args: [],
    );
  }

  /// `Workout plan . private`
  String get workoutPlanPrivate {
    return Intl.message(
      'Workout plan . private',
      name: 'workoutPlanPrivate',
      desc: '',
      args: [],
    );
  }

  /// `My Payments`
  String get myPayments {
    return Intl.message(
      'My Payments',
      name: 'myPayments',
      desc: '',
      args: [],
    );
  }

  /// `NEXT PAYMENT`
  String get nextPayment {
    return Intl.message(
      'NEXT PAYMENT',
      name: 'nextPayment',
      desc: '',
      args: [],
    );
  }

  /// `You didn"t Start your Fitness Storm Yet! Choose a plan and watch the change in your life.`
  String get didNotStartYourFitness {
    return Intl.message(
      'You didn"t Start your Fitness Storm Yet! Choose a plan and watch the change in your life.',
      name: 'didNotStartYourFitness',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get payment {
    return Intl.message(
      'Payment',
      name: 'payment',
      desc: '',
      args: [],
    );
  }

  /// `SAR`
  String get sar {
    return Intl.message(
      'SAR',
      name: 'sar',
      desc: '',
      args: [],
    );
  }

  /// `You don"t have any notifications Yet! \nStart your Fitness Storm and we will remind you here with your important sessions`
  String get didNotHaveNotifications {
    return Intl.message(
      'You don"t have any notifications Yet! \nStart your Fitness Storm and we will remind you here with your important sessions',
      name: 'didNotHaveNotifications',
      desc: '',
      args: [],
    );
  }

  /// `FINISH`
  String get finish {
    return Intl.message(
      'FINISH',
      name: 'finish',
      desc: '',
      args: [],
    );
  }

  /// `NEXT`
  String get nEXT {
    return Intl.message(
      'NEXT',
      name: 'nEXT',
      desc: '',
      args: [],
    );
  }

  /// `No available sessions`
  String get noAvailableSessions {
    return Intl.message(
      'No available sessions',
      name: 'noAvailableSessions',
      desc: '',
      args: [],
    );
  }

  /// `What is your gender?`
  String get whatIsYourGender {
    return Intl.message(
      'What is your gender?',
      name: 'whatIsYourGender',
      desc: '',
      args: [],
    );
  }

  /// `That"s all we need for now.`
  String get thatsAllWeNeedForNow {
    return Intl.message(
      'That"s all we need for now.',
      name: 'thatsAllWeNeedForNow',
      desc: '',
      args: [],
    );
  }

  /// `All Finished!`
  String get allFinished {
    return Intl.message(
      'All Finished!',
      name: 'allFinished',
      desc: '',
      args: [],
    );
  }

  /// `Now go crush it`
  String get nowGoCrushIt {
    return Intl.message(
      'Now go crush it',
      name: 'nowGoCrushIt',
      desc: '',
      args: [],
    );
  }

  /// `What is your birthday?`
  String get whatIsYourBirthday {
    return Intl.message(
      'What is your birthday?',
      name: 'whatIsYourBirthday',
      desc: '',
      args: [],
    );
  }

  /// `What is your height/weight?`
  String get whatIsYourHeightWeight {
    return Intl.message(
      'What is your height/weight?',
      name: 'whatIsYourHeightWeight',
      desc: '',
      args: [],
    );
  }

  /// `About The Coach`
  String get aboutTheCoach {
    return Intl.message(
      'About The Coach',
      name: 'aboutTheCoach',
      desc: '',
      args: [],
    );
  }

  /// `Days/Week`
  String get daysWeek {
    return Intl.message(
      'Days/Week',
      name: 'daysWeek',
      desc: '',
      args: [],
    );
  }

  /// `The from is not a valid date`
  String get theFromIsNotAValidDate {
    return Intl.message(
      'The from is not a valid date',
      name: 'theFromIsNotAValidDate',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `FAQs`
  String get fAQs {
    return Intl.message(
      'FAQs',
      name: 'fAQs',
      desc: '',
      args: [],
    );
  }

  /// `Search Results`
  String get searchResults {
    return Intl.message(
      'Search Results',
      name: 'searchResults',
      desc: '',
      args: [],
    );
  }

  /// `There are no WORKOUT PLANS in your search results, you can check our workouts and use FILTERS to find what you are looking for`
  String get thereAreNoWorkout {
    return Intl.message(
      'There are no WORKOUT PLANS in your search results, you can check our workouts and use FILTERS to find what you are looking for',
      name: 'thereAreNoWorkout',
      desc: '',
      args: [],
    );
  }

  /// `Result`
  String get result {
    return Intl.message(
      'Result',
      name: 'result',
      desc: '',
      args: [],
    );
  }

  /// `SORT`
  String get sort {
    return Intl.message(
      'SORT',
      name: 'sort',
      desc: '',
      args: [],
    );
  }

  /// `Do you have any question in your mind?`
  String get doYouHaveAnyQuestionInYourMind {
    return Intl.message(
      'Do you have any question in your mind?',
      name: 'doYouHaveAnyQuestionInYourMind',
      desc: '',
      args: [],
    );
  }

  /// `Check our`
  String get checkOur {
    return Intl.message(
      'Check our',
      name: 'checkOur',
      desc: '',
      args: [],
    );
  }

  /// `  or contact our`
  String get orContactOur {
    return Intl.message(
      '  or contact our',
      name: 'orContactOur',
      desc: '',
      args: [],
    );
  }

  /// `Customer Services`
  String get customerServices {
    return Intl.message(
      'Customer Services',
      name: 'customerServices',
      desc: '',
      args: [],
    );
  }

  /// `Subscription Plans`
  String get subscriptionPlans {
    return Intl.message(
      'Subscription Plans',
      name: 'subscriptionPlans',
      desc: '',
      args: [],
    );
  }

  /// `Warning`
  String get warning {
    return Intl.message(
      'Warning',
      name: 'warning',
      desc: '',
      args: [],
    );
  }

  /// `It is advisable to cancel any existing subscription prior to initiating a new one`
  String get itIsAdvisable {
    return Intl.message(
      'It is advisable to cancel any existing subscription prior to initiating a new one',
      name: 'itIsAdvisable',
      desc: '',
      args: [],
    );
  }

  /// `Current Plan`
  String get currentPlan {
    return Intl.message(
      'Current Plan',
      name: 'currentPlan',
      desc: '',
      args: [],
    );
  }

  /// `PLAN`
  String get plan {
    return Intl.message(
      'PLAN',
      name: 'plan',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Subscription`
  String get cancelSubscription {
    return Intl.message(
      'Cancel Subscription',
      name: 'cancelSubscription',
      desc: '',
      args: [],
    );
  }

  /// `Take a Plan made customized for you!`
  String get takeAPlanMadeCustomizedForYou {
    return Intl.message(
      'Take a Plan made customized for you!',
      name: 'takeAPlanMadeCustomizedForYou',
      desc: '',
      args: [],
    );
  }

  /// `PRIVATE COACHING`
  String get privateCoatching {
    return Intl.message(
      'PRIVATE COACHING',
      name: 'privateCoatching',
      desc: '',
      args: [],
    );
  }

  /// `Month`
  String get month {
    return Intl.message(
      'Month',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `WELCOME`
  String get welcome {
    return Intl.message(
      'WELCOME',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations on taking the first step towards your fitness journey with Fitness Storm. Now that you"ve subscribed, you have access to all of our resources. Choose a plan and let"s get started!`
  String get congratulations {
    return Intl.message(
      'Congratulations on taking the first step towards your fitness journey with Fitness Storm. Now that you"ve subscribed, you have access to all of our resources. Choose a plan and let"s get started!',
      name: 'congratulations',
      desc: '',
      args: [],
    );
  }

  /// `Successfully subscribed`
  String get successfullySubscribed {
    return Intl.message(
      'Successfully subscribed',
      name: 'successfullySubscribed',
      desc: '',
      args: [],
    );
  }

  /// `WHY TO SUBSCRIBE?`
  String get whyToSubscribe {
    return Intl.message(
      'WHY TO SUBSCRIBE?',
      name: 'whyToSubscribe',
      desc: '',
      args: [],
    );
  }

  /// `Enjoy your Fitness Storm.`
  String get enjoyYourFitnessStorm {
    return Intl.message(
      'Enjoy your Fitness Storm.',
      name: 'enjoyYourFitnessStorm',
      desc: '',
      args: [],
    );
  }

  /// `11+ PLANS\n13+TRAINERS\nUNLIMITED ACCESS `
  String get joinFitnessStormForPersonalized {
    return Intl.message(
      '11+ PLANS\n13+TRAINERS\nUNLIMITED ACCESS ',
      name: 'joinFitnessStormForPersonalized',
      desc: '',
      args: [],
    );
  }

  /// `Prioritizing your fitness leads to physical and mental health benefits like improved mood, reduced stress, and better sleep.`
  String get prioritizingYourFitness {
    return Intl.message(
      'Prioritizing your fitness leads to physical and mental health benefits like improved mood, reduced stress, and better sleep.',
      name: 'prioritizingYourFitness',
      desc: '',
      args: [],
    );
  }

  /// `Start your journey to a healthier you today!`
  String get startYourJourney {
    return Intl.message(
      'Start your journey to a healthier you today!',
      name: 'startYourJourney',
      desc: '',
      args: [],
    );
  }

  /// `Profile info`
  String get profileInfo {
    return Intl.message(
      'Profile info',
      name: 'profileInfo',
      desc: '',
      args: [],
    );
  }

  /// `No Name`
  String get noName {
    return Intl.message(
      'No Name',
      name: 'noName',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get change {
    return Intl.message(
      'Change',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get signOut {
    return Intl.message(
      'Sign Out',
      name: 'signOut',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Profile Details`
  String get profileDetails {
    return Intl.message(
      'Profile Details',
      name: 'profileDetails',
      desc: '',
      args: [],
    );
  }

  /// `You Often exercise`
  String get youOftenExercise {
    return Intl.message(
      'You Often exercise',
      name: 'youOftenExercise',
      desc: '',
      args: [],
    );
  }

  /// `Survey Info`
  String get surveyInfo {
    return Intl.message(
      'Survey Info',
      name: 'surveyInfo',
      desc: '',
      args: [],
    );
  }

  /// `Your training goal`
  String get yourTrainingGoal {
    return Intl.message(
      'Your training goal',
      name: 'yourTrainingGoal',
      desc: '',
      args: [],
    );
  }

  /// `You workout in`
  String get youWorkoutIn {
    return Intl.message(
      'You workout in',
      name: 'youWorkoutIn',
      desc: '',
      args: [],
    );
  }

  /// `Plans by this Trainer`
  String get plansByThisTrainer {
    return Intl.message(
      'Plans by this Trainer',
      name: 'plansByThisTrainer',
      desc: '',
      args: [],
    );
  }

  /// `Available session`
  String get availableSession {
    return Intl.message(
      'Available session',
      name: 'availableSession',
      desc: '',
      args: [],
    );
  }

  /// `SAR/hour`
  String get sarHour {
    return Intl.message(
      'SAR/hour',
      name: 'sarHour',
      desc: '',
      args: [],
    );
  }

  /// `Start private session`
  String get startPrivateSession {
    return Intl.message(
      'Start private session',
      name: 'startPrivateSession',
      desc: '',
      args: [],
    );
  }

  /// `sets`
  String get sets {
    return Intl.message(
      'sets',
      name: 'sets',
      desc: '',
      args: [],
    );
  }

  /// `Trending Plan`
  String get trendingPlan {
    return Intl.message(
      'Trending Plan',
      name: 'trendingPlan',
      desc: '',
      args: [],
    );
  }

  /// `Did you finish your training? press Done to save your progress to your records.`
  String get didYouFinishYourTraining {
    return Intl.message(
      'Did you finish your training? press Done to save your progress to your records.',
      name: 'didYouFinishYourTraining',
      desc: '',
      args: [],
    );
  }

  /// `I"ll come back later`
  String get iLlComeBackLater {
    return Intl.message(
      'I"ll come back later',
      name: 'iLlComeBackLater',
      desc: '',
      args: [],
    );
  }

  /// `Set X`
  String get setX {
    return Intl.message(
      'Set X',
      name: 'setX',
      desc: '',
      args: [],
    );
  }

  /// `Let"s Go`
  String get letsGo {
    return Intl.message(
      'Let"s Go',
      name: 'letsGo',
      desc: '',
      args: [],
    );
  }

  /// `You can do it!`
  String get youCanDoItThisSet {
    return Intl.message(
      'You can do it!',
      name: 'youCanDoItThisSet',
      desc: '',
      args: [],
    );
  }

  /// `Great Job!`
  String get greatJob {
    return Intl.message(
      'Great Job!',
      name: 'greatJob',
      desc: '',
      args: [],
    );
  }

  /// `Take a break`
  String get takeABreak {
    return Intl.message(
      'Take a break',
      name: 'takeABreak',
      desc: '',
      args: [],
    );
  }

  /// `before the next exercise`
  String get beforeTheNextExercise {
    return Intl.message(
      'before the next exercise',
      name: 'beforeTheNextExercise',
      desc: '',
      args: [],
    );
  }

  /// `before the next set`
  String get beforeTheNextSet {
    return Intl.message(
      'before the next set',
      name: 'beforeTheNextSet',
      desc: '',
      args: [],
    );
  }

  /// `st set`
  String get stSet {
    return Intl.message(
      'st set',
      name: 'stSet',
      desc: '',
      args: [],
    );
  }

  /// `Repeat this Exercise`
  String get repeatThisExercise {
    return Intl.message(
      'Repeat this Exercise',
      name: 'repeatThisExercise',
      desc: '',
      args: [],
    );
  }

  /// `Slide to start the next Set`
  String get slideToStartTheNextSet {
    return Intl.message(
      'Slide to start the next Set',
      name: 'slideToStartTheNextSet',
      desc: '',
      args: [],
    );
  }

  /// `slide to start timer`
  String get slideToStartTheTimerForThisSet {
    return Intl.message(
      'slide to start timer',
      name: 'slideToStartTheTimerForThisSet',
      desc: '',
      args: [],
    );
  }

  /// `No Current Plan`
  String get noCurrentPlan {
    return Intl.message(
      'No Current Plan',
      name: 'noCurrentPlan',
      desc: '',
      args: [],
    );
  }

  /// `Our Trainers`
  String get ourTrainer {
    return Intl.message(
      'Our Trainers',
      name: 'ourTrainer',
      desc: '',
      args: [],
    );
  }

  /// `Private Sessions`
  String get privateSessions {
    return Intl.message(
      'Private Sessions',
      name: 'privateSessions',
      desc: '',
      args: [],
    );
  }

  /// `Plans`
  String get plans {
    return Intl.message(
      'Plans',
      name: 'plans',
      desc: '',
      args: [],
    );
  }

  /// `Subscriber`
  String get subscriber {
    return Intl.message(
      'Subscriber',
      name: 'subscriber',
      desc: '',
      args: [],
    );
  }

  /// `Private hours`
  String get privateHours {
    return Intl.message(
      'Private hours',
      name: 'privateHours',
      desc: '',
      args: [],
    );
  }

  /// `Trainer`
  String get trainer {
    return Intl.message(
      'Trainer',
      name: 'trainer',
      desc: '',
      args: [],
    );
  }

  /// `Trainers`
  String get trainers {
    return Intl.message(
      'Trainers',
      name: 'trainers',
      desc: '',
      args: [],
    );
  }

  /// `There are no TRAINERS in your search results, you can check our trainers and use FILTERS to find what you are looking for`
  String get thereAreNoTRAINERS {
    return Intl.message(
      'There are no TRAINERS in your search results, you can check our trainers and use FILTERS to find what you are looking for',
      name: 'thereAreNoTRAINERS',
      desc: '',
      args: [],
    );
  }

  /// `There are no appointments this week`
  String get thereAreNoAppointmentsThisWeek {
    return Intl.message(
      'There are no appointments this week',
      name: 'thereAreNoAppointmentsThisWeek',
      desc: '',
      args: [],
    );
  }

  /// `It"s not time for the call yet`
  String get itsNotTimeForTheCallYet {
    return Intl.message(
      'It"s not time for the call yet',
      name: 'itsNotTimeForTheCallYet',
      desc: '',
      args: [],
    );
  }

  /// `okay`
  String get okay {
    return Intl.message(
      'okay',
      name: 'okay',
      desc: '',
      args: [],
    );
  }

  /// `Start session`
  String get startSession {
    return Intl.message(
      'Start session',
      name: 'startSession',
      desc: '',
      args: [],
    );
  }

  /// `My Calender`
  String get myCalender {
    return Intl.message(
      'My Calender',
      name: 'myCalender',
      desc: '',
      args: [],
    );
  }

  /// `Book Private Session`
  String get bookPrivateSession {
    return Intl.message(
      'Book Private Session',
      name: 'bookPrivateSession',
      desc: '',
      args: [],
    );
  }

  /// `Book Session`
  String get bookSession {
    return Intl.message(
      'Book Session',
      name: 'bookSession',
      desc: '',
      args: [],
    );
  }

  /// `private session`
  String get privateSession {
    return Intl.message(
      'private session',
      name: 'privateSession',
      desc: '',
      args: [],
    );
  }

  /// `My Plans`
  String get myPlans {
    return Intl.message(
      'My Plans',
      name: 'myPlans',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get myProfile {
    return Intl.message(
      'My Profile',
      name: 'myProfile',
      desc: '',
      args: [],
    );
  }

  /// `SET MY AVAILABILITY`
  String get sETMYAVAILABILITY {
    return Intl.message(
      'SET MY AVAILABILITY',
      name: 'sETMYAVAILABILITY',
      desc: '',
      args: [],
    );
  }

  /// `PLANS BY ME`
  String get pLANSBYME {
    return Intl.message(
      'PLANS BY ME',
      name: 'pLANSBYME',
      desc: '',
      args: [],
    );
  }

  /// `CURRENT BALANCE`
  String get cURRENTBALANCE {
    return Intl.message(
      'CURRENT BALANCE',
      name: 'cURRENTBALANCE',
      desc: '',
      args: [],
    );
  }

  /// `No Wallet`
  String get noWallet {
    return Intl.message(
      'No Wallet',
      name: 'noWallet',
      desc: '',
      args: [],
    );
  }

  /// `Income`
  String get income {
    return Intl.message(
      'Income',
      name: 'income',
      desc: '',
      args: [],
    );
  }

  /// `Balance`
  String get balance {
    return Intl.message(
      'Balance',
      name: 'balance',
      desc: '',
      args: [],
    );
  }

  /// `Download Invoice`
  String get downloadInvoice {
    return Intl.message(
      'Download Invoice',
      name: 'downloadInvoice',
      desc: '',
      args: [],
    );
  }

  /// `Alert`
  String get alert {
    return Intl.message(
      'Alert',
      name: 'alert',
      desc: '',
      args: [],
    );
  }

  /// `SEARCH IN WORKOUT PLANS`
  String get sEARCHINWORKOUTPLANS {
    return Intl.message(
      'SEARCH IN WORKOUT PLANS',
      name: 'sEARCHINWORKOUTPLANS',
      desc: '',
      args: [],
    );
  }

  /// `Search in Trainer`
  String get sEARCHINTRAINER {
    return Intl.message(
      'Search in Trainer',
      name: 'sEARCHINTRAINER',
      desc: '',
      args: [],
    );
  }

  /// `Tap to Expand it`
  String get tapToExpandIt {
    return Intl.message(
      'Tap to Expand it',
      name: 'tapToExpandIt',
      desc: '',
      args: [],
    );
  }

  /// `Terms And Conditions`
  String get termAndCondition {
    return Intl.message(
      'Terms And Conditions',
      name: 'termAndCondition',
      desc: '',
      args: [],
    );
  }

  /// `Video initialized`
  String get videoInitialized {
    return Intl.message(
      'Video initialized',
      name: 'videoInitialized',
      desc: '',
      args: [],
    );
  }

  /// `Zumba`
  String get zumba {
    return Intl.message(
      'Zumba',
      name: 'zumba',
      desc: '',
      args: [],
    );
  }

  /// `See More`
  String get seeMore {
    return Intl.message(
      'See More',
      name: 'seeMore',
      desc: '',
      args: [],
    );
  }

  /// `Fitness Storm is a spirited application encouraging people to exercise anywhere and anytime and have the look they have always dreamed of.\nWhether you are a beginner or a pro, Fitness Storm gives you a golden chance to train with world class trainers through HD step-by-step instructional videos.\nLose weight, build muscle, and stay fit easily with the correct workouts and many effective training programs, designed by your favorite fitness experts. Sign up, answer a few questions, subscribe to one of our programs for 3 months, 6 months or 12 months and let us recommend the best plans that fits you. Get inspired with our amazing trainers and work out daily with step-by-step HD video instruction.\nNot convinced yet? To make every minute you train, play and compete – count, one to one session a unique program will be offered at fitness storm . If you want a more individualized approach to achieve the weight-loss, health, strength, injury prevention, or performance goals you have set for yourself, this program is designed for you where you can have a personal coach/dietitian  focusing on reaching your individual goals.\nIt is time to be stronger, healthier, and happier than ever before with Fitness Storm!`
  String get fitnessStormMessage {
    return Intl.message(
      'Fitness Storm is a spirited application encouraging people to exercise anywhere and anytime and have the look they have always dreamed of.\nWhether you are a beginner or a pro, Fitness Storm gives you a golden chance to train with world class trainers through HD step-by-step instructional videos.\nLose weight, build muscle, and stay fit easily with the correct workouts and many effective training programs, designed by your favorite fitness experts. Sign up, answer a few questions, subscribe to one of our programs for 3 months, 6 months or 12 months and let us recommend the best plans that fits you. Get inspired with our amazing trainers and work out daily with step-by-step HD video instruction.\nNot convinced yet? To make every minute you train, play and compete – count, one to one session a unique program will be offered at fitness storm . If you want a more individualized approach to achieve the weight-loss, health, strength, injury prevention, or performance goals you have set for yourself, this program is designed for you where you can have a personal coach/dietitian  focusing on reaching your individual goals.\nIt is time to be stronger, healthier, and happier than ever before with Fitness Storm!',
      name: 'fitnessStormMessage',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions\nFitness Storm is a dynamic application enables the users to train with world class trainers through HD step-by-step instructional videos.\n\nService description\nThis application is a registered business in Saudi Arabia.\nFitness Storm enables the users to train with world class trainers through HD step-by-step instructional videos and helping them to have the body shape they have always dreamed of.\n\nUsing this application\nYour use of this application is subject to your irrevocable acceptance without modification of these terms of use (the "Terms") and you agree to use this application in accordance with and subject to these terms. The Terms as set out hereunder constitute the entire agreement between you and fitness Storm,. If you do not read or accept these Terms, do not use this application. By accessing any part of fitness Storm application, you consent to be bound by these terms. As a condition of your use of this application, you undertake to fitness Storm that you will not use this application for any purpose that is unlawful or prohibited by these terms.\n\nImportant information\nCustomer using the application who are minor /under the age of 18 shall not register as a user of the application and shall not transact on or use the application only under the supervision of their parents.\nCardholder must retain a copy of transaction records and merchant policies and rules.\nYou are responsible for maintaining the confidentiality of his/her account.\nYou should never share your account information with anyone else.\nThe Developer reserves the right to cancel your account in case of finding any misuse of the application.\nYou are responsible for entering your information correctly when signing up to provide you with appropriate exercises that fits your activity level. As we offer exercises for beginners, moderately active and pro.\nUsers are responsible for selecting the right instructor and exercises for their needs. We are not responsible for any injury or harm might occur while exercising or performing inappropriate exercises.\nFitness Storm is targeting the individuals healthy enough to perform different types of exercises. In case you suffer from any injuries or specific health conditions, make sure to consult your physician before registering in our application.\nIf you are pregnant or breastfeeding, make sure that your doctor has specifically approved your use of the application.\n\nTerms and conditions for personal training:\nThe personal training sessions cannot be refunded, and the start and end dates of the sessions must be adhered to\n-Unforeseen circumstances may arise that result in rescheduling sessions, in which case the following policy will apply:\n- If you are forced to cancel the session within 24 days from the date of booking, the session will be compensated for free.\n- In case of canceling the session on the same day, the session will be deducted from the remaining sessions.\n-Personal training sessions are subject to an expiration period of 30 days from the date of participation.\n-The duration of the session is between 45 Mins to one hour\n-The session cannot be recorded via video, as it is subject to confidentiality between the trainer and the trainee.\n-Numbers/emails cannot be exchanged between the trainer and the trainee, and the service is provided through Fitness Storm.\n-Postponement is two sessions per month.\n-The postponement must be notified at least one day before the session, otherwise the session will be considered cancelled.\n-A date must be set to compensate for the postponed session within a week starting from the day of the postponement, or the session is considered cancelled.\n\n\nPayment processing\nWe accept payments through the available options in the application in SAR or USD. \n\nPayment confirmation\nOnce the payment is made, the confirmation notice will be sent to the client via email within 24 hours of receipt of payment.\n\nGoverning Law and Jurisdiction\nAny purchase, dispute or claim arising out of or in connection with this application shall be governed and construed in accordance with the laws of Saudi Arabia.\nThe application Policies and Terms & Conditions may be changed or updated occasionally to meet the requirements and standards. Therefore, the Customers are encouraged to frequently visit these sections in order to be updated about the changes on the application. Modifications will be effective on the day they are posted.`
  String get termsconditions {
    return Intl.message(
      'Terms & Conditions\nFitness Storm is a dynamic application enables the users to train with world class trainers through HD step-by-step instructional videos.\n\nService description\nThis application is a registered business in Saudi Arabia.\nFitness Storm enables the users to train with world class trainers through HD step-by-step instructional videos and helping them to have the body shape they have always dreamed of.\n\nUsing this application\nYour use of this application is subject to your irrevocable acceptance without modification of these terms of use (the "Terms") and you agree to use this application in accordance with and subject to these terms. The Terms as set out hereunder constitute the entire agreement between you and fitness Storm,. If you do not read or accept these Terms, do not use this application. By accessing any part of fitness Storm application, you consent to be bound by these terms. As a condition of your use of this application, you undertake to fitness Storm that you will not use this application for any purpose that is unlawful or prohibited by these terms.\n\nImportant information\nCustomer using the application who are minor /under the age of 18 shall not register as a user of the application and shall not transact on or use the application only under the supervision of their parents.\nCardholder must retain a copy of transaction records and merchant policies and rules.\nYou are responsible for maintaining the confidentiality of his/her account.\nYou should never share your account information with anyone else.\nThe Developer reserves the right to cancel your account in case of finding any misuse of the application.\nYou are responsible for entering your information correctly when signing up to provide you with appropriate exercises that fits your activity level. As we offer exercises for beginners, moderately active and pro.\nUsers are responsible for selecting the right instructor and exercises for their needs. We are not responsible for any injury or harm might occur while exercising or performing inappropriate exercises.\nFitness Storm is targeting the individuals healthy enough to perform different types of exercises. In case you suffer from any injuries or specific health conditions, make sure to consult your physician before registering in our application.\nIf you are pregnant or breastfeeding, make sure that your doctor has specifically approved your use of the application.\n\nTerms and conditions for personal training:\nThe personal training sessions cannot be refunded, and the start and end dates of the sessions must be adhered to\n-Unforeseen circumstances may arise that result in rescheduling sessions, in which case the following policy will apply:\n- If you are forced to cancel the session within 24 days from the date of booking, the session will be compensated for free.\n- In case of canceling the session on the same day, the session will be deducted from the remaining sessions.\n-Personal training sessions are subject to an expiration period of 30 days from the date of participation.\n-The duration of the session is between 45 Mins to one hour\n-The session cannot be recorded via video, as it is subject to confidentiality between the trainer and the trainee.\n-Numbers/emails cannot be exchanged between the trainer and the trainee, and the service is provided through Fitness Storm.\n-Postponement is two sessions per month.\n-The postponement must be notified at least one day before the session, otherwise the session will be considered cancelled.\n-A date must be set to compensate for the postponed session within a week starting from the day of the postponement, or the session is considered cancelled.\n\n\nPayment processing\nWe accept payments through the available options in the application in SAR or USD. \n\nPayment confirmation\nOnce the payment is made, the confirmation notice will be sent to the client via email within 24 hours of receipt of payment.\n\nGoverning Law and Jurisdiction\nAny purchase, dispute or claim arising out of or in connection with this application shall be governed and construed in accordance with the laws of Saudi Arabia.\nThe application Policies and Terms & Conditions may be changed or updated occasionally to meet the requirements and standards. Therefore, the Customers are encouraged to frequently visit these sections in order to be updated about the changes on the application. Modifications will be effective on the day they are posted.',
      name: 'termsconditions',
      desc: '',
      args: [],
    );
  }

  /// `Widgets that have global keys reparent\ntheir subtrees when they are moved from one\nlocation in the tree to another location in "\nthe tree. In order to reparent its subtree, \na widget must arrive at its new location in \nthe tree in the same animation frame in \nwhich it was removed from its old location \nthe tree.`
  String get globalKeysReparent {
    return Intl.message(
      'Widgets that have global keys reparent\ntheir subtrees when they are moved from one\nlocation in the tree to another location in "\nthe tree. In order to reparent its subtree, \na widget must arrive at its new location in \nthe tree in the same animation frame in \nwhich it was removed from its old location \nthe tree.',
      name: 'globalKeysReparent',
      desc: '',
      args: [],
    );
  }

  /// `Email Is Required`
  String get emailIsRequired {
    return Intl.message(
      'Email Is Required',
      name: 'emailIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Email`
  String get invalidEmail {
    return Intl.message(
      'Invalid Email',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Phone Number`
  String get invalidPhone {
    return Intl.message(
      'Invalid Phone Number',
      name: 'invalidPhone',
      desc: '',
      args: [],
    );
  }

  /// `Check Your Email`
  String get checkYourEmail {
    return Intl.message(
      'Check Your Email',
      name: 'checkYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password Is Required`
  String get passwordIsRequired {
    return Intl.message(
      'Password Is Required',
      name: 'passwordIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Name Is Required`
  String get nameIsRequired {
    return Intl.message(
      'Name Is Required',
      name: 'nameIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password Is Required`
  String get confirmPasswordIsRequired {
    return Intl.message(
      'Confirm Password Is Required',
      name: 'confirmPasswordIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Password Doesn"t Match`
  String get passwordDoesntMatch {
    return Intl.message(
      'Password Doesn"t Match',
      name: 'passwordDoesntMatch',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Enter New Password`
  String get enterNewPassword {
    return Intl.message(
      'Enter New Password',
      name: 'enterNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter Email Address`
  String get enterEmailAddress {
    return Intl.message(
      'Enter Email Address',
      name: 'enterEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter OTP Code`
  String get pleaseEnterOTPCode {
    return Intl.message(
      'Please Enter OTP Code',
      name: 'pleaseEnterOTPCode',
      desc: '',
      args: [],
    );
  }

  /// `Verification Code Has Been Sent Successfully`
  String get verificationSentSuccessfully {
    return Intl.message(
      'Verification Code Has Been Sent Successfully',
      name: 'verificationSentSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Not Login`
  String get notLogin {
    return Intl.message(
      'Not Login',
      name: 'notLogin',
      desc: '',
      args: [],
    );
  }

  /// `Enter Password`
  String get enterPassword {
    return Intl.message(
      'Enter Password',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Name`
  String get enterYourName {
    return Intl.message(
      'Enter Your Name',
      name: 'enterYourName',
      desc: '',
      args: [],
    );
  }

  /// `Weight Field is Required`
  String get weightFieldIsRequire {
    return Intl.message(
      'Weight Field is Required',
      name: 'weightFieldIsRequire',
      desc: '',
      args: [],
    );
  }

  /// `Height Field is Require`
  String get hightFieldIsRequire {
    return Intl.message(
      'Height Field is Require',
      name: 'hightFieldIsRequire',
      desc: '',
      args: [],
    );
  }

  /// `How many training days field is required`
  String get howManyYouTrainingFieldIsRequire {
    return Intl.message(
      'How many training days field is required',
      name: 'howManyYouTrainingFieldIsRequire',
      desc: '',
      args: [],
    );
  }

  /// `Training Level Field is Require`
  String get trainingLevelFieldIsRequire {
    return Intl.message(
      'Training Level Field is Require',
      name: 'trainingLevelFieldIsRequire',
      desc: '',
      args: [],
    );
  }

  /// `Training Goal Field is Require`
  String get trainingGoalFieldIsRequire {
    return Intl.message(
      'Training Goal Field is Require',
      name: 'trainingGoalFieldIsRequire',
      desc: '',
      args: [],
    );
  }

  /// `Weight`
  String get weight {
    return Intl.message(
      'Weight',
      name: 'weight',
      desc: '',
      args: [],
    );
  }

  /// ` times`
  String get times {
    return Intl.message(
      ' times',
      name: 'times',
      desc: '',
      args: [],
    );
  }

  /// ` time`
  String get time {
    return Intl.message(
      ' time',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `Workout Location Field is Require`
  String get workoutLocationFieldIsRequire {
    return Intl.message(
      'Workout Location Field is Require',
      name: 'workoutLocationFieldIsRequire',
      desc: '',
      args: [],
    );
  }

  /// `in Kg`
  String get inKg {
    return Intl.message(
      'in Kg',
      name: 'inKg',
      desc: '',
      args: [],
    );
  }

  /// `Height`
  String get hight {
    return Intl.message(
      'Height',
      name: 'hight',
      desc: '',
      args: [],
    );
  }

  /// `The Weeks`
  String get theWeeks {
    return Intl.message(
      'The Weeks',
      name: 'theWeeks',
      desc: '',
      args: [],
    );
  }

  /// `in Cm`
  String get inCm {
    return Intl.message(
      'in Cm',
      name: 'inCm',
      desc: '',
      args: [],
    );
  }

  /// `Hours/Day`
  String get hoursDay {
    return Intl.message(
      'Hours/Day',
      name: 'hoursDay',
      desc: '',
      args: [],
    );
  }

  /// `SEARCH`
  String get sEARCH {
    return Intl.message(
      'SEARCH',
      name: 'sEARCH',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get searchSmall {
    return Intl.message(
      'Search',
      name: 'searchSmall',
      desc: '',
      args: [],
    );
  }

  /// `See Result`
  String get seeResult {
    return Intl.message(
      'See Result',
      name: 'seeResult',
      desc: '',
      args: [],
    );
  }

  /// `Our Plans`
  String get ourPlans {
    return Intl.message(
      'Our Plans',
      name: 'ourPlans',
      desc: '',
      args: [],
    );
  }

  /// `Workout`
  String get workout {
    return Intl.message(
      'Workout',
      name: 'workout',
      desc: '',
      args: [],
    );
  }

  /// `Progress`
  String get progress {
    return Intl.message(
      'Progress',
      name: 'progress',
      desc: '',
      args: [],
    );
  }

  /// `UPGRADE PLAN`
  String get upgradePlan {
    return Intl.message(
      'UPGRADE PLAN',
      name: 'upgradePlan',
      desc: '',
      args: [],
    );
  }

  /// `Choose a Plan`
  String get chooseAPlan {
    return Intl.message(
      'Choose a Plan',
      name: 'chooseAPlan',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `skip`
  String get skip {
    return Intl.message(
      'skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Unsuccessful subscription`
  String get notSuccessfullySubscription {
    return Intl.message(
      'Unsuccessful subscription',
      name: 'notSuccessfullySubscription',
      desc: '',
      args: [],
    );
  }

  /// `Payment process not completed`
  String get notCompleteProcessPayment {
    return Intl.message(
      'Payment process not completed',
      name: 'notCompleteProcessPayment',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe`
  String get subscribe {
    return Intl.message(
      'Subscribe',
      name: 'subscribe',
      desc: '',
      args: [],
    );
  }

  /// `Week`
  String get week {
    return Intl.message(
      'Week',
      name: 'week',
      desc: '',
      args: [],
    );
  }

  /// `User already finished this day`
  String get finishedThisDay {
    return Intl.message(
      'User already finished this day',
      name: 'finishedThisDay',
      desc: '',
      args: [],
    );
  }

  /// `You need to book an appointment to have a private session with the coach`
  String get needBookPrivateSession {
    return Intl.message(
      'You need to book an appointment to have a private session with the coach',
      name: 'needBookPrivateSession',
      desc: '',
      args: [],
    );
  }

  /// `You will be no longer training with plan`
  String get yourSubscriptionToPlan {
    return Intl.message(
      'You will be no longer training with plan',
      name: 'yourSubscriptionToPlan',
      desc: '',
      args: [],
    );
  }

  /// `Your subscription to Fitness Storm has ended, kindly renew it to continue where you have stopped.`
  String get subscriptionFinished {
    return Intl.message(
      'Your subscription to Fitness Storm has ended, kindly renew it to continue where you have stopped.',
      name: 'subscriptionFinished',
      desc: '',
      args: [],
    );
  }

  /// `will be canceled`
  String get willBeCanceled {
    return Intl.message(
      'will be canceled',
      name: 'willBeCanceled',
      desc: '',
      args: [],
    );
  }

  /// `What is Fitness Storm?`
  String get whatIsFitnessStorm {
    return Intl.message(
      'What is Fitness Storm?',
      name: 'whatIsFitnessStorm',
      desc: '',
      args: [],
    );
  }

  /// `\nIt is a dynamic application in both Arabic and English languages that gives you a chance to train with world class trainers through HD step-by-step instructional videos.\n`
  String get itIsADynamicApplicationInBothArabic {
    return Intl.message(
      '\nIt is a dynamic application in both Arabic and English languages that gives you a chance to train with world class trainers through HD step-by-step instructional videos.\n',
      name: 'itIsADynamicApplicationInBothArabic',
      desc: '',
      args: [],
    );
  }

  /// `Can I contact the coach directly?`
  String get canIContactTheCoachDirectly {
    return Intl.message(
      'Can I contact the coach directly?',
      name: 'canIContactTheCoachDirectly',
      desc: '',
      args: [],
    );
  }

  /// `No, this option is not available yet.`
  String get noThisOptionIsNotAvailableYet {
    return Intl.message(
      'No, this option is not available yet.',
      name: 'noThisOptionIsNotAvailableYet',
      desc: '',
      args: [],
    );
  }

  /// `Can I Subscribe if I live outside Saudi Arabia?`
  String get canISubscribeIfILiveOutsideSaudiArabia {
    return Intl.message(
      'Can I Subscribe if I live outside Saudi Arabia?',
      name: 'canISubscribeIfILiveOutsideSaudiArabia',
      desc: '',
      args: [],
    );
  }

  /// `Sure, you can subscribe from anywhere in the globe.`
  String get sureYouCanSubscribeFromAnywhereInTheGlobe {
    return Intl.message(
      'Sure, you can subscribe from anywhere in the globe.',
      name: 'sureYouCanSubscribeFromAnywhereInTheGlobe',
      desc: '',
      args: [],
    );
  }

  /// `What plans do you offer to subscribe?`
  String get whatPlansDoYouOfferToSubscribe {
    return Intl.message(
      'What plans do you offer to subscribe?',
      name: 'whatPlansDoYouOfferToSubscribe',
      desc: '',
      args: [],
    );
  }

  /// `Are there exercises for beginners?`
  String get areThereExercisesForBeginners {
    return Intl.message(
      'Are there exercises for beginners?',
      name: 'areThereExercisesForBeginners',
      desc: '',
      args: [],
    );
  }

  /// `You should be subscribed with this coach in particular to have a conversation`
  String get makeChat {
    return Intl.message(
      'You should be subscribed with this coach in particular to have a conversation',
      name: 'makeChat',
      desc: '',
      args: [],
    );
  }

  /// ` Yes sure. Based on your personal info and physical activity, a list of high-HD exercise videos will show up to you. So, it doesn"t matter if you are a beginner or a Pro. `
  String get yesSureBasedOnYourPersonal {
    return Intl.message(
      ' Yes sure. Based on your personal info and physical activity, a list of high-HD exercise videos will show up to you. So, it doesn"t matter if you are a beginner or a Pro. ',
      name: 'yesSureBasedOnYourPersonal',
      desc: '',
      args: [],
    );
  }

  /// `Yes, they can.`
  String get yesTheyCan {
    return Intl.message(
      'Yes, they can.',
      name: 'yesTheyCan',
      desc: '',
      args: [],
    );
  }

  /// `Can I try your programs before subscribing?`
  String get canITryYourProgramsBeforeSubscribing {
    return Intl.message(
      'Can I try your programs before subscribing?',
      name: 'canITryYourProgramsBeforeSubscribing',
      desc: '',
      args: [],
    );
  }

  /// `Yes, sure there is 7 days free trial`
  String get yesSureThereIs7DaysFreeTrial {
    return Intl.message(
      'Yes, sure there is 7 days free trial',
      name: 'yesSureThereIs7DaysFreeTrial',
      desc: '',
      args: [],
    );
  }

  /// `How can I subscribe and pay?`
  String get howCanISubscribeAndPay {
    return Intl.message(
      'How can I subscribe and pay?',
      name: 'howCanISubscribeAndPay',
      desc: '',
      args: [],
    );
  }

  /// `You can subscribe and pay online through available payment options available through the application.`
  String get youCanSubscribeAndPay {
    return Intl.message(
      'You can subscribe and pay online through available payment options available through the application.',
      name: 'youCanSubscribeAndPay',
      desc: '',
      args: [],
    );
  }

  /// `What language is spoken in the videos?`
  String get whatLanguageIsSpokenInTheVideos {
    return Intl.message(
      'What language is spoken in the videos?',
      name: 'whatLanguageIsSpokenInTheVideos',
      desc: '',
      args: [],
    );
  }

  /// `Arabic and some expressions in English`
  String get arabicAndSomeExpressionsInEnglish {
    return Intl.message(
      'Arabic and some expressions in English',
      name: 'arabicAndSomeExpressionsInEnglish',
      desc: '',
      args: [],
    );
  }

  /// `WORKOUT PLANS`
  String get workoutPlans {
    return Intl.message(
      'WORKOUT PLANS',
      name: 'workoutPlans',
      desc: '',
      args: [],
    );
  }

  /// `Type Anything To Search It`
  String get typeAnythingToSearchIt {
    return Intl.message(
      'Type Anything To Search It',
      name: 'typeAnythingToSearchIt',
      desc: '',
      args: [],
    );
  }

  /// `What are you searching for?`
  String get whatAreYouSearchingFor {
    return Intl.message(
      'What are you searching for?',
      name: 'whatAreYouSearchingFor',
      desc: '',
      args: [],
    );
  }

  /// `FAQ`
  String get fAQ {
    return Intl.message(
      'FAQ',
      name: 'fAQ',
      desc: '',
      args: [],
    );
  }

  /// `Something Went Wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Something Went Wrong',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Failure`
  String get failure {
    return Intl.message(
      'Failure',
      name: 'failure',
      desc: '',
      args: [],
    );
  }

  /// `Mobile`
  String get mobile {
    return Intl.message(
      'Mobile',
      name: 'mobile',
      desc: '',
      args: [],
    );
  }

  /// `Height`
  String get height {
    return Intl.message(
      'Height',
      name: 'height',
      desc: '',
      args: [],
    );
  }

  /// ` Rep`
  String get rep {
    return Intl.message(
      ' Rep',
      name: 'rep',
      desc: '',
      args: [],
    );
  }

  /// ` Sec`
  String get sec {
    return Intl.message(
      ' Sec',
      name: 'sec',
      desc: '',
      args: [],
    );
  }

  /// `Your training level`
  String get yourTrainingLevel {
    return Intl.message(
      'Your training level',
      name: 'yourTrainingLevel',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contactUs {
    return Intl.message(
      'Contact Us',
      name: 'contactUs',
      desc: '',
      args: [],
    );
  }

  /// `Join us as a Trainer`
  String get joinUsAsATrainer {
    return Intl.message(
      'Join us as a Trainer',
      name: 'joinUsAsATrainer',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions`
  String get termsAndCondition {
    return Intl.message(
      'Terms and Conditions',
      name: 'termsAndCondition',
      desc: '',
      args: [],
    );
  }

  /// `SUBSCRIBERS`
  String get sUBSCRIBERSCap {
    return Intl.message(
      'SUBSCRIBERS',
      name: 'sUBSCRIBERSCap',
      desc: '',
      args: [],
    );
  }

  /// `Congrats`
  String get congrats {
    return Intl.message(
      'Congrats',
      name: 'congrats',
      desc: '',
      args: [],
    );
  }

  /// `Public`
  String get public {
    return Intl.message(
      'Public',
      name: 'public',
      desc: '',
      args: [],
    );
  }

  /// `Private`
  String get private {
    return Intl.message(
      'Private',
      name: 'private',
      desc: '',
      args: [],
    );
  }

  /// `Book`
  String get book {
    return Intl.message(
      'Book',
      name: 'book',
      desc: '',
      args: [],
    );
  }

  /// `Private Training`
  String get privateTraining {
    return Intl.message(
      'Private Training',
      name: 'privateTraining',
      desc: '',
      args: [],
    );
  }

  /// `Session with `
  String get sessionWith {
    return Intl.message(
      'Session with ',
      name: 'sessionWith',
      desc: '',
      args: [],
    );
  }

  /// `Wallet`
  String get wallet {
    return Intl.message(
      'Wallet',
      name: 'wallet',
      desc: '',
      args: [],
    );
  }

  /// `Calender`
  String get calender {
    return Intl.message(
      'Calender',
      name: 'calender',
      desc: '',
      args: [],
    );
  }

  /// `Trainer Profile`
  String get trainerProfile {
    return Intl.message(
      'Trainer Profile',
      name: 'trainerProfile',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Not Implemented`
  String get notImplemented {
    return Intl.message(
      'Not Implemented',
      name: 'notImplemented',
      desc: '',
      args: [],
    );
  }

  /// `Request Cancelled`
  String get requestCancelled {
    return Intl.message(
      'Request Cancelled',
      name: 'requestCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Internal Server Error`
  String get internalServerError {
    return Intl.message(
      'Internal Server Error',
      name: 'internalServerError',
      desc: '',
      args: [],
    );
  }

  /// `Service unavailable`
  String get serviceUnavailable {
    return Intl.message(
      'Service unavailable',
      name: 'serviceUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Method Allowed`
  String get methodAllowed {
    return Intl.message(
      'Method Allowed',
      name: 'methodAllowed',
      desc: '',
      args: [],
    );
  }

  /// `Bad request`
  String get badRequest {
    return Intl.message(
      'Bad request',
      name: 'badRequest',
      desc: '',
      args: [],
    );
  }

  /// `Unauthorised request`
  String get unauthorisedRequest {
    return Intl.message(
      'Unauthorised request',
      name: 'unauthorisedRequest',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected error occurred`
  String get unexpectedErrorOccurred {
    return Intl.message(
      'Unexpected error occurred',
      name: 'unexpectedErrorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `Connection request timeout`
  String get connectionRequestTimeout {
    return Intl.message(
      'Connection request timeout',
      name: 'connectionRequestTimeout',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection`
  String get noInternetConnection {
    return Intl.message(
      'No internet connection',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Error due to a conflict`
  String get errorDueToAConflict {
    return Intl.message(
      'Error due to a conflict',
      name: 'errorDueToAConflict',
      desc: '',
      args: [],
    );
  }

  /// `Send timeout in connection with API server`
  String get sendTimeoutinConnectionWithAPIserver {
    return Intl.message(
      'Send timeout in connection with API server',
      name: 'sendTimeoutinConnectionWithAPIserver',
      desc: '',
      args: [],
    );
  }

  /// `Unable to process the data`
  String get unableToProcessThedata {
    return Intl.message(
      'Unable to process the data',
      name: 'unableToProcessThedata',
      desc: '',
      args: [],
    );
  }

  /// `Not acceptable`
  String get notAcceptable {
    return Intl.message(
      'Not acceptable',
      name: 'notAcceptable',
      desc: '',
      args: [],
    );
  }

  /// `Password changed`
  String get passwordChanged {
    return Intl.message(
      'Password changed',
      name: 'passwordChanged',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password does not match password`
  String get confirmPasswordDoesNotMatchPassword {
    return Intl.message(
      'Confirm password does not match password',
      name: 'confirmPasswordDoesNotMatchPassword',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get lang {
    return Intl.message(
      'Language',
      name: 'lang',
      desc: '',
      args: [],
    );
  }

  /// `Did you like this Session ? `
  String get likeThisSession {
    return Intl.message(
      'Did you like this Session ? ',
      name: 'likeThisSession',
      desc: '',
      args: [],
    );
  }

  /// `Did you like this workout plan ? `
  String get likeThisWorkoutPlan {
    return Intl.message(
      'Did you like this workout plan ? ',
      name: 'likeThisWorkoutPlan',
      desc: '',
      args: [],
    );
  }

  /// `session`
  String get session {
    return Intl.message(
      'session',
      name: 'session',
      desc: '',
      args: [],
    );
  }

  /// `Shoulder Medial Lateral Roeeet Medial Lateral`
  String get lateralRoeeetMedialLateral {
    return Intl.message(
      'Shoulder Medial Lateral Roeeet Medial Lateral',
      name: 'lateralRoeeetMedialLateral',
      desc: '',
      args: [],
    );
  }

  /// `Day 4 `
  String get day4 {
    return Intl.message(
      'Day 4 ',
      name: 'day4',
      desc: '',
      args: [],
    );
  }

  /// `This day was already finished`
  String get alreadyPlay {
    return Intl.message(
      'This day was already finished',
      name: 'alreadyPlay',
      desc: '',
      args: [],
    );
  }

  /// `Renewal Price`
  String get renewalPrice {
    return Intl.message(
      'Renewal Price',
      name: 'renewalPrice',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure?`
  String get areYouSure {
    return Intl.message(
      'Are you sure?',
      name: 'areYouSure',
      desc: '',
      args: [],
    );
  }

  /// `Your subscription will NOT be renewed, you will be able to continue your fitness storm until your current subscription ends.`
  String get cancelRenewal {
    return Intl.message(
      'Your subscription will NOT be renewed, you will be able to continue your fitness storm until your current subscription ends.',
      name: 'cancelRenewal',
      desc: '',
      args: [],
    );
  }

  /// `Your subscription will be renewed with the new chosen bundle on`
  String get warningRenewal {
    return Intl.message(
      'Your subscription will be renewed with the new chosen bundle on',
      name: 'warningRenewal',
      desc: '',
      args: [],
    );
  }

  /// `Your account will be deleted with all your data, progress, and cancel any ongoing subscription.`
  String get warningDeleteAccount {
    return Intl.message(
      'Your account will be deleted with all your data, progress, and cancel any ongoing subscription.',
      name: 'warningDeleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Start training with this plan`
  String get startWithinPlan {
    return Intl.message(
      'Start training with this plan',
      name: 'startWithinPlan',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phone {
    return Intl.message(
      'Phone Number',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Coupon Code`
  String get coupon {
    return Intl.message(
      'Coupon Code',
      name: 'coupon',
      desc: '',
      args: [],
    );
  }

  /// `Subtotal`
  String get supTotal {
    return Intl.message(
      'Subtotal',
      name: 'supTotal',
      desc: '',
      args: [],
    );
  }

  /// `Voucher`
  String get voucher {
    return Intl.message(
      'Voucher',
      name: 'voucher',
      desc: '',
      args: [],
    );
  }

  /// `Net Total`
  String get netTotal {
    return Intl.message(
      'Net Total',
      name: 'netTotal',
      desc: '',
      args: [],
    );
  }

  /// `Your Fitness Storm membership will not be renewed. However, you will be able to continue using your membership until its end date.\n Why would you like to cancel your subscription? `
  String get whyCancel {
    return Intl.message(
      'Your Fitness Storm membership will not be renewed. However, you will be able to continue using your membership until its end date.\n Why would you like to cancel your subscription? ',
      name: 'whyCancel',
      desc: '',
      args: [],
    );
  }

  /// `Cancel reason`
  String get cancelReason {
    return Intl.message(
      'Cancel reason',
      name: 'cancelReason',
      desc: '',
      args: [],
    );
  }

  /// `Video Call`
  String get videoCall {
    return Intl.message(
      'Video Call',
      name: 'videoCall',
      desc: '',
      args: [],
    );
  }

  /// `Old Session`
  String get oldSession {
    return Intl.message(
      'Old Session',
      name: 'oldSession',
      desc: '',
      args: [],
    );
  }

  /// `Bundles`
  String get bundles {
    return Intl.message(
      'Bundles',
      name: 'bundles',
      desc: '',
      args: [],
    );
  }

  /// `Bundle`
  String get bundle {
    return Intl.message(
      'Bundle',
      name: 'bundle',
      desc: '',
      args: [],
    );
  }

  /// `Sessions Count`
  String get sessionsCount {
    return Intl.message(
      'Sessions Count',
      name: 'sessionsCount',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message(
      'Remove',
      name: 'remove',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Wrong`
  String get wrong {
    return Intl.message(
      'Wrong',
      name: 'wrong',
      desc: '',
      args: [],
    );
  }

  /// `Birth Date`
  String get birthDate {
    return Intl.message(
      'Birth Date',
      name: 'birthDate',
      desc: '',
      args: [],
    );
  }

  /// `Apply as Trainer`
  String get applyAsTrainer {
    return Intl.message(
      'Apply as Trainer',
      name: 'applyAsTrainer',
      desc: '',
      args: [],
    );
  }

  /// `CV`
  String get cv {
    return Intl.message(
      'CV',
      name: 'cv',
      desc: '',
      args: [],
    );
  }

  /// `send`
  String get send {
    return Intl.message(
      'send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `request`
  String get request {
    return Intl.message(
      'request',
      name: 'request',
      desc: '',
      args: [],
    );
  }

  /// `Booked`
  String get booked {
    return Intl.message(
      'Booked',
      name: 'booked',
      desc: '',
      args: [],
    );
  }

  /// `Available`
  String get available {
    return Intl.message(
      'Available',
      name: 'available',
      desc: '',
      args: [],
    );
  }

  /// `No Plans Found`
  String get noPlansFound {
    return Intl.message(
      'No Plans Found',
      name: 'noPlansFound',
      desc: '',
      args: [],
    );
  }

  /// `Certificate Of Graduation`
  String get certificateOfGraduation {
    return Intl.message(
      'Certificate Of Graduation',
      name: 'certificateOfGraduation',
      desc: '',
      args: [],
    );
  }

  /// `Certificate Of Course Attended`
  String get certificateOfCourseAttended {
    return Intl.message(
      'Certificate Of Course Attended',
      name: 'certificateOfCourseAttended',
      desc: '',
      args: [],
    );
  }

  /// `This Coach is Fully Booked!`
  String get fullyBooked {
    return Intl.message(
      'This Coach is Fully Booked!',
      name: 'fullyBooked',
      desc: '',
      args: [],
    );
  }

  /// `Notify me when there is an available date`
  String get noteMe {
    return Intl.message(
      'Notify me when there is an available date',
      name: 'noteMe',
      desc: '',
      args: [],
    );
  }

  /// `Next Session`
  String get nextSession {
    return Intl.message(
      'Next Session',
      name: 'nextSession',
      desc: '',
      args: [],
    );
  }

  /// `Rating`
  String get rating {
    return Intl.message(
      'Rating',
      name: 'rating',
      desc: '',
      args: [],
    );
  }

  /// `Review`
  String get review {
    return Intl.message(
      'Review',
      name: 'review',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Agreement`
  String get agreement {
    return Intl.message(
      'Agreement',
      name: 'agreement',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to\n`
  String get areYouSureFore {
    return Intl.message(
      'Are you sure you want to\n',
      name: 'areYouSureFore',
      desc: '',
      args: [],
    );
  }

  /// `Have a coupon ?`
  String get haveCoupon {
    return Intl.message(
      'Have a coupon ?',
      name: 'haveCoupon',
      desc: '',
      args: [],
    );
  }

  /// `Time Left to end call `
  String get timeLeftToEndCall {
    return Intl.message(
      'Time Left to end call ',
      name: 'timeLeftToEndCall',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Message`
  String get welcomeMessage {
    return Intl.message(
      'Welcome Message',
      name: 'welcomeMessage',
      desc: '',
      args: [],
    );
  }

  /// `Continue as Guest`
  String get guest {
    return Intl.message(
      'Continue as Guest',
      name: 'guest',
      desc: '',
      args: [],
    );
  }

  /// `Guest User`
  String get guestUser {
    return Intl.message(
      'Guest User',
      name: 'guestUser',
      desc: '',
      args: [],
    );
  }

  /// `Need login!`
  String get needLogin {
    return Intl.message(
      'Need login!',
      name: 'needLogin',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for your interest in joining us! \nWe have received your application and are currently reviewing it.`
  String get thxForApplyAsTrainer {
    return Intl.message(
      'Thank you for your interest in joining us! \nWe have received your application and are currently reviewing it.',
      name: 'thxForApplyAsTrainer',
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
      Locale.fromSubtags(languageCode: 'ar'),
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
