import 'package:flutter/material.dart';

class ShoppingCard extends StatelessWidget {
  final String productName;
  final String productImageUrl;

  const ShoppingCard(
      {Key? key, required this.productName, required this.productImageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Card(
      color: Colors.blueAccent.withOpacity(0.7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 10.0),
          Image.network(
            productImageUrl,
            height: size.height * 0.16,
            width: size.width,
            fit: BoxFit.contain,
          ),
          Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                )),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      productName,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.shopping_cart),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
