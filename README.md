# QueueLess

QueueLess is a Flutter digital queue management app for clinics, service
offices, and college departments.

## Features

- Browse, search, and filter service queues.
- Generate a queue token and see the current token, people ahead, and estimated
  waiting time.
- Get in-app updates when a ticket is issued, a turn approaches, or the ticket
  is called.
- Create queues, pause or reopen them, and call the next visitor from queue
  management mode.
- Review active and completed tokens and queue updates.

## Run

Install the Flutter SDK, then from this directory run:

```sh
flutter pub get
flutter create --platforms=android,ios,web .
flutter run
```

The app uses sample queues and in-memory state so it can be explored without
service setup. Queue data and in-app updates reset when the app process restarts.
OS push notifications and shared, multi-device queue synchronization require a
notification service and backend, which are not configured in this demo.
