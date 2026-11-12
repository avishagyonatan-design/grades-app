import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('shows students and updates average', (WidgetTester tester) async {
    await tester.pumpWidget(const GradesApp());

    // הממוצע ההתחלתי: (97+71+54+48)/4 = 67.5
    expect(find.text('ממוצע: 67.5'), findsOneWidget);
    expect(find.text('נועה'), findsOneWidget);
    expect(find.text('ציון: 97'), findsOneWidget);

    // לחיצה על + של התלמיד הראשון מעלה את הציון ואת הממוצע
    await tester.tap(find.byIcon(Icons.add).first);
    await tester.pump();

    expect(find.text('ציון: 98'), findsOneWidget);
    expect(find.text('ממוצע: 67.8'), findsOneWidget);
  });
}
