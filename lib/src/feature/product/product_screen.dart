import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menteck_app/main.dart';
import 'package:menteck_app/src/core/domain/model/product_model.dart';
import 'package:menteck_app/src/core/domain/usecase/product_usecase.dart';
import 'package:menteck_app/src/core/utils/app_router.dart';
import 'package:menteck_app/src/feature/product/widgets/shopping_card.dart';

import 'bloc/product_bloc.dart';
import 'bloc/product_event.dart';
import 'bloc/product_state.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Mall'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              navigatorKey.currentState!.pushNamed(AppRouter.cartScreen);
            },
          )
        ],
      ),
      body: BlocProvider(
        create: (context) => ProductBloc(
          ProductUseCase(),
        )..add(LoadProductEvent()),
        child: BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is AddedProductState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  duration: const Duration(seconds: 1),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is ProductLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ProductLoadedState) {
              ProductRes productRes = state.productRes;
              List<Product> productList = productRes.products!;
              return GridView.builder(
                itemCount: productList.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, index) {
                  return InkWell(
                    onTap: () => BlocProvider.of<ProductBloc>(context)
                        .add(AddProductEvent(product: productList[index])),
                    child: ShoppingCard(
                      productImageUrl: '${productList[index].featuredImage}',
                      productName: '${productList[index].title}',
                    ),
                  );
                },
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250,
                    childAspectRatio: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
              );
            }
            if (state is ProductErrorState) {
              return const Center(
                child: Text("Error"),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
