module uim.servers.classes.events.manager;

import uim.servers;
@safe:

/**
 * The event manager is responsible for keeping track of event listeners, passing the correct
 * data to them, and firing them in the correct order, when associated events are triggered. You
 * can create multiple instances of this object to manage local events or keep a single instance
 * and pass it around to manage all events in your app.
 */
class DEventManager : IEventManager {
    // The default priority queue value for new, attached listeners
    static int defaultPriority = 10;

    // The globally available instance, used for dispatching events attached from any scope
    protected static DEventManager _generalManager;

    // List of listener callbacks associated to
    protected IEventListener[] _listeners;

    // Internal flag to distinguish a common manager from the singleton
    protected bool _isGlobal;

    // The event list object.
    protected IEventListener _eventList;

    // Enables automatic adding of events to the event list object if it is present.
    protected bool _trackEvents;

    /**
     * Returns the globally available instance of a Cake\Event\EventManager
     * this is used for dispatching events attached from outside the scope
     * other managers were created. Usually for creating hook systems or inter-class
     * communication
     *
     * If called with the first parameter, it will be set as the globally available instance
     *
     * @param \Cake\Event\EventManager|null manager Event manager instance.
     * @return \Cake\Event\EventManager The global event manager
     */
/*     public static function instance(?EventManager manager = null)
    {
        if (manager instanceof EventManager) {
            _generalManager = manager;
        }
        if (empty(_generalManager)) {
            _generalManager = new static();
        }

        _generalManager._isGlobal = true;

        return _generalManager;
    } */

    /**
     * @inheritDoc
     */
     void on(string eventKey, /* callable */ Json options = Json(null)) { // TODO 
     }
/*     public function on(eventKey, options = [], ?callable callable = null)
    {
        if (eventKey instanceof EventListenerInterface) {
            _attachSubscriber(eventKey);

            return this;
        }

        argCount = func_num_args();
        if (argCount === 2) {
            _listeners[eventKey][defaultPriority][] = [
                "callable" => options,
            ];

            return this;
        }

        priority = options["priority"] ?? defaultPriority;
        _listeners[eventKey][priority][] = [
            "callable" => callable,
        ];

        return this;
    } */

    // Auxiliary function to attach all implemented callbacks of a Cake\Event\EventListenerInterface class instance
    // as individual methods on this manager
    protected void _attachSubscriber(IEventListener subscriber) {
/*         foreach (subscriber.implementedEvents() as eventKey => function) {
            options = [];
            method = function;
            if (is_array(function) && isset(function["callable"])) {
                [method, options] = _extractCallable(function, subscriber);
            } elseif (is_array(function) && is_numeric(key(function))) {
                foreach (function as f) {
                    [method, options] = _extractCallable(f, subscriber);
                    on(eventKey, options, method);
                }
                continue;
            }
            if (is_string(method)) {
                method = [subscriber, function];
            }
            on(eventKey, options, method);
        }
 */    }

    /**
     * Auxiliary function to extract and return a PHP callback type out of the callable definition
     * from the return value of the `implementedEvents()` method on a {@link \Cake\Event\EventListenerInterface}
     *
     * @param array function the array taken from a handler definition for an event
     * @param \Cake\Event\EventListenerInterface object The handler object
     * @return array
     */
//    auto _extractCallable(array function, EventListenerInterface object) {
        /** @var callable method */
/*         method = function["callable"];
        options = function;
        unset(options["callable"]);
        if (is_string(method)) {
            /** @var callable method */
           /*  method = [object, method];
        } */

       /*  return [method, options];
    } */

    //
    void off(this O)(string eventKey, Json options = Json(null)) {
/*         if (eventKey instanceof EventListenerInterface) {
            _detachSubscriber(eventKey);

            return this;
        }

        if (!is_string(eventKey)) {
            if (!is_callable(eventKey)) {
                throw new CakeException(
                    "First argument of EventManager::off() must be " .
                    " string or EventListenerInterface instance or callable."
                );
            }

            foreach (_listeners.keys as name) {
                off(name, eventKey);
            }

            return this;
        }

        if (callable instanceof EventListenerInterface) {
            _detachSubscriber(callable, eventKey);

            return this;
        }

        if (callable === null) {
            unset(_listeners[eventKey]);

            return this;
        }

        if (empty(_listeners[eventKey])) {
            return this;
        }

        foreach (_listeners[eventKey] as priority => callables) {
            foreach (callables as k => callback) {
                if (callback["callable"] === callable) {
                    unset(_listeners[eventKey][priority][k]);
                    break;
                }
            }
        }
 */
    }

    /**
     * Auxiliary function to help detach all listeners provided by an object implementing EventListenerInterface
     *
     * @param \Cake\Event\EventListenerInterface subscriber the subscriber to be detached
     * @param string|null eventKey optional event key name to unsubscribe the listener from
     * @return void
     */
    protected void _detachSubscriber(IEventListener subscriber, string eventKey = null) {
/*         events = subscriber.implementedEvents();
        if (!empty(eventKey) && empty(events[eventKey])) {
            return;
        }
        if (!empty(eventKey)) {
            events = [eventKey => events[eventKey]];
        }
        foreach (events as key => function) {
            if (is_array(function)) {
                if (is_numeric(key(function))) {
                    foreach (function as handler) {
                        handler = handler["callable"] ?? handler;
                        off(key, [subscriber, handler]);
                    }
                    continue;
                }
                function = function["callable"];
            }
            off(key, [subscriber, function]);
        }
 */    }

