import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../configurations/frontend_configs.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:MainAxisAlignment.center,
      children: [
        SpinKitWave(
          size:30,
          color:FrontendConfigs.kAppPrimaryColor,
        ),
      ],
    );
  }
}
