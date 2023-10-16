import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> load() async {
    await Future.delayed(const Duration(seconds: 3)).then(
      (value) => Modular.to.navigate('/home/'),
    );
  }

  @override
  void initState() {
    load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 120,
          child: Image.asset(
            'assets/images/busca_cep_logo.png',
          ),
        ),
      ),
    );
  }
}
