import 'package:delivery_app/app/dto/order_product_dto.dart';

class OrderDto {
  final List<OrderProductDto> products;
  final int paymentMethodId;
  final String address;
  final String document;

  OrderDto({
    required this.products,
    required this.paymentMethodId,
    required this.address,
    required this.document,
  });
}
