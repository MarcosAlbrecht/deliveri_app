import 'package:bloc/bloc.dart';
import 'package:delivery_app/app/pages/home/home_state.dart';
import 'package:delivery_app/app/repositories/product/product_repository.dart';

class HomeController extends Cubit<HomeState> {
  final ProductRepository productRepository;

  HomeController(this.productRepository) : super(HomeState.initial());

  Future<void> loadProducts() async {
    emit(state.copyWith(status: HomeStateStatus.loading));
    try {
      final products = await productRepository.finaAllProduct();
      emit(state.copyWith(status: HomeStateStatus.loaded, products: products));
    } catch (e) {}
  }
}
