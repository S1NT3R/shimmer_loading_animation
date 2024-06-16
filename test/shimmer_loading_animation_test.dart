import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shimmer_loading_animation/shimmer_loading_animation.dart';

void main() {
  testWidgets('ShimmerLoading shows loadingChild when isLoading is true',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Shimmer(
          child: ShimmerLoading(
            isLoading: true,
            loadingChild: Text('Loading...'),
            defaultChild: Text('Loaded'),
          ),
        ),
      ),
    );

    expect(find.text('Loading...'), findsOneWidget);
    expect(find.text('Loaded'), findsNothing);
  });

  testWidgets('ShimmerLoading shows defaultChild when isLoading is false',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Shimmer(
          child: ShimmerLoading(
            isLoading: false,
            loadingChild: Text('Loading...'),
            defaultChild: Text('Loaded'),
          ),
        ),
      ),
    );

    expect(find.text('Loading...'), findsNothing);
    expect(find.text('Loaded'), findsOneWidget);
  });

  testWidgets('ShaderMask is applied to loadingChild',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Shimmer(
          child: ShimmerLoading(
            isLoading: true,
            loadingChild: Text('Loading...'),
            defaultChild: Text('Loaded'),
          ),
        ),
      ),
    );

    final shimmerLoadingFinder = find.byType(ShimmerLoading);
    final shaderMaskFinder = find.descendant(
        of: shimmerLoadingFinder, matching: find.byType(ShaderMask));

    expect(shaderMaskFinder, findsOneWidget);
  });

  testWidgets('ShimmerLoading does not crash when Shimmer context is null',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ShimmerLoading(
          isLoading: true,
          loadingChild: Text('Loading...'),
          defaultChild: Text('Loaded'),
        ),
      ),
    );

    expect(find.text('Loading...'), findsNothing);
    expect(find.text('Loaded'), findsOneWidget);
  });
}
