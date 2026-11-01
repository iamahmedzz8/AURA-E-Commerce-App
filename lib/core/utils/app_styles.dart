import 'package:flutter/material.dart';

class AppStyles {
  AppStyles._();
  // Brand and Section Eyebrows (Plus Jakarta Sans)
  static const TextStyle brandHeader = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.1,
    height: 14 / 11,
  );
  static const TextStyle brandHeaderInline = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 2.2,
    height: 14 / 11,
  );
  static const TextStyle headerDivider = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 14,
    fontWeight: FontWeight.w300,
    letterSpacing: 0.14,
    height: 22 / 14,
  );
  static const TextStyle sectionEyebrow = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.1,
    height: 14 / 11,
  );
  static const TextStyle sectionCount = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 12 / 10,
  );

  // Search Suite Typography
  static const TextStyle searchInputText = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.14,
    height: 22 / 14,
  );
  static const TextStyle searchMetaLabel = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 12 / 10,
  );

  // Recent Searches Typography
  static const TextStyle recentSearchesHeading = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.76,
    height: 14 / 11,
  );
  static const TextStyle clearAllButton = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.8,
    height: 12 / 10,
  );
  static const TextStyle recentSearchPillText = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.3,
    height: 18 / 12,
  );

  // Signature Collections Bento Grid Typography
  static const TextStyle signatureCollectionsHeading = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.76,
    height: 14 / 11,
  );
  static const TextStyle signatureCollectionsSeries = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.0,
    height: 12 / 10,
  );
  static const TextStyle bentoCardTag = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 12 / 10,
  );
  static const TextStyle bentoCardTitle = TextStyle(
    fontFamily: 'EB Garamond',
    fontSize: 20,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
    height: 25 / 20,
  );
  static const TextStyle bentoCardCount = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.24,
    height: 18 / 12,
  );

  // Section 3: Curator Suggestions & Trending Typography
  static const TextStyle curatorSectionTitle = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.76,
    height: 14 / 11,
  );
  static const TextStyle curatorSectionSubtitle = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.24,
    height: 18 / 12,
  );
  static const TextStyle trendingItemTag = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 12 / 10,
  );
  static const TextStyle trendingItemBadge = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 9,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.3,
    height: 12 / 9,
  );
  static const TextStyle trendingItemTitle = TextStyle(
    fontFamily: 'EB Garamond',
    fontSize: 20,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
    height: 25 / 20,
  );
  static const TextStyle trendingItemRef = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.24,
    height: 18 / 12,
  );
  static const TextStyle trendingItemPrice = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.4,
    height: 20 / 16,
  );
  static const TextStyle trendingItemStatus = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.8,
    height: 12 / 10,
  );
  static const TextStyle confidentialBannerTitle = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.55,
    height: 14 / 11,
  );
  static const TextStyle confidentialBannerSubtitle = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.24,
    height: 18 / 12,
  );
  static const TextStyle contactButtonText = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.55,
    height: 14 / 11,
  );

  // Search Results Query Bar & Curator Banner Typography
  static const TextStyle searchResultsQueryText = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.14,
    height: 18 / 14,
  );
  static const TextStyle curatorBannerFoundCount = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.55,
    height: 14 / 11,
  );
  static const TextStyle curatorBannerCertified = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.0,
    height: 12 / 10,
  );
  static const TextStyle refinementChipText = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.8,
    height: 14 / 11,
  );
  static const TextStyle refinementBadgeCount = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 10,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.0,
    height: 12 / 10,
  );

  // Search Results Product Grid Typography
  static const TextStyle productGridBadge = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.0,
    height: 12 / 10,
  );
  static const TextStyle productGridSpecs = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.1,
    height: 14 / 11,
  );
  static const TextStyle productGridRef = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.1,
    height: 14 / 11,
  );
  static const TextStyle productGridTitle = TextStyle(
    fontFamily: 'EB Garamond',
    fontSize: 20,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
    height: 25 / 20,
  );
  static const TextStyle productGridPrice = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.4,
    height: 20 / 16,
  );
  static const TextStyle productGridAction = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.55,
    height: 14 / 11,
  );

  // Salon Concierge Floating Vitrine Bar Typography
  static const TextStyle vitrineEyebrow = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.1,
    height: 14 / 11,
  );
  static const TextStyle vitrineSeekTitle = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.24,
    height: 18 / 12,
  );
  static const TextStyle vitrineCommissionButton = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.55,
    height: 14 / 11,
  );

  // Serif Titles (EB Garamond)
  static const TextStyle headerScreenTitle = TextStyle(
    fontFamily: 'EB Garamond',
    fontSize: 20,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
    height: 26 / 20,
  );
  static const TextStyle sectionHeading = TextStyle(
    fontFamily: 'EB Garamond',
    fontSize: 26,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.0,
    height: 32 / 26,
  );
  static const TextStyle cardHeading = TextStyle(
    fontFamily: 'EB Garamond',
    fontSize: 20,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
    height: 25 / 20,
  );
  // Card Content & Tags (Plus Jakarta Sans)
  static const TextStyle cardTag = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.1,
    height: 14 / 11,
  );
  static const TextStyle cardSubtitle = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.24,
    height: 18 / 12,
  );
  static const TextStyle badgeText = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.1,
    height: 14 / 11,
  );
  static const TextStyle filterPillText = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.8,
    height: 14 / 11,
  );

  static const TextStyle filterLabel = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 12 / 10,
  );

  static const TextStyle microChipText = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
    height: 13 / 10,
  );

  static const TextStyle clearButtonText = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.0,
    height: 14 / 11,
  );
  static const TextStyle streamSectionTitle = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.1,
    height: 14 / 11,
  );
  static const TextStyle streamPagination = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 12 / 10,
  );
  static const TextStyle provenanceBadge = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.1,
    height: 14 / 11,
  );
  static const TextStyle overlayAtelier = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.1,
    height: 14 / 11,
  );
  static const TextStyle overlaySubSpec = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 12 / 10,
  );
  static const TextStyle overlayStatus = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.1,
    height: 14 / 11,
  );
  static const TextStyle productCategory = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.1,
    height: 14 / 11,
  );
  static const TextStyle productTitle = TextStyle(
    fontFamily: 'EB Garamond',
    fontSize: 20,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
    height: 25 / 20,
  );
  static const TextStyle priceLabel = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.1,
    height: 14 / 11,
  );
  static const TextStyle priceValue = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.0,
    height: 28 / 24,
  );
  static const TextStyle productDescription = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.24,
    height: 18 / 12,
  );
  static const TextStyle specItemLabel = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.4,
    height: 12 / 10,
  );
  static const TextStyle specItemValue = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
    height: 16 / 12,
  );
  static const TextStyle primaryButtonText = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.1,
    height: 14 / 11,
  );
  // Bespoke Card Typography
  static const TextStyle bespokeEyebrow = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.1,
    height: 14 / 11,
  );

  static const TextStyle bespokeHeading = TextStyle(
    fontFamily: 'EB Garamond',
    fontSize: 26,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.0,
    height: 32 / 26,
  );

  static const TextStyle bespokeDescription = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.24,
    height: 18 / 12,
  );

  static const TextStyle specialOrderButton = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.1,
    height: 14 / 11,
  );

  // Bottom Navigation Bar Typography
  static const TextStyle navItemLabel = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 12 / 10,
  );

  static const TextStyle navBadgeText = TextStyle(
    fontFamily: 'Plus Jakarta Sans',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.0,
    height: 14 / 11,
  );
}
