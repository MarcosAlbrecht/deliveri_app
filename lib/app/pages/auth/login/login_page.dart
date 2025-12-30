import 'package:delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:delivery_app/app/core/ui/widgets/delivery_appbar.dart';
import 'package:delivery_app/app/core/ui/widgets/delivery_button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppbar(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: context.textStyles.textTitle,
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
                        height: 50,
                      ),
                      Center(
                        child: DeliveryButton(
                          width: double.infinity,
                          onPressed: () {},
                          label: 'Entrar',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: AlignmentGeometry.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Não tem uma conta?', style: context.textStyles.textBold),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/auth/register');
                        },
                        child: Text(
                          'Cadastre-se',
                          style: context.textStyles.textBold.copyWith(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
