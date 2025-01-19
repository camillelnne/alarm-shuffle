# Alarm shuffle

Alarm shuffle is a simple alarm clock that allows you to set alarms and plays random music from your collection


## Structure

```
lib/
├── ui/
│   ├── views/
│   │   ├── alarm_screen.dart
│   │   └── mp3_picker_screen.dart
│   ├── widgets/
│   │   ├── alarm_tile.dart
│   │   └── mp3_tile.dart
│   └── view_models/
│       ├── alarm_view_model.dart
│       └── mp3_view_model.dart
├── data/
│   ├── repositories/
│   │   ├── alarm_repository.dart
│   │   └── mp3_repository.dart
│   └── services/
│       ├── notification_service.dart
│       ├── audio_service.dart
│       └── file_picker_service.dart
```