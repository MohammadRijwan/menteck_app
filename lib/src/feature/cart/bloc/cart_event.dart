import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:menteck_app/src/core/domain/model/cart_item.dart';

@immutable
abstract class CartEvent extends Equatable {
  const CartEvent();
}

class LoadCartEvent extends CartEvent {
  @override
  List<Object?> get props => [];
}

class DeleteProductEvent extends CartEvent {
  final CartItem product;
  const DeleteProductEvent({required this.product});
  @override
  List<Object?> get props => [];
}
