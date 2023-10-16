import 'package:flutter_modular/flutter_modular.dart';

import 'modules/home/home_module.dart';
import 'modules/result/result_module.dart';
import 'modules/splash/splash_module.dart';

class AppModule extends Module {
  @override
  void routes(r) {
    r.module('/', module: SplashModule());
    r.module('/home', module: HomeModule());
    r.module('/result', module: ResultModule());
  }
}
