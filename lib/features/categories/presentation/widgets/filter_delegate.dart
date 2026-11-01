import 'package:flutter/material.dart';

class FilterDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  FilterDelegate({required this.child});
  @override
  double get minExtent => 82.0;
  @override
  double get maxExtent => 82.0;
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  bool shouldRebuild(covariant FilterDelegate oldDelegate) => true;
}
