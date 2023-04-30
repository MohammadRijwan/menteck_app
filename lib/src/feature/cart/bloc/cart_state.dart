import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:menteck_app/src/core/domain/model/cart_item.dart';

@immutable
abstract class CartState extends Equatable {}

//data loading state
class CartLoadingState extends CartState {
  @override
  List<Object?> get props => [];
}

class CartLoadedState extends CartState {
  final List<CartItem> cartItems;
  final int totalItemCount;
  final int grandTotal;
  CartLoadedState(this.cartItems, this.totalItemCount, this.grandTotal);
  @override
  List<Object?> get props => [cartItems];
}

class CartErrorState extends CartState {
  final String error;
  CartErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
