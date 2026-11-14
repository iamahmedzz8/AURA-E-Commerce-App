import 'package:aura_maison_e_commerce/features/admin/delete_product/presentation/screens/delete_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/di/injection_container.dart';
import '../../../../../core/theme/dark_theme.dart';
import '../../../../products/products/presentation/cubit/products_cubit.dart';
import '../../../edit_product/presentation/screens/edit_product_screen.dart';
import 'package:aura_maison_e_commerce/features/admin/inventory/domain/entities/inventory_item.dart';

class InventoryCard extends StatelessWidget {
  final InventoryItem item;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onSalonPreview;
  final VoidCallback? onWorkshopRecord;
  final VoidCallback? onRestock;
  final VoidCallback? onAssign;

  const InventoryCard({
    super.key,
    required this.item,
    this.onEdit,
    this.onDelete,
    this.onSalonPreview,
    this.onWorkshopRecord,
    this.onRestock,
    this.onAssign,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: DarkTheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: DarkTheme.border),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: DarkTheme.background,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: DarkTheme.border),
                  ),
                  child: Icon(
                    Icons.image_outlined,
                    color: DarkTheme.secondaryText.withValues(alpha: 0.5),
                    size: 28,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item.brand,
                              style: TextStyle(
                                color: DarkTheme.gold,
                                fontSize: 9,
                                letterSpacing: 1,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: item.statusColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 4),
                              Text(
                                item.status,
                                style: TextStyle(
                                  color: item.statusColor,
                                  fontSize: 9,
                                  letterSpacing: 0.5,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        item.title,
                        style: TextStyle(
                          color: DarkTheme.primaryText,
                          fontSize: 16,
                          fontFamily: 'EB Garamond',
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Ref. ${item.reference}  •  ${item.unitInfo}',
                        style: TextStyle(
                          color: DarkTheme.secondaryText,
                          fontSize: 10,
                          fontFamily: 'Inter',
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.categoryLabel,
                            style: TextStyle(
                              color: DarkTheme.secondaryText,
                              fontSize: 9,
                              letterSpacing: 0.5,
                              fontFamily: 'Inter',
                            ),
                          ),
                          Text(
                            item.price,
                            style: TextStyle(
                              color: DarkTheme.gold,
                              fontSize: 16,
                              fontFamily: 'EB Garamond',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: DarkTheme.border)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.edit_outlined,
                    label: 'EDIT',
                    color: DarkTheme.gold,
                    onTap: () {
                      Navigator.push(
                        (context),
                        MaterialPageRoute(
                          builder: (context) => EditProductScreen(),
                        ),
                      );
                    },
                  ),
                ),

                if (item.showSalonButton)
                  Expanded(
                    child: _buildActionButton(
                      icon: Icons.visibility_outlined,
                      label: 'SALON PREVIEW',
                      color: DarkTheme.gold,
                      onTap: () {},
                    ),
                  ),
                if (!item.showSalonButton && !item.isRestock && !item.isAssign)
                  Expanded(
                    child: _buildActionButton(
                      icon: Icons.build_outlined,
                      label: 'WORKSHOP RECORD',
                      color: DarkTheme.secondaryText,
                      onTap: () {},
                    ),
                  ),
                if (item.isRestock)
                  Expanded(
                    child: _buildActionButton(
                      icon: Icons.refresh,
                      label: 'RESTOCK',
                      color: DarkTheme.gold,
                      onTap: () {},
                    ),
                  ),
                if (item.isAssign)
                  Expanded(
                    child: _buildActionButton(
                      icon: Icons.assignment_ind_outlined,
                      label: 'ASSIGN',
                      color: DarkTheme.gold,
                      onTap: () {},
                    ),
                  ),

                _buildActionButton(
                  icon: Icons.delete_outline,
                  label: '',
                  color: DarkTheme.secondaryText,
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => sl<ProductsCubit>(),
                          child: DeleteProductScreen(productId: item.id),
                        ),
                      ),
                    );
                    if (result == true && onDelete != null) {
                      onDelete!();
                    }
                  },
                  isIconOnly: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    VoidCallback? onTap,
    bool isIconOnly = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        splashColor: color.withValues(alpha: 0.2),
        highlightColor: color.withValues(alpha: 0.1),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isIconOnly ? 8 : 4,
            vertical: 8,
          ),
          child: isIconOnly
              ? Icon(icon, size: 18, color: color)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, size: 14, color: color),
                    SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        label,
                        style: TextStyle(
                          color: color,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Inter',
                          letterSpacing: 0.5,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
