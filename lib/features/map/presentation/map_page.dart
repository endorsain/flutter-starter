import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/widgets/feature_placeholder.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return FeaturePlaceholder(
      icon: Icons.map_outlined,
      title: localizations.mapTitle,
      description: localizations.mapPlaceholder,
    );
  }
}
