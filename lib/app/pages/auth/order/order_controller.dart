import 'package:delivery_app/app/dto/order_product_dto.dart';
import 'package:delivery_app/app/pages/auth/order/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderController extends Cubit<OrderState> {
  OrderController() : super(OrderState.initial());

  void load(List<OrderProductDto> products) {
    emit(
      state.copyWith(
        orderProducts: products,
      ),
    );
  }
}
