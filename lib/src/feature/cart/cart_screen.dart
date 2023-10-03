import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menteck_app/src/core/domain/model/cart_item.dart';
import 'package:menteck_app/src/core/domain/usecase/cart_usecase.dart';
import 'package:menteck_app/src/feature/cart/bloc/cart_bloc.dart';
import 'package:menteck_app/src/feature/cart/bloc/cart_event.dart';
import 'package:menteck_app/src/feature/cart/bloc/cart_state.dart';
import 'package:menteck_app/src/feature/cart/widgets/shopping_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => CartBloc(
          CartUseCase(),
        )..add(LoadCartEvent()),
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CartLoadedState) {
              List<CartItem> productList = state.cartItems;
              return Column(
                children: [
                  Expanded(
                    child: productList.isEmpty
                        ? const Center(
                            child: Text(
                            'Your Cart is Empty',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ))
                        : ListView.builder(
                            itemCount: productList.length,
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.only(bottom: 50),
                            itemBuilder: (_, index) {
                              return CartCard(
                                productImageUrl:
                                    productList[index].productImage,
                                productName: productList[index].name,
                                productPrice: '${productList[index].price}',
                                productQty: '${productList[index].quantity}',
                                onDelete: () =>
                                    BlocProvider.of<CartBloc>(context).add(
                                        DeleteProductEvent(
                                            product: productList[index])),
                              );
                            },
                          ),
                  ),
                  Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.7),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Total Items: ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                state.totalItemCount.toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Grand Total: ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Center(
                                child: Text(
                                  state.grandTotal.toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }
            if (state is CartErrorState) {
              return const Center(
                child: Text("Something went wrong please provide valid information"),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
