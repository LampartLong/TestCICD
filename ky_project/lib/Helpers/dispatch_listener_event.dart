class DispatchListenerEvent {
  //map event listener
  static Map<String, Map<String,  Function>> events = {};

  //Add listener event
  static listener(String key, Function event, String stopKey) {
    if (DispatchListenerEvent.events.containsKey(key)) {
      DispatchListenerEvent.events[key]?.addAll({stopKey: event});
      return;
    }

    DispatchListenerEvent.events.addAll({key: {stopKey: event}});
  }

  //Dispatch event
  static dispatch(String key, {dynamic data}) {
    if (!DispatchListenerEvent.events.containsKey(key)) {
      return;
    }

    DispatchListenerEvent.events[key]!.forEach((k, v) {
      if(data == null){
        events[key]?[k]?.call();
      } else {
        events[key]?[k]?.call(data);
      }
    });
  }

  //Remove listener event
  static remove(String key, String stopKey) {
    if (!DispatchListenerEvent.events.containsKey(key)) {
      return;
    }

    if(!DispatchListenerEvent.events[key]!.containsKey(stopKey)){
      return;
    }

    DispatchListenerEvent.events[key]?.remove(stopKey);
  }
}
