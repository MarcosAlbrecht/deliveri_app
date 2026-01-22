import 'dart:developer';

import 'package:delivery_app/app/dto/order_dto.dart';
import 'package:delivery_app/app/dto/order_product_dto.dart';
import 'package:delivery_app/app/pages/order/order_state.dart';
import 'package:delivery_app/app/repositories/order/order_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderController extends Cubit<OrderState> {
  final OrderRepository repository;
  OrderController(this.repository) : super(OrderState.initial());

  void load(List<OrderProductDto> products) async {
    try {
      emit(state.copyWith(status: OrderStatus.loading));
      final paymentTypes = await repository.getAllPaymentsTypes();
      emit(
        state.copyWith(
          orderProducts: products,
          status: OrderStatus.loaded,
          paymentTypes: paymentTypes,
        ),
      );
    } on Exception catch (e, s) {
      log('Erro ao carregar dados do pedido', error: e, stackTrace: s);
      emit(state.copyWith(status: OrderStatus.error, errorMessage: 'Erro ao carregar dados do pedido'));
    }
  }

  void incrementeProduct(int index) {
    final orders = [...state.orderProducts];
    final order = orders[index];
    orders[index] = order.copyWith(amount: order.amount + 1);
    emit(state.copyWith(orderProducts: orders, status: OrderStatus.updateOrder));
  }

  void decrementeProduct(int index) {
    final orders = [...state.orderProducts];
    final order = orders[index];

    if (order.amount == 1) {
      if (state.status != OrderStatus.confirmRemoveProduct) {
        emit(
          OrderConfirmDeleteProductState(
            orderProduct: order,
            index: index,
            status: OrderStatus.confirmRemoveProduct,
            orderProducts: state.orderProducts,
            paymentTypes: state.paymentTypes,
            errorMessage: state.errorMessage,
          ),
        );
        return;
      } else {
        orders.removeAt(index);
      }
    } else {
      orders[index] = order.copyWith(amount: order.amount - 1);
    }
    if (orders.isEmpty) {
      emit(state.copyWith(status: OrderStatus.emptyBag));
      return;
    }
    emit(state.copyWith(orderProducts: orders, status: OrderStatus.updateOrder));
  }

  void cancelDeleteProcess() {
    emit(state.copyWith(status: OrderStatus.loaded));
  }

  void removeProduct(int index) {
    final orders = [...state.orderProducts];
    orders.removeAt(index);
    emit(state.copyWith(orderProducts: orders, status: OrderStatus.updateOrder));
  }

  void emptyBag() {
    emit(state.copyWith(orderProducts: [], status: OrderStatus.emptyBag));
  }

  void saveOrder({required int paymentMethodId, required String address, required String document}) async {
    emit(state.copyWith(status: OrderStatus.loading));
    await repository.saveOrder(
      OrderDto(
        products: state.orderProducts,
        paymentMethodId: paymentMethodId,
        address: address,
        document: document,
      ),
    );
    emit(state.copyWith(status: OrderStatus.success));
  }
}
