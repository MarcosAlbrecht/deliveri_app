import 'package:delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:delivery_app/app/core/ui/widgets/delivery_appbar.dart';
import 'package:delivery_app/app/core/ui/widgets/delivery_button.dart';
import 'package:delivery_app/app/dto/order_product_dto.dart';
import 'package:delivery_app/app/models/product_model.dart';
import 'package:delivery_app/app/pages/auth/order/widgets/order_field.dart';
import 'package:delivery_app/app/pages/auth/order/widgets/order_product_tile.dart';
import 'package:delivery_app/app/pages/auth/order/widgets/payment_types_field.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppbar(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Text(
                      'Carrinho',
                      style: context.textStyles.textTitle,
                    ),
                    IconButton(onPressed: () {}, icon: Image.asset('assets/images/trashRegular.png')),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: 10,
                (context, index) {
                  return Column(
                    children: [
                      OrderProductTile(
                        index: index,
                        product: OrderProductDto(
                          product: ProductModel(
                            id: index,
                            name: 'Produto $index',
                            description: 'Descrição do produto $index',
                            price: index * 10,
                            image:
                                'https://img.freepik.com/psd-premium/delicious-fast-food-burger-pizza-png-imagem-transparente-de-alta-qualidade-para-stock-e-uso-comercial_1093584-250.jpg?semt=ais_hybrid&w=740&q=80',
                          ),
                          amount: index,
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                    ],
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total do pedido',
                          style: context.textStyles.textExtraBold.copyWith(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'R\$ 0,00',
                          style: context.textStyles.textExtraBold.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  OrderField(
                    title: 'Endereço de Entrega',
                    controller: TextEditingController(),
                    validator: Validatorless.required('Endereço de Entrega'),
                    hint: 'Digite o endereço de entrega',
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  OrderField(
                    title: 'CPF',
                    controller: TextEditingController(),
                    validator: Validatorless.required('CPF'),
                    hint: 'Digite o CPF',
                  ),

                  PaymentTypesField(),
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Divider(
                      color: Colors.grey,
                    ),
                    DeliveryButton(
                      width: double.infinity,
                      height: 45,
                      onPressed: () {},
                      label: 'Finalizar Pedido',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
