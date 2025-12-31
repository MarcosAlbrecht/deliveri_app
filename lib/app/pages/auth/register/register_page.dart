import 'package:delivery_app/app/core/ui/base_state/base_state.dart';
import 'package:delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:delivery_app/app/core/ui/widgets/delivery_appbar.dart';
import 'package:delivery_app/app/core/ui/widgets/delivery_button.dart';
import 'package:delivery_app/app/pages/auth/register/register_controller.dart';
import 'package:delivery_app/app/pages/auth/register/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPage, RegisterController> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  bool _obscureText = true;
  bool _obscureTextConfirm = true;

  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  void obscureText() {
    return setState(() {
      _obscureText = !_obscureText;
    });
  }

  void obscureTextConfirm() {
    return setState(() {
      _obscureTextConfirm = !_obscureTextConfirm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterController, RegisterState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          register: () => showLoader(),
          error: () {
            hideLoader();
            showError('Erro ao registrar usuário');
          },
          success: () {
            hideLoader();
            showSuccess('Cadastro realizado com sucesso!');
            Navigator.pop(context);
          },
        );
      },
      child: Scaffold(
        appBar: DeliveryAppbar(),

        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
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
                      validator: Validatorless.required('Nome obrigatório'),
                      controller: _nameEC,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text('E-mail'),
                        border: OutlineInputBorder(),
                      ),
                      validator: Validatorless.multiple([
                        Validatorless.required('E-mail obrigatório'),
                        Validatorless.email('E-mail inválido'),
                      ]),
                      controller: _emailEC,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        label: const Text('Senha'),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () => obscureText(),
                          icon: Icon(
                            _obscureText ? Icons.visibility_off : Icons.remove_red_eye,
                          ),
                        ),
                      ),
                      validator: Validatorless.multiple([
                        Validatorless.required('Senha obrigatória'),
                        Validatorless.min(6, 'Senha deve ter pelo menos 6 caracteres'),
                      ]),
                      obscureText: _obscureText,
                      controller: _passwordEC,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        label: const Text('Confirme a Senha'),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () => obscureTextConfirm(),
                          icon: Icon(
                            _obscureTextConfirm ? Icons.visibility_off : Icons.remove_red_eye,
                          ),
                        ),
                      ),
                      obscureText: _obscureTextConfirm,
                      validator: Validatorless.multiple([
                        Validatorless.required('Confirmação de senha obrigatória'),
                        Validatorless.compare(_passwordEC, 'Senhas não conferem'),
                      ]),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: DeliveryButton(
                        width: double.infinity,
                        onPressed: () {
                          final valid = _formKey.currentState?.validate() ?? false;
                          if (valid) {
                            controller.register(
                              _nameEC.text,
                              _emailEC.text,
                              _passwordEC.text,
                            );
                          }
                        },
                        label: 'Cadastrar',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
