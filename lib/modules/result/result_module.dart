import 'package:flutter_modular/flutter_modular.dart';

import 'presenter/pages/result_page.dart';

class ResultModule extends Module {
  @override
  void routes(r) {
    r.child('/', child: (context) => ResultPage(result: r.args.data['result']));
  }
}
