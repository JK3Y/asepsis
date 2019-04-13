#include <syslog.h>
#import <os/log.h>
#include <pthread.h>

extern os_log_t g_asepsis_log;
extern pthread_mutex_t g_asepsis_mutex;

#if defined(DEBUG)
#  define DLOG(...) asepsis_setup_safe(), asepsis_setup_logging(), pthread_mutex_lock(&g_asepsis_mutex), os_log_debug(g_asepsis_log, __VA_ARGS__), printf(__VA_ARGS__), pthread_mutex_unlock(&g_asepsis_mutex)
#else
#  define DLOG(s, ...)
#endif

#define ERROR(...) asepsis_setup_safe(), asepsis_setup_logging(), pthread_mutex_lock(&g_asepsis_mutex), os_log_error(g_asepsis_log, __VA_ARGS__), printf(__VA_ARGS__), pthread_mutex_unlock(&g_asepsis_mutex)
#define INFO(...) asepsis_setup_safe(), asepsis_setup_logging(), pthread_mutex_lock(&g_asepsis_mutex), os_log_info(g_asepsis_log, __VA_ARGS__), printf(__VA_ARGS__), pthread_mutex_unlock(&g_asepsis_mutex)
