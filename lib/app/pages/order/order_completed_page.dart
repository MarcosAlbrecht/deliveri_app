import 'package:delivery_app/app/core/ui/helpers/size_extensions.dart';
import 'package:delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:delivery_app/app/core/ui/widgets/delivery_button.dart';
import 'package:flutter/material.dart';

class OrderCompletedPage extends StatefulWidget {
  const OrderCompletedPage({super.key});

  @override
  State<OrderCompletedPage> createState() => _OrderCompletedPageState();
}

class _OrderCompletedPageState extends State<OrderCompletedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: context.percentHeight(0.2),
                ),
                Image.asset('assets/images/logo_rounded.png'),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Pedido realizado com sucesso, em breve vocë receberá a confirmacao do pedido',
                  textAlign: TextAlign.center,
                  style: context.textStyles.textExtraBold.copyWith(fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
                DeliveryButton(
                  width: context.percentWidth(0.8),
                  label: 'Fechar',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
