// This file defines the widget of the whole (phone) app.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:contact_box/generated/l10n.dart';
import './pages/contact_list/layout.dart'; // The home page.
import '../colors/color_setting.dart';

/*
 * MaterialApp MobileApp Stateless{
 *   title: 'Contact Box',
 *   home: './pages/contact_list.dart'.ContactList()
 * }
 */
class MobileApp extends StatelessWidget{
  const MobileApp({super.key});

  // Build the MaterialApp, called by the `build()`.
  // `snapshot`: Got from FutureBuilder<ColorSheme>.
  Widget buildApp(AsyncSnapshot<ColorScheme> snapshot){
    return MaterialApp(
      // Title, homepage and route.
      title: "Contact Box", // TODO: make it i18ned with onGenerateTitle.
      home: const ContactListPage(),

      // I18n related things.
      localizationsDelegates: const [
        // The same as `S.delegate` but I hate single-name class names.
        I18nS.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('zh_CN')
      ],

      // Theme related things.
      theme: ThemeData(
        colorScheme: snapshot.data
      )
    );
  }

  @override
  Widget build(BuildContext context){
    // As which scheme to use depends on the settings, and operations like
    // reading from the settings are async functions, we will use
    // `FutureBuilder` here.
    return FutureBuilder<ColorScheme>(
      future: readFromSettings(),
      builder: (context, snapshot){
        // Judge `Snapshot.connectionState` which tells the operation state.
        // When the state is waiting:
        if (snapshot.connectionState == ConnectionState.waiting){
          return const CircularProgressIndicator();
        }
        // When error occurs:
        else if (snapshot.hasError){
          // TODO: i18n before I18nS is generated.
          return Text(
            'Error when reading from `shared_preferences`: $snapshot.error'
          );
        }
        // When the work of reading has done, generate the app:
        else {
          return buildApp(snapshot);
        }
      }
    );
  }
}