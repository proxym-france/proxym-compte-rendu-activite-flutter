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

  /// `{craType, select, project{Project} formation{Formation} paidLeave{Paid leave} unpaidLeave{Unpaid leave} rTT{RTT} sickLeave{Sick Leave} exceptional{Exceptional}  holiday{Holiday} blank{Not Filled}}`
  String craTypes(Object craType) {
    return Intl.select(
      craType,
      {
        'project': 'Project',
        'formation': 'Formation',
        'paidLeave': 'Paid leave',
        'unpaidLeave': 'Unpaid leave',
        'rTT': 'RTT',
        'sickLeave': 'Sick Leave',
        'exceptional': 'Exceptional',
        'holiday': 'Holiday',
        'blank': 'Not Filled',
      },
      name: 'craTypes',
      desc: '',
      args: [craType],
    );
  }

  /// `{craFilters, select, all{All} notFilled{Not Filled} activity{Activity} leave{Leave}}`
  String craFilters(Object craFilters) {
    return Intl.select(
      craFilters,
      {
        'all': 'All',
        'notFilled': 'Not Filled',
        'activity': 'Activity',
        'leave': 'Leave',
      },
      name: 'craFilters',
      desc: '',
      args: [craFilters],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Select Date`
  String get selectDate {
    return Intl.message(
      'Select Date',
      name: 'selectDate',
      desc: '',
      args: [],
    );
  }

  /// `Select an activity`
  String get selectAnActivity {
    return Intl.message(
      'Select an activity',
      name: 'selectAnActivity',
      desc: '',
      args: [],
    );
  }

  /// `Add Activity`
  String get addActivity {
    return Intl.message(
      'Add Activity',
      name: 'addActivity',
      desc: '',
      args: [],
    );
  }

  /// `Fill Cra`
  String get fillCra {
    return Intl.message(
      'Fill Cra',
      name: 'fillCra',
      desc: '',
      args: [],
    );
  }

  /// `Unkown Error`
  String get unkownError {
    return Intl.message(
      'Unkown Error',
      name: 'unkownError',
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

  /// `please provide a password`
  String get pleaseProvideAPassword {
    return Intl.message(
      'please provide a password',
      name: 'pleaseProvideAPassword',
      desc: '',
      args: [],
    );
  }

  /// `Check your email`
  String get checkYourEmail {
    return Intl.message(
      'Check your email',
      name: 'checkYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `xxx@proxym-it.com or xxx@proxym.fr`
  String get mailPlaceHolder {
    return Intl.message(
      'xxx@proxym-it.com or xxx@proxym.fr',
      name: 'mailPlaceHolder',
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
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'fr'),
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
