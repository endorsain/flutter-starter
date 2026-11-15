import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/widgets/feature_placeholder.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return FeaturePlaceholder(
      icon: Icons.camera_alt_outlined,
      title: localizations.cameraTitle,
      description: localizations.cameraPlaceholder,
    );
  }
}
