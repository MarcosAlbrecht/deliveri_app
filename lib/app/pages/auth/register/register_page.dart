import 'package:delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:delivery_app/app/core/ui/widgets/delivery_appbar.dart';
import 'package:delivery_app/app/core/ui/widgets/delivery_button.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppbar(),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cadastro',
                    style: context.textStyles.textTitle,
                  ),
                  Text(
                    'Preencha os campos abaixo para se cadastrar',
                    style: context.textStyles.textRegular,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Nome'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text('E-mail'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Senha'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Confirme a Senha'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: DeliveryButton(
                      width: double.infinity,
                      onPressed: () {},
                      label: 'Cadastrar',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
