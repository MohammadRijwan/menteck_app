import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:menteck_app/src/core/domain/model/product_model.dart';

@immutable
abstract class ProductState extends Equatable {}

class ProductLoadingState extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductLoadedState extends ProductState {
  final List<Product> productRes;
  ProductLoadedState(this.productRes);
  @override
  List<Object?> get props => [productRes];
}

class ProductErrorState extends ProductState {
  final String error;
  ProductErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

class AddedProductState extends ProductState {
  final String message;
  AddedProductState(this.message);
  @override
  List<Object?> get props => [message];
}
