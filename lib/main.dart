
import 'package:flutter_localizations/src/cupertino_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './states/settings.dart' show settings;

import './application.dart';


void main() async {
  runApp(CupertinoApp(
    debugShowCheckedModeBanner: false,
    supportedLocales: [
          const Locale('en', 'US'),
          const Locale('ru', 'RU'),
          const Locale('ar', 'AR'),
          const Locale('de', 'DE'),
          const Locale('es', 'ES'),
          const Locale('fr', 'FR'),
          const Locale('el', 'EL'),
          const Locale('it', 'IT'),
          const Locale('ja', 'JA'),
          const Locale('ko', 'KO'),
          const Locale('nl', 'NL'),
          const Locale('pl', 'PL'),
          const Locale('pt', 'PT'),
          const Locale('tr', 'TR'),
          const Locale('vi', 'VI'),
          const Locale('zh', 'ZH'),
          const Locale('zh_TW', 'ZH_TW')
        ],
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate
        ],
    home: 
    Container(color: Colors.white, child:
      LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          settings.screenWidth = constraints.maxWidth;
          settings.screenHeight = constraints.maxHeight;
          settings.viewPadding = MediaQuery.of(context).viewPadding.copyWith();
          settings.locale = Localizations.localeOf(context).languageCode;

          return Application();
        }
      )
    )
  ));
}