**Light Toast** is a simple, lightweight, and highly customizable Flutter package designed to display beautiful toast notifications within your Flutter applications. Enhance your app's user experience with eye-catching and informative toast messages.

<img height="300" src="https://raw.githubusercontent.com/Anees7757/light_toast/master/assets/images/img1.png" alt=""/>
<img height="300" src="https://raw.githubusercontent.com/Anees7757/light_toast/master/assets/images/img2.png" alt=""/>
<img height="300" src="https://raw.githubusercontent.com/Anees7757/light_toast/master/assets/images/img3.png" alt=""/>


## Features

- **Contextual Flexibility:** Use Light Toast with or without a BuildContext for seamless integration.
- **Customization:** Personalize your toast messages with a wide range of colors, icons, and images (both asset-based and network-based).
- **Visual Appeal:** Choose to display icons or images alongside your toast text for added impact.
- **Timing Control:** Adjust the duration of your toast messages for optimal visibility.
- **On-Demand Dismissal:** Easily hide toast messages when needed.

## Getting started

1. **Add Dependency:** Include the following in your project's pubspec.yaml file:

```yaml
dependencies:
  light_toast: ^0.0.9
```

2. **Import:** Add the import statement to your Dart files:
```
import 'package:light_toast/light_toast.dart';
```

## How to use

**Or with `context`**
```dart
// Simple usage
Toast.show('Hello, Flutter!');

// Usage with BuildContext
Toast.show(context: context, 'Hello, Flutter!');

// To hide a toast:
Toast.hide();
```

