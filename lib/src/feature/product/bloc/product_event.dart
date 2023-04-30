import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:menteck_app/src/core/domain/model/product_model.dart';

@immutable
abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class LoadProductEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}

class AddProductEvent extends ProductEvent {
  final Product product;
  const AddProductEvent({required this.product});
  @override
  List<Object?> get props => [];
}

class UpdateProductEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}
