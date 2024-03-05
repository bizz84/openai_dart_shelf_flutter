# Shelf tutorial demo app

A server app built using [Shelf](https://pub.dev/packages/shelf) and wrapping the OpenAI API.

## Running with the Dart SDK

You can run the example with the [Dart SDK](https://dart.dev/get-dart) like this:

```
dart run --define=OPENAI_API_KEY=<your_key> bin/server.dart
```

Replace `<your_key>` with your actual OpenAI API key.

And then from a second terminal:

```
$ curl http://0.0.0.0:8080/tip
```

## Testing

The tests also need the OpenAI API key. Create a file named **testing_key.dart** in the **test** folder. Add the following line:

```
const apiKey = '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';
```

Run the tests like so:

```
dart test
```

