import 'package:delivery_app/app/core/extensions/formatter_extension.dart';
import 'package:delivery_app/app/core/ui/styles/colors_app.dart';
import 'package:delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:delivery_app/app/core/ui/widgets/delivery_increment_decrement_button.dart';
import 'package:delivery_app/app/dto/order_product_dto.dart';
import 'package:flutter/material.dart';

class OrderProductTile extends StatelessWidget {
  final int index;
  final OrderProductDto product;

  const OrderProductTile({super.key, required this.index, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          FadeInImage.assetNetwork(
            placeholder: 'assets/images/loading.gif',
            image: product.product.image,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
            imageErrorBuilder: (context, error, stackTrace) {
              return SizedBox(
                height: 100,
                width: 100,
                child: Center(
                  child: Icon(
                    Icons.warning,
                    size: 32,
                  ),
                ),
              );
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.product.name,
                    style: context.textStyles.textRegular.copyWith(fontSize: 16),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.product.price.currencyPTBR,
                        style: context.textStyles.textRegular.copyWith(
                          fontSize: 16,
                          color: context.colors.secondary,
                        ),
                      ),
                      DeliveryIncrementDecrementButton(
                        amount: product.amount,
                        incrementTap: () {},
                        decrementTap: () {},
                        compact: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
