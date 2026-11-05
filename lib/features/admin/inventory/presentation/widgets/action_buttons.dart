import 'package:aura_maison_e_commerce/features/admin/add_product/presentation/screens/add_product_screen.dart';
import 'package:aura_maison_e_commerce/features/products/products/presentation/cubit/products_cubit.dart';
import 'package:aura_maison_e_commerce/core/di/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => sl<ProductsCubit>(),
                      child: const AddProductScreen(),
                    ),
                  ),
                );
              },
              icon: Icon(Icons.add_circle_outline, size: 18),
              label: Text('+ ADD A PIECE'),
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.download, size: 18),
              label: Text('SEALED EXPORT (CSV)'),
            ),
          ),
        ],
      ),
    );
  }
}