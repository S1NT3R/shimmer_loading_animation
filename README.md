# Shimmer Loading Package
![Static Badge](https://img.shields.io/badge/Version%3A-0.1.0-blue)
![Static Badge](https://img.shields.io/badge/License%3A-MIT-green)


A Flutter package to provide a shimmer loading effect. This package includes two main widgets: `Shimmer` and `ShimmerLoading`.

## WORK IN PROGRESS - YOU SHOULD USE THIS PACKAGE WITH CAUTION

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

You need to use both of them to create a shimmer loading effect.
The `Shimmer` widget should be a top widget of your `Scaffold`'s body, and the `ShimmerLoading` widget should be an inner child of the `Shimmer` widget.
The `Shimmer` widget has a `colors` property that wants a `List<Color>` that represents the colors of the shimmer effect.
Typically, you should use 3 colors in the list, the first and last colors should be the same, and the middle color should be a different color.


The `ShimmerLoading` widget has 3 required properties and 6 optional properties:
- **required** `isLoading`: A boolean value that determines whether the loading effect should be displayed.
- **required** `loadingChild`: The widget that should be displayed while loading.
- **required** `secondChild`: The widget that should be displayed once loading is complete.
- `loaderMargin`: A `EdgeInsets` object that represents the margin of the loading widget.
- `loaderPadding`: A `EdgeInsets` object that represents the padding of the loading widget.
- `loaderWidth`: A `double` value that represents the width of the loading widget.
- `loaderHeight`: A `double` value that represents the height of the loading widget.
- `loaderDecoration`: A `Decoration` object that represents the decoration of the loading widget.
- `loaderAlignment`: An `Alignment` object that represents the alignment of the loading widget.

The `loadingChild` widget should contain widgets that looks similar to the `secondChild` widget, but it should only be a skeleton of the `secondChild` widget.
Note that you can NOT add a background to the `loadingChild` widget, you should use the given properties to style the loading widget background.



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
              loaderWidth: 200.0,
              loaderHeight: 150.0,
              loaderDecoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
              ),
              loaderMargin: EdgeInsets.all(10.0),
              loaderPadding: EdgeInsets.all(10.0),
              loaderAlignment: Alignment.center,
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


## License

This project is licensed under the MIT License - see the LICENSE file for details.