import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menteck_app/src/core/domain/model/cart_item.dart';
import 'package:menteck_app/src/core/domain/usecase/cart_usecase.dart';
import 'package:menteck_app/src/feature/cart/bloc/cart_event.dart';
import 'package:menteck_app/src/feature/cart/bloc/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartUseCase _cartUsecase;

  CartBloc(this._cartUsecase) : super(CartLoadingState()) {
    on<LoadCartEvent>((event, emit) async {
      emit(CartLoadingState());
      try {
        final List<CartItem> cartItems = await _cartUsecase.getCartItems();
        final grandTotal = await _cartUsecase.getGrandTotal();
        final productItemCount = await _cartUsecase.getCartItemsCount();
        emit(CartLoadedState(cartItems, productItemCount, grandTotal));
      } catch (e) {
        emit(CartErrorState(e.toString()));
      }
    });
    on<DeleteProductEvent>((event, emit) async {
      try {
        await _cartUsecase.deleteCartItem(event);
        final List<CartItem> cartItems = await _cartUsecase.getCartItems();
        final grandTotal = await _cartUsecase.getGrandTotal();
        final productItemCount = await _cartUsecase.getCartItemsCount();
        emit(CartLoadedState(cartItems, productItemCount, grandTotal));
      } catch (e) {
        emit(CartErrorState(e.toString()));
      }
    });
  }
}
