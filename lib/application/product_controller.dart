import 'package:get/get.dart';
import 'package:machinetestapiinteg/domain/productModel/product_model.dart';
import 'package:machinetestapiinteg/infrastructure/web_services.dart';

class ProductController extends GetxController {
  final ApiCalls apicalls = ApiCalls();
  final Rx<ProductModel> product = ProductModel().obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;

  void fetchProductsModel() async {
    List<ProductModel> fetchedProducts = await apicalls.fetchProducts();

    products.value = fetchedProducts;
    update();
  }

  // void fetchProduct(String id) async {
  //   ProductModel fetchedProductsDetail =
  //       await apicalls.fetchProductsById(id: id);

  //   product.value = fetchedProductsDetail;
  //   update();
  // }
}
