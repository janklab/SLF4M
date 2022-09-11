/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// Contributors:  Kitching Simon <Simon.Kitching@orange.ch>

package org.apache.log4j;

/**
   <font color="#AA4444">Refrain from using this class directly, use
   the {@link Level} class instead</font>.

   @author Ceki G&uuml;lc&uuml;
   */
public class Priority {

  transient int level;
  transient String levelStr;
  transient int syslogEquivalent;

  public static final int OFF_INT = Integer.MAX_VALUE;
  public static final int FATAL_INT = 50000;
  public static final int ERROR_INT = 40000;
  public static final int WARN_INT  = 30000;
  public static final int INFO_INT  = 20000;
  public static final int DEBUG_INT = 10000;
    //public static final int FINE_INT = DEBUG_INT;
  public static final int ALL_INT = Integer.MIN_VALUE;

  /**
   * @deprecated Use {@link Level#FATAL} instead.
   */
  public static final Priority FATAL = new Level(FATAL_INT, "FATAL", 0);

  /**
   * @deprecated Use {@link Level#ERROR} instead.
   */
  public static final Priority ERROR = new Level(ERROR_INT, "ERROR", 3);

  /**
   * @deprecated Use {@link Level#WARN} instead.
   */
  public static final Priority WARN  = new Level(WARN_INT, "WARN",  4);

  /**
   * @deprecated Use {@link Level#INFO} instead.
   */
  public static final Priority INFO  = new Level(INFO_INT, "INFO",  6);

  /**
   * @deprecated Use {@link Level#DEBUG} instead.
   */
  public static final Priority DEBUG = new Level(DEBUG_INT, "DEBUG", 7);


  /**
    * Default constructor for deserialization.
    */
  protected Priority() {
      level = DEBUG_INT;
      levelStr = "DEBUG";
      syslogEquivalent = 7;
  }

  /**
     Instantiate a priority object.
     @param level The numeric level of this priority.
     @param levelStr The name of this priority.
     @param syslogEquivalent The numeric syslog level this priority is like.
   */
  protected
  Priority(int level, String levelStr, int syslogEquivalent) {
    this.level = level;
    this.levelStr = levelStr;
    this.syslogEquivalent = syslogEquivalent;
  }

  /**
     Two priorities are equal if their level fields are equal.
     @param o The other priority to compare to.
     @since 1.2
   */
  public
  boolean equals(Object o) {
    if(o instanceof Priority) {
      Priority r = (Priority) o;
      return (this.level == r.level);
    } else {
      return false;
    }
  }

  /**
     Return the syslog equivalent of this priority as an integer.
     @return A syslog level value.
   */
  public
  final
  int getSyslogEquivalent() {
    return syslogEquivalent;
  }
   
  /**
     Returns <code>true</code> if this priority has a higher or equal
     level than the priority passed as argument, <code>false</code>
     otherwise.  
     
     <p>You should think twice before overriding the default
     implementation of <code>isGreaterOrEqual</code> method.

     @param r The priority to compare against.
     @return A boolean.
  */
  public
  boolean isGreaterOrEqual(Priority r) {
    return level >= r.level;
  }

  /**
     Return all possible priorities as an array of Level objects in
     descending order.

     @return A descending-ordered Priority[] array.
     @deprecated This method will be removed with no replacement.
  */
  public
  static
  Priority[] getAllPossiblePriorities() {
    return new Priority[] {Priority.FATAL, Priority.ERROR, Level.WARN, 
			   Priority.INFO, Priority.DEBUG};
  }

  /**
     Returns the string representation of this priority.
     @return A priority name.
   */
  final
  public
  String toString() {
    return levelStr;
  }

  /**
     Returns the integer representation of this priority.
     @return An integer priority identifier.
   */
  public
  final
  int toInt() {
    return level;
  }

  /**
   * @param sArg A name identifying a priority.
   * @deprecated Please use the {@link Level#toLevel(String)} method instead.
  */
  public
  static
  Priority toPriority(String sArg) {
    return Level.toLevel(sArg);
  }

  /**
   * @param val A numeric level identifier.
   * @deprecated Please use the {@link Level#toLevel(int)} method instead.   
   */
  public
  static
  Priority toPriority(int val) {
    return toPriority(val, Priority.DEBUG);
  }

  /**
   * @param val A numeric level identifier.
   * @param defaultPriority The priority to fall back to if level resolution fails.
   * @deprecated Please use the {@link Level#toLevel(int, Level)} method instead.   
  */
  public
  static
  Priority toPriority(int val, Priority defaultPriority) {
    return Level.toLevel(val, (Level) defaultPriority);
  }

  /**
   * @param sArg A name identifying a priority.
   * @param defaultPriority The priority to fall back to if name resolution fails.
   * @deprecated Please use the {@link Level#toLevel(String, Level)} method instead.   
   */
  public
  static
  Priority toPriority(String sArg, Priority defaultPriority) {                  
    return Level.toLevel(sArg, (Level) defaultPriority);
  }
}
