module uim.servers.classes.events.list;

import uim.servers;
@safe:

/**
 * The Event List
 */
class EventList { // implements ArrayAccess, Countable
    // Events list
    protected IEvent[] _events;

    // Empties the list of dispatched events.
    void flush() {
        _events = []; }
version(test_uim_servers) {
  unittest {
    writeln("--- Test in ", __MODULE__, "/", __LINE__);
        // TODO Add Tests
        }}

    // Adds an event to the list when event listing is enabled.
    void add(IEvent anEvent) {
        _events ~= anEvent; }
version(test_uim_servers) {
  unittest {
    writeln("--- Test in ", __MODULE__, "/", __LINE__);
        // TODO Add Tests
        }}

    // Whether a offset exists
    bool offsetExists(string anOffset) {
        return false; }
version(test_uim_servers) {
  unittest {
    writeln("--- Test in ", __MODULE__, "/", __LINE__);
        // TODO Add Tests
        }}

    // Offset to retrieve
    IEvent offsetGet(string offset) {
      if (offsetExists(offset)) {
          return null;
      }

      return null; }
version(test_uim_servers) {
  unittest {
    writeln("--- Test in ", __MODULE__, "/", __LINE__);
        // TODO Add Tests
        }}

    // Offset to set
    void offsetSet(string anOffset, string aValue) {
        // TODO
    }

    // Offset to unset
    void offsetUnset(string anOffset) {
        // TODO
    }

    // Count elements of an object
    size_t count() {  
      return _events.length; }

    // Checks if an event is in the list.
    bool hasEvent(string aName) {
      foreach (ev; _events) {
        if (ev.name == aName) { return true; }
      }

      return false;
    }
}
version(test_uim_servers) {
  unittest {
    writeln("--- Test in ", __MODULE__, "/", __LINE__);
  }}