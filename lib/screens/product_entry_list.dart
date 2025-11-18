import 'package:flutter/material.dart';
import 'package:messytenmobile/models/product_entry.dart';
import 'package:messytenmobile/widgets/left_drawer.dart';
import 'package:messytenmobile/screens/product_detail.dart';
import 'package:messytenmobile/widgets/product_entry_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ProductEntryListPage extends StatefulWidget {
  const ProductEntryListPage({super.key});

  @override
  State<ProductEntryListPage> createState() => _ProductEntryListPageState();
}

class _ProductEntryListPageState extends State<ProductEntryListPage> {
  bool showOnlyMyProducts = false;

  Future<List<ProductEntry>> fetchProducts(CookieRequest request) async {
    final response = await request
        .get('https://edward-jeremy41-messyten.pbp.cs.ui.ac.id/json/');
    List<ProductEntry> listProducts = [];

    for (var d in response) {
      if (d != null) {
        listProducts.add(ProductEntry.fromJson(d));
      }
    }
    return listProducts;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(title: const Text('Product Entry List')),
      drawer: const LeftDrawer(),
      body: Column(
        children: [
          const SizedBox(height: 10),

          // FLIUTER BUTTON
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    showOnlyMyProducts = false;
                  });
                },
                child: const Text("All Products"),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    showOnlyMyProducts = true;
                  });
                },
                child: const Text("My Products"),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // PRODUCT LIST
          Expanded(
            child: FutureBuilder(
              future: fetchProducts(request),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                List<ProductEntry> products = snapshot.data!;
                print("jsonData from request: ${request.jsonData}");
                for (final p in products) {
                  print("Product: ${p.name}, userId: ${p.userId}");
                }

                if (showOnlyMyProducts) {
                  final rawUserId =
                      request.jsonData['user_id'] ?? request.jsonData['id'];

                  print("rawUserId from jsonData: $rawUserId");

                  final int? currentUserId = rawUserId is int
                      ? rawUserId
                      : int.tryParse(rawUserId.toString());

                  print("currentUserId parsed: $currentUserId");

                  if (currentUserId != null) {
                    products = products.where((p) {
                      return p.userId == currentUserId;
                    }).toList();
                  }
                }

                if (products.isEmpty) {
                  return const Center(
                    child: Text(
                      "No products found.",
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (_, index) => ProductEntryCard(
                    product: products[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailPage(product: products[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
