// class ProductDetailsState {
//   final bool isDark;
//   final int quantity;
//   final bool isFavorite;

//   const ProductDetailsState({
//     this.isDark = true,
//     this.quantity = 1,
//     this.isFavorite = false,
//   });

//   ProductDetailsState copyWith({
//     bool? isDark,
//     int? quantity,
//     bool? isFavorite,
//   }) {
//     return ProductDetailsState(
//       isDark: isDark ?? this.isDark,
//       quantity: quantity ?? this.quantity,
//       isFavorite: isFavorite ?? this.isFavorite,
//     );
//   }
// }

import 'package:aura_maison_e_commerce/features/products/product_details/data/models/product_details_model.dart';

abstract class ProductDetailsStates {}

class ProductDetailsInitialState extends ProductDetailsStates {}

class ProductDetailsLoadingState extends ProductDetailsStates {}

class ProductDetailsSuccessState extends ProductDetailsStates {
  final ProductDetailsModel productDetailsModel;

  ProductDetailsSuccessState(this.productDetailsModel);
}

class ProductDetailsErrorState extends ProductDetailsStates {
  final String message;

  ProductDetailsErrorState({required this.message});
}
