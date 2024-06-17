# Shimmer Loading Package
![Static Badge](https://img.shields.io/badge/Version%3A-0.0.1-blue)
![Static Badge](https://img.shields.io/badge/License%3A-MIT-green)


A Flutter package to provide a shimmer loading effect. This package includes two main widgets: `Shimmer` and `ShimmerLoading`.

## Features

- **Shimmer Widget**: Provides a shimmer animation effect.
- **ShimmerLoading Widget**: Displays a loading shimmer effect when a process is loading, and switches to a specified child widget once loading is complete.

## Installation

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  shimmer_loading_package: [latest_version]
```
Then run `flutter pub get`.

## Usage

Import the package:

```dart
import 'package:shimmer_loading_animation/shimmer_loading_animation.dart';
```

There are two widgets available in this package:
- Shimmer
- ShimmerLoading

You need two use both of them to create a shimmer loading effect.
The `Shimmer` widget should be a top widget of your `Scaffold`'s body, and the `ShimmerLoading` widget should be an inner child of the `Shimmer` widget.
The `Shimmer` widget has a `linearGradient` property that you can use to customize the shimmer effect. By default it uses a dark and light grey gradient.

```dart
LinearGradient(
  colors: [
    Color(0xF5000000),
    Color(0xFF303030),
    Color(0xFF000000),
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);
```

The `ShimmerLoading` widget has 3 properties:
- `isLoading`: A boolean value that determines whether the loading effect should be displayed.
- `loadingChild`: The widget that should be displayed while loading.
- `secondChild`: The widget that should be displayed once loading is complete.

```dart
ShimmerLoading(
  isLoading: isLoading,
  loadingChild: Container(
  decoration: BoxDecoration(
    color: Colors.grey,
    borderRadius: BorderRadius.circular(10),
    ),
    height: 100,
    width: 100,
  ),
  secondChild: Container(
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      'Data loaded!',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),
```

Here is an example of how to use the `Shimmer` and `ShimmerLoading` widgets:

```dart
import 'package:flutter/material.dart';
import 'package:shimmer_loading_package/shimmer_loading_package.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool isLoading = true; // You should handle this variable's value based on your loading process.
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Shimmer Loading Example')),
        body: Center(
          child: Shimmer(
            child: ShimmerLoading(
              isLoading: isLoading,
              loadingChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200.0,
                    height: 20.0,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    width: 200.0,
                    height: 20.0,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    width: 200.0,
                    height: 20.0,
                    color: Colors.grey[300],
                  ),
                ],
              ),
              secondChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Loaded Child 1'),
                  SizedBox(height: 10.0),
                  Text('Loaded Child 2'),
                  SizedBox(height: 10.0),
                  Text('Loaded Child 3'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```


## Additional information
You maybe want wrap the `ShimmerLoading` widget with a `Container` widget with a color, to have a background color while loading.

```dart
Container(
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
  ),
  child: ShimmerLoading(
    isLoading: isLoading,
    loadingChild: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 200.0,
          height: 20.0,
          color: Colors.grey[300],
        ),
        SizedBox(height: 10.0),
        Container(
          width: 200.0,
          height: 20.0,
          color: Colors.grey[300],
        ),
        SizedBox(height: 10.0),
        Container(
          width: 200.0,
          height: 20.0,
          color: Colors.grey[300],
        ),
      ],
    ),
    secondChild: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Loaded Child 1'),
        SizedBox(height: 10.0),
        Text('Loaded Child 2'),
        SizedBox(height: 10.0),
        Text('Loaded Child 3'),
      ],
    ),
  ),
),
```


## License

This project is licensed under the MIT License - see the LICENSE file for details.