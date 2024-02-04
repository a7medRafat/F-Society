import 'package:flutter/material.dart';
import '../../../../../core/notification/send_fcm.dart';

class FeedsTextWidget extends StatelessWidget {
  var t = 'dbSzWL-rQdiIllQD_qdZJG:APA91bF8qFUUs7KAoSEZ94SQdp_6X5idKRNnNdOcI7RTsypcxWMFpgNdD-XvdicxE6e9TuRfoQj8LsGR_pxUMfgGl1m1vpnqQg5NpxIpLjZOJTHyyhBkUEjlJmSHTW9O-ovTU0D2Zrs2';

      FeedsTextWidget({super.key});
   @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text('Feed', style: Theme
      .of(context)
      .textTheme
      .bodyMedium));

  }
}
