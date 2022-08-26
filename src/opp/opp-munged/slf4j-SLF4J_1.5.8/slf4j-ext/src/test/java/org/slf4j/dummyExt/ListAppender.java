package org.slf4j.dummyExt;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.AppenderSkeleton;
import org.apache.log4j.spi.LoggingEvent;

public class ListAppender extends AppenderSkeleton {

  public List<LoggingEvent> list = new ArrayList<LoggingEvent>();
  
  public boolean extractLocationInfo = false;
  
  protected void append(LoggingEvent event) {
    list.add(event);
    if(extractLocationInfo) {
      event.getLocationInformation();
    }
  }

  public void close() {
  }

  public boolean requiresLayout() {
    return false;
  }

}

