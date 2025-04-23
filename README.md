# login

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Todos

- [] replace dummy data with firestore implementation
- [] create a session id on login and store it in local storage and user's firestore doc
- [] create a middleware on every request (except login) to fetch user doc from fire store and check the session id with the one in local storage
- [] if valid, proceed with the request, if not, remove session id from local storage and sign user out (send to login screen)
- [] implement screen redirect logic on app launch
- [] create dummy api calls in home screen for testing
