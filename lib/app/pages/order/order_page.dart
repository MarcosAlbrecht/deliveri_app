import 'package:delivery_app/app/core/ui/base_state/base_state.dart';
import 'package:delivery_app/app/core/ui/helpers/messages.dart';
import 'package:delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:delivery_app/app/core/ui/widgets/delivery_appbar.dart';
import 'package:delivery_app/app/core/ui/widgets/delivery_button.dart';
import 'package:delivery_app/app/dto/order_product_dto.dart';
import 'package:delivery_app/app/models/payment_type_model.dart';
import 'package:delivery_app/app/pages/order/order_controller.dart';
import 'package:delivery_app/app/pages/order/order_state.dart';
import 'package:delivery_app/app/pages/order/widgets/order_field.dart';
import 'package:delivery_app/app/pages/order/widgets/order_product_tile.dart';
import 'package:delivery_app/app/pages/order/widgets/payment_types_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends BaseState<OrderPage, OrderController> with Messages<OrderPage> {
  @override
  void onReady() {
    final products = ModalRoute.of(context)!.settings.arguments as List<OrderProductDto>;
    controller.load(products);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderController, OrderState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          loading: () => showLoader(),
          error: () {
            hideLoader();
            showError(state.errorMessage!);
          },
        );
      },
      child: Scaffold(
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
              BlocSelector<OrderController, OrderState, List<OrderProductDto>>(
                selector: (state) => state.orderProducts,
                builder: (context, state) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: state.length,
                      (context, index) {
                        return Column(
                          children: [
                            OrderProductTile(
                              product: state[index],
                              index: index,
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
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

                    BlocSelector<OrderController, OrderState, List<PaymentTypeModel>>(
                      selector: (state) {
                        return state.paymentTypes;
                      },
                      builder: (context, paymentTypes) {
                        return PaymentTypesField(
                          paymentTypes: paymentTypes,
                        );
                      },
                    ),
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
      ),
    );
  }
}
