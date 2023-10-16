import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'shared/core/exports/app_exports.dart';
import 'shared/core/theme/app_theme.dart';
import 'shared/core/theme/change_theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ThemeData>(
      initialData: AppTheme.lightTheme.getTheme,
      stream: ChangeTheme.of(context)!.streamController.stream,
      builder: (context, snapshot) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Busca CEP',
        theme: snapshot.data,
        routerConfig: Modular.routerConfig,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          // Locale('en'),
          Locale('pt'),
        ],
      ),
    );
  }
}
