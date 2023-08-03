# Package 📦 uim.servers.classes.clalogssses

# UIM Logging Library

The Log library provides a `Log` service locator for interfacing with
multiple logging backends using a simple interface. With the `Log` class it is
possible to send a single message to multiple logging backends at the same time
or just a subset of them based on the log level or context.

By default, you can use Files or Syslog as logging backends, but you can use any
object implementing `ILogger` as an engine for the `Log` class.