    //
    IEvent dispatch(string eventName) {
      auto myEvent = new DEvent(eventName);

      auto listeners = listeners(myEvent.name);
      /* if (_trackEvents) { /* addEventToList(event); * / }

       if (_isGlobal && instance().isTrackingEvents()) {
          instance().addEventToList(event);
      } */

      if (listeners.empty) return myEvent;

      foreach (listener; listeners) {
        /* if (event.isStopped()) break;

        auto result = _callListener(listener["callable"], event);
        if (result == false) event.stopPropagation();
        if (result !is null) event.result(result); */
       }

      return myEvent;
    }
/*
    // Calls a listener.
/*      *
     * @param callable listener The listener to trigger.
     * @param \Cake\Event\IEvent event Event instance.
     * @return mixed The result of the listener function.
 */     
    IEventListener _callListener(IEventListener listener, IEvent event) {
      auto data = event.data();

      return null; // listener(event/* , ...array_values(data) */);
    }

    //
    IEventListener[] listeners(string eventKey) {
      auto localListeners = [];
      if (!_isGlobal) {
        localListeners = prioritisedListeners(eventKey);
        localListeners = empty(localListeners) ? [] : localListeners;
      }
      IEventListener[] globalListeners; // TODO = instance().prioritisedListeners(eventKey);
      globalListeners = globalListeners.empty ? [] : globalListeners;

/*       priorities = globalListeners.keys~localListeners.keys;
      priorities = array_unique(priorities);
      asort(priorities);
 */
      IEventListener[] result = null;
/*       foreach (priorities as priority) {
        if (isset(globalListeners[priority])) {
            result = array_merge(result, globalListeners[priority]);
        }
        if (isset(localListeners[priority])) {
            result = array_merge(result, localListeners[priority]);
        }
      }

 */      return result;
    }

    // Returns the listeners for the specified event key indexed by priority
    IEventListener[] prioritisedListeners(string eventKey) {
      // if (eventKey !in _listeners || _listeners[eventKey].empty) return [];

      return null; } // _listeners[eventKey]; }

    // Returns the listeners matching a specified pattern
    IEventListener[] matchingListeners(string eventKeyPattern) {
      IEventListener[] matches;

      // TODO
/*       matchPattern = "/" . preg_quote(eventKeyPattern, "/") . "/";
      matches = array_intersect_key(
          _listeners,
          array_flip(
              preg_grep(matchPattern, _listeners.keys, 0)
          )
      );
 */
      return matches; }

    // Returns the event list.
    auto getEventList() {
      return _eventList; }

    // Adds an event to the list if the event list object is present.
    O addEventToList(this O)(IEvent event) {
      if (_eventList) _eventList.add(event);
      return cast(O)this; }
version(test_uim_servers) {
  unittest {
    writeln("--- Test in ", __MODULE__, "/", __LINE__);
        // TODO Add tests
        }}

    // Enables / disables event tracking at runtime.
    O trackEvents(this O)(bool enabled) {
      _trackEvents = enabled;

      return cast(O)this; }
version(test_uim_servers) {
  unittest {
    writeln("--- Test in ", __MODULE__, "/", __LINE__);
        // TODO Add tests
        }}

    // Returns whether this manager is set up to track events
    bool isTrackingEvents() {
      return _trackEvents && _eventList; }
version(test_uim_servers) {
  unittest {
    writeln("--- Test in ", __MODULE__, "/", __LINE__);
        // TODO Add tests
        }}

    // Enables the listing of dispatched events.
    // eventList The event list object to use.
    O setEventList(this O)(DEventList eventList) {
      _eventList = eventList;
      _trackEvents = true;

      return cast(O)this; }
version(test_uim_servers) {
  unittest {
    writeln("--- Test in ", __MODULE__, "/", __LINE__);
        // TODO Add tests
        }}

    // Disables the listing of dispatched events.
    O unsetEventList(this O)() {
      _eventList = null;
      _trackEvents = false;

      return cast(O)this; }
version(test_uim_servers) {
  unittest {
    writeln("--- Test in ", __MODULE__, "/", __LINE__);
        // TODO Add tests
}}

// Debug friendly object properties.
public STRINGAA __debugInfo() {
  STRINGAA properties;
/*         properties = get_object_vars(this);
        properties["_generalManager"] = "(object) EventManager";
        properties["_listeners"] = [];
        foreach (_listeners as key => priorities) {
            listenerCount = 0;
            foreach (priorities as listeners) {
                listenerCount += count(listeners);
            }
            properties["_listeners"][key] = listenerCount . " listener(s)";
        }
        if (_eventList) {
            count = count(_eventList);
            for (i = 0; i < count; i++) {
                event = _eventList[i];
                try {
                    subject = event.getSubject();
                    properties["_dispatchedEvents"][] = event.getName() . " with subject " . get_class(subject);
                } catch (CakeException e) {
                    properties["_dispatchedEvents"][] = event.getName() . " with no subject";
                }
            }
        } else {
            properties["_dispatchedEvents"] = null;
        }
        unset(properties["_eventList"]);
 * /
        return properties;
    }*/
    return null;
  }
}