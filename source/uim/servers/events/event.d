module uim.servers.events.event;

@safe:
import uim.servers;

interface IEvent {
    // Returns the name of this event. This is usually used as the event identifier.
    string name();

    // TODO datatype
    // Returns the subject of this event.
    // "auto" getSubject();

    // Stops the event from being used anymore.
    void stopPropagation();

    // Checks if the event is stopped. Returns true if the event is stopped
    bool isStopped();

    // The result value of the event listeners.
    Json result();

    // Listeners can attach a result value to the event.
    IEvent result(Json value = Json(null));

    // Accesses the event data/payload. If the key does not exist a null value is returned.
    STRINGAA data(string key);
    // Accesses the event data/payload. If the keys do not exist a null value is returned. If keys = null all data will be returned
    STRINGAA data(string[] keys = null);

    // Assigns a value to the data/payload of this event.
    IEvent data(string key, string value);

    // Assigns values to the data/payload of this event.
    IEvent data(STRINGAA values);
} 

class DEvent : IEvent {
  this() { this.name("Event"); }
  this(string eventName) { this(); this.name(eventName); }

  // Name of event
  mixin(OProperty!("string", "name"));

  // Propagation is on when mode = true
  mixin(OProperty!("bool", "propagationMode"));

  // Stops the event from being used anymore.
  void stopPropagation() { this.propagationMode(false); }

  // Checks if the event is stopped. Returns true if the event is stopped
  bool isStopped() { return !propagationMode; }

  // The result value of the event listeners.
  Json result() { return Json(null); }

  // Listeners can attach a result value to the event.
  IEvent result(Json value = Json(null)) {
    return null;
  }

  // #region data
    // Accesses the event data/payload. If the key does not exist a null value is returned.
    STRINGAA data(string key) { return null; }
    // Accesses the event data/payload. If the keys do not exist a null value is returned. If keys = null all data will be returned
    STRINGAA data(string[] keys = null) {return null; }

    // Assigns a value to the data/payload of this event.
    IEvent data(string key, string value) { return null; }
    // Assigns values to the data/payload of this event.
    IEvent data(STRINGAA values) { return null; }
  // #endregion data
}
