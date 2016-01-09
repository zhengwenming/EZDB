//
//  BOCOPDebug.h
//
//  By lian jie on 1/26/13.

#define BOCOPDEBUG
#define BOCOPLOGLEVEL_INFO     10
#define BOCOPLOGLEVEL_ERROR    1

#ifndef BOCOPMAXLOGLEVEL

#define BOCOPMAXLOGLEVEL BOCOPLOGLEVEL_INFO

#endif

// The general purpose logger. This ignores logging levels.
#ifdef BOCOPDEBUG
#define BOCOPDPRINT(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define BOCOPDPRINT(xx, ...)  ((void)0)
#endif

// Prints the current method's name.
#define ITTDPRINTMETHODNAME() BOCOPDPRINT(@"%s", __PRETTY_FUNCTION__)

// Log-level based logging macros.
#if BOCOPLOGLEVEL_ERROR <= BOCOPMAXLOGLEVEL
  #define BOCOPDERROR(xx, ...)  BOCOPDPRINT(xx, ##__VA_ARGS__)
#else
  #define BOCOPDERROR(xx, ...)  ((void)0)
#endif

#if BOCOPLOGLEVEL_INFO <= BOCOPMAXLOGLEVEL
  #define BOCOPDINFO(xx, ...)  BOCOPDPRINT(xx, ##__VA_ARGS__)
#else
  #define BOCOPDINFO(xx, ...)  ((void)0)
#endif
