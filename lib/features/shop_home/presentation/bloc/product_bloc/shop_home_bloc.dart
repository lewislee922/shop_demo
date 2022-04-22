import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_demo/features/shop_home/domain/repositories/product_data_repository.dart';
import 'package:shop_demo/features/shop_home/domain/repositories/user_data_repository.dart';

part 'shop_home_event.dart';
part 'shop_home_state.dart';

class ShopHomeBloc extends Bloc<ShopHomeEvent, ShopHomeState> {
  final ProductDataRepository productRepository;
  final UserDataRepository userRepository;
  ShopHomeBloc(this.userRepository, this.productRepository)
      : super(ShopHomeInitial()) {
    on<FetchProductEvent>((event, emit) async {
      emit(ShopHomeLoading());
      final _parameter = event.parameters;
      try {
        final _allCategory = await productRepository.getAllCategory();
        final _products = await productRepository.getProducts(
            _parameter['getAll'] ?? false, _parameter['category']);
        final _user = await userRepository.fetchUserData(_parameter['id']);
        final _result = {
          "category": _allCategory,
          "products": _products,
          "user": _user
        };
        emit(ShopHomeFinish(_result));
      } catch (e) {
        rethrow;
      }
    });
  }
}
