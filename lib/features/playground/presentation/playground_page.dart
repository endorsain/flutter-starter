import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/widgets/feature_placeholder.dart';

class PlaygroundPage extends StatelessWidget {
  const PlaygroundPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return FeaturePlaceholder(
      icon: Icons.science_outlined,
      title: localizations.playgroundTitle,
      description: localizations.playgroundPlaceholder,
    );
  }
}
