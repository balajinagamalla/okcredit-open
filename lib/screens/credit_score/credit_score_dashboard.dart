import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CreditScoreDashboard extends StatelessWidget {
  final double score = 0.75;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Credit Score')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularPercentIndicator(
              radius: 100,
              lineWidth: 10,
              percent: score,
              center: Text('${(score * 100).toInt()}%'),
              progressColor: Colors.green,
            ),
            SizedBox(height: 20),
            Text('Good repayment behavior'),
            Text('Try to send reminders regularly'),
          ],
        ),
      ),
    );
  }
}
