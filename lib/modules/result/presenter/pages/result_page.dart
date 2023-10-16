import 'package:flutter/material.dart';

import '../../../../shared/core/exports/app_exports.dart';
import '../../../../shared/widgets/snack_bar_widget.dart';
import '../../../home/domain/entities/cep_entity.dart';

class ResultPage extends StatefulWidget {
  final AddressEntity result;

  const ResultPage({
    super.key,
    required this.result,
  });

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SnackBarWidget.show(
        context,
        message: AppLocalizations.of(context)!.zipCodeFound,
        backgroundColor: Colors.green.shade300,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.result)),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildText(
              AppLocalizations.of(context)!.cep,
              widget.result.cep,
            ),
            _buildText(
              AppLocalizations.of(context)!.publicPlace,
              widget.result.logradouro,
            ),
            _buildText(
              AppLocalizations.of(context)!.complement,
              widget.result.complemento,
            ),
            _buildText(
              AppLocalizations.of(context)!.neighborhood,
              widget.result.bairro,
            ),
            _buildText(
              AppLocalizations.of(context)!.location,
              widget.result.localidade,
            ),
            _buildText(
              AppLocalizations.of(context)!.uf,
              widget.result.uf,
            ),
            _buildText(
              AppLocalizations.of(context)!.ibge,
              widget.result.ibge,
            ),
            _buildText(
              AppLocalizations.of(context)!.gia,
              widget.result.gia,
            ),
            _buildText(
              AppLocalizations.of(context)!.ddd,
              widget.result.ddd,
            ),
            _buildText(
              AppLocalizations.of(context)!.siafi,
              widget.result.siafi,
            ),
          ],
        ),
      ),
    );
  }

  _buildText(String label, String result) {
    const styleLabel = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    const styleResult = TextStyle(
        fontSize: 16, fontWeight: FontWeight.normal, color: Colors.blue);

    return Row(
      children: [
        Text(
          label,
          style: styleLabel,
        ),
        Text(
          result,
          style: styleResult,
        ),
      ],
    );
  }
}
