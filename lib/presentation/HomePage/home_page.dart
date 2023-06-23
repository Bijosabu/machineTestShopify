import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:machinetestapiinteg/application/product_controller.dart';
import 'package:machinetestapiinteg/presentation/productDetail/product_detail_screen.dart';
import 'package:machinetestapiinteg/presentation/widgets/swiper_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final ScrollController _scrollController = ScrollController();
  final productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productController.fetchProductsModel();
    });
    Size size = MediaQuery.of(context).size;
    void _loadMoreData() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        productController.fetchProductsModel();
      }
    }

    // Attach scroll listener to the scroll controller
    _scrollController.addListener(_loadMoreData);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Shopify',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: size.height * 0.25,
              child: Swiper(
                autoplay: true,
                itemCount: 3,
                itemBuilder: (ctx, index) {
                  return const SwiperWidget();
                },
                pagination: const SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                        size: 8,
                        color: Colors.white,
                        activeColor: Colors.blueGrey)),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'All Products',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700]),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          GetX<ProductController>(
            builder: (productController) {
              if (productController.products.isEmpty) {
                // Display text widget when no data is available
                return const Center(
                  child: Text(
                    'Unable to load data. Check your internet connection.',
                    style: TextStyle(fontSize: 16),
                  ),
                );
              } else {
                return Expanded(
                  child: GridView.builder(
                    controller: _scrollController,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemCount: productController.products.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(ProductDetailScreen(
                              imageUrl:
                                  productController.products[index].image!,
                              title: productController.products[index].title!,
                              price: productController.products[index].price!
                                  .toString(),
                              description: productController
                                  .products[index].description!));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                fit: BoxFit.contain,
                                image: NetworkImage(
                                  productController.products[index].image!,
                                ),
                              ),
                            ),
                            height: 80,
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
