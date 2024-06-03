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

class I18nS {
  I18nS();

  static I18nS? _current;

  static I18nS get current {
    assert(_current != null,
        'No instance of I18nS was loaded. Try to initialize the I18nS delegate before accessing I18nS.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<I18nS> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = I18nS();
      I18nS._current = instance;

      return instance;
    });
  }

  static I18nS of(BuildContext context) {
    final instance = I18nS.maybeOf(context);
    assert(instance != null,
        'No instance of I18nS present in the widget tree. Did you add I18nS.delegate in localizationsDelegates?');
    return instance!;
  }

  static I18nS? maybeOf(BuildContext context) {
    return Localizations.of<I18nS>(context, I18nS);
  }

  /// `Contact Box`
  String get contactBox {
    return Intl.message(
      'Contact Box',
      name: 'contactBox',
      desc: 'The name of the app.',
      args: [],
    );
  }

  /// `Contact List`
  String get contactList {
    return Intl.message(
      'Contact List',
      name: 'contactList',
      desc: 'The title on the top of the home page.',
      args: [],
    );
  }

  /// `{count, plural, zero{No contacts yet} one{1 contact in total} other{# contacts in total}}`
  String contactCount(num count) {
    return Intl.plural(
      count,
      zero: 'No contacts yet',
      one: '1 contact in total',
      other: '# contacts in total',
      name: 'contactCount',
      desc:
          'Show how may contacts the user has added, on the bottom of the home page.',
      args: [count],
    );
  }

  /// `Error when reading from 'shared_preferences'`
  String get errReadingFromSharedPreferences {
    return Intl.message(
      'Error when reading from `shared_preferences`',
      name: 'errReadingFromSharedPreferences',
      desc:
          '`shared_preferences` stores the settings of the app. When building the MaterialApp, it should be read.',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<I18nS> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<I18nS> load(Locale locale) => I18nS.load(locale);
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
