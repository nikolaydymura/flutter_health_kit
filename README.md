# flutter_health_kit

This plugin allows Flutter apps to read and subscribe to changes in the Apple HealthKit store.

## Getting Started

Request authorization to read data from the HealthKit store:

```dart
bool isAuthorized = await FlutterHealthKit.requestAuthorization(
read: [HKSampleTypeIdentifier.workout]);
```

Read data from the HealthKit store:

```dart
final workouts = await FlutterHealthKit.querySampleType<Workout>(HKSampleTypeIdentifier.workout);
```


