import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_app/app/core/ui/helpers/size_extensions.dart';
import 'package:delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:delivery_app/app/core/ui/widgets/delivery_appbar.dart';
import 'package:delivery_app/app/core/ui/widgets/delivery_increment_decrement_button.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppbar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: context.screenWidth,
              height: context.percentHeight(.4),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://static.vecteezy.com/system/resources/previews/027/145/316/non_2x/delicious-gourmet-burger-isolated-on-transparent-background-png.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'X-Burguer',
                style: context.textStyles.textExtraBold.copyWith(fontSize: 22),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: Text(
                    'Lanche acompanha pao, hamruguer 120g, mussarela, maionese, picles, bacon ',
                    style: context.textStyles.textMediun,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  width: context.percentWidth(.5),
                  height: 60,
                  padding: EdgeInsets.all(8),
                  child: DeliveryIncrementDecrementButton(),
                ),
                Container(
                  width: context.percentWidth(.5),
                  height: 60,
                  padding: EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Adicionar',
                          style: context.textStyles.textExtraBold.copyWith(fontSize: 13),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: AutoSizeText(
                            r'R$ 10555,99',
                            maxFontSize: 13,
                            minFontSize: 5,
                            maxLines: 1,
                            style: context.textStyles.textExtraBold.copyWith(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
