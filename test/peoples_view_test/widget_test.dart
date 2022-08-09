// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:popular_people_app/managers/app_state_manager.dart';
import 'package:popular_people_app/ui/views/people/view.dart';
import 'package:provider/provider.dart';

import 'widget_test.mocks.dart';

@GenerateMocks([AppStateManager])
void main() {
  group('Peoples View Screen Test', () {
    final mockAppStateManager = MockAppStateManager();
    final TestWidgetsFlutterBinding binding =
        TestWidgetsFlutterBinding.ensureInitialized();
    testWidgets('Ensure all widgets are present', (WidgetTester tester) async {
      when(mockAppStateManager
          .fetchPopularPeople(page: 1)
          .then((value) => null));
      await pumpPeoplesView(tester, mockAppStateManager);
      final peoplesViewPagedListView =
          find.byKey(const Key('peoples_view_paged_listview'));
      final columnWidget = find.byKey(const Key('peoples_view_column'));
      await tester.ensureVisible(peoplesViewPagedListView);
      expect(peoplesViewPagedListView, findsOneWidget);
      expect(columnWidget, findsOneWidget);
    });

    testWidgets('Layout test mobile device 400 x 200', (widgetTester) async {
      await pumpPeoplesView(widgetTester, mockAppStateManager);
      binding.window.physicalSizeTestValue = const Size(400, 200);
      binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(widgetTester.binding.window.clearPhysicalSizeTestValue);
    });

    testWidgets('Layout test mobile device 600 x 400', (widgetTester) async {
      await pumpPeoplesView(widgetTester, mockAppStateManager);
      binding.window.physicalSizeTestValue = const Size(600, 400);
      binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(widgetTester.binding.window.clearPhysicalSizeTestValue);
    });
    testWidgets('Layout test mobile device 1440 x 690', (widgetTester) async {
      await pumpPeoplesView(widgetTester, mockAppStateManager);
      binding.window.physicalSizeTestValue = const Size(1440, 690);
      binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(widgetTester.binding.window.clearPhysicalSizeTestValue);
    });
  });
}

Future<void> pumpPeoplesView(
    WidgetTester tester, MockAppStateManager mockAppStateManager) async {
  await tester.pumpWidget(MaterialApp(
      home: ChangeNotifierProvider<AppStateManager>.value(
    value: mockAppStateManager,
    builder: (context, _) {
      return PeopleView();
    },
  )));
}
