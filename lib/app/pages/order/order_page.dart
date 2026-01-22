import 'package:delivery_app/app/core/extensions/formatter_extension.dart';
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
  final formKey = GlobalKey<FormState>();
  final addressEC = TextEditingController();
  final documentEC = TextEditingController();
  int? paymentTypeId;

  final paymentTypeValid = ValueNotifier<bool>(true);

  @override
  void onReady() {
    final products = ModalRoute.of(context)!.settings.arguments as List<OrderProductDto>;
    controller.load(products);
  }

  void _showConfirmDeleteDialog(OrderConfirmDeleteProductState state) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmar remoção'),
          content: Text('Deseja remover o produto ${state.orderProduct.product.name} do carrinho?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                controller.cancelDeleteProcess();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                controller.decrementeProduct(state.index);
              },
              child: Text('Remover'),
            ),
          ],
        );
      },
    );
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
          confirmRemoveProduct: () {
            hideLoader();
            if (state is OrderConfirmDeleteProductState) {
              _showConfirmDeleteDialog(state);
            }
          },
          emptyBag: () {
            hideLoader();
            showInfo('Carrinho vazio. Selecione produtos para realizar seu pedido.');
            Navigator.pop(context, <OrderProductDto>[]);
          },
          success: () {
            hideLoader();
            showSuccess('Pedido salvo com sucesso!');
            Navigator.of(context).popAndPushNamed('/order/completed', result: <OrderProductDto>[]);
          },
        );
      },
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;

          Navigator.of(context).pop(controller.state.orderProducts);
        },
        child: Scaffold(
          appBar: DeliveryAppbar(),
          body: SafeArea(
            child: Form(
              key: formKey,
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
                          IconButton(
                            onPressed: () {
                              controller.emptyBag();
                            },
                            icon: Image.asset('assets/images/trashRegular.png'),
                          ),
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
                              BlocSelector<OrderController, OrderState, double>(
                                selector: (state) {
                                  return state.totalOrder;
                                },
                                builder: (context, totalOrder) {
                                  return Text(
                                    totalOrder.currencyPTBR,
                                    style: context.textStyles.textExtraBold.copyWith(
                                      fontSize: 16,
                                    ),
                                  );
                                },
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
                          controller: addressEC,
                          validator: Validatorless.required('Endereço obrigatório'),
                          hint: 'Digite o endereço de entrega',
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        OrderField(
                          title: 'CPF',
                          controller: documentEC,
                          validator: Validatorless.required('CPF obrigatório'),
                          hint: 'Digite o CPF',
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        BlocSelector<OrderController, OrderState, List<PaymentTypeModel>>(
                          selector: (state) {
                            return state.paymentTypes;
                          },
                          builder: (context, paymentTypes) {
                            return ValueListenableBuilder(
                              valueListenable: paymentTypeValid,
                              builder: (_, paymentTypeValidValue, child) {
                                return PaymentTypesField(
                                  paymentTypes: paymentTypes,
                                  valueChanged: (value) {
                                    paymentTypeId = value;
                                    paymentTypeValid.value = paymentTypeId != null;
                                  },
                                  valid: paymentTypeValidValue,
                                  valueSelected: paymentTypeId.toString(),
                                );
                              },
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
                            onPressed: () {
                              final valid = formKey.currentState?.validate() ?? false;
                              final paymentTypeSelected = paymentTypeId != null;
                              paymentTypeValid.value = paymentTypeSelected;

                              if (valid && paymentTypeSelected) {
                                controller.saveOrder(
                                  paymentMethodId: paymentTypeId!,
                                  address: addressEC.text,
                                  document: documentEC.text,
                                );
                              }
                            },
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
        ),
      ),
    );
  }
}
