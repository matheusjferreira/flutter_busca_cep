import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../shared/core/exports/app_exports.dart';
import '../../../../shared/core/theme/app_theme.dart';
import '../../../../shared/core/theme/change_theme.dart';
import '../../../../shared/widgets/snack_bar_widget.dart';
import '../../domain/entities/cep_entity.dart';
import '../bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _bloc = Modular.get<HomeBloc>();
  final _formKey = GlobalKey<FormState>();
  final _cepController = TextEditingController();
  AddressEntity? _cepEntity;
  String? cepWithMask;

  bool _darkMode = false;
  final IconData _iconLight = Icons.wb_sunny;
  final IconData _iconDark = Icons.nights_stay;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _bloc,
      listener: (context, state) {
        if (state is HomeLoaded) {
          if (state.cepEntity?.cep != null && state.cepEntity?.cep != '') {
            _buildNextPage(state.cepEntity);
          } else {
            return SnackBarWidget.show(
              context,
              message: AppLocalizations.of(context)!.zipCodeNot,
              backgroundColor: Colors.red.shade300,
            );
          }
        }

        if (state is HomeError) {
          return SnackBarWidget.show(
            context,
            message: state.message,
            backgroundColor: Colors.red.shade300,
          );
        }
      },
      builder: (context, state) {
        return _buildPage();
      },
    );
  }

  Widget _buildPage() {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.zipCodeSearch),
        actions: [
          IconButton(
              onPressed: () {
                ChangeTheme.of(context)!.streamController.add(_darkMode
                    ? AppTheme.lightTheme.getTheme
                    : AppTheme.darkTheme.getTheme);
                setState(() {
                  _darkMode = !_darkMode;
                });
              },
              icon: Icon(_darkMode ? _iconDark : _iconLight))
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  AppLocalizations.of(context)!.welcome,
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                Text(
                  AppLocalizations.of(context)!.enterTheDesired,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.normal),
                ),
                const SizedBox(height: 104),
                TextFormField(
                  controller: _cepController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.pleaseEnterSome;
                    }

                    return null;
                  },
                  maxLength: 8,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (_formKey.currentState!.validate() &&
                        _cepController.text.isNotEmpty) {
                      setState(() {
                        cepWithMask =
                            '${_cepController.text.substring(0, 5)}-${_cepController.text.substring(5, 8)}';
                      });

                      _bloc.add(GetAddressEvent(cep: cepWithMask ?? ''));
                    }
                  },
                  child: Text(AppLocalizations.of(context)!.toLookFor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildNextPage(data) {
    setState(() {
      _cepEntity = data;
    });
    Modular.to.pushNamed('/result/', arguments: {'result': _cepEntity});
  }
}
