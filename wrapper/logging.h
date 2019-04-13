#include <syslog.h>
#import <os/log.h>
#include <pthread.h>

extern os_log_t g_asepsis_log;
extern char g_asepsis_executable_path[1024];
extern pthread_mutex_t g_asepsis_mutex;

#if defined(DEBUG)
#  define DLOG(s, ...) asepsis_setup_safe(), asepsis_setup_logging(), pthread_mutex_lock(&g_asepsis_mutex), os_log_debug(g_asepsis_log, "[%s] " s, g_asepsis_executable_path, __VA_ARGS__), pthread_mutex_unlock(&g_asepsis_mutex)
#else
#  define DLOG(s, ...)
#endif

#define ERROR(s, ...) asepsis_setup_safe(), asepsis_setup_logging(), pthread_mutex_lock(&g_asepsis_mutex), os_log_error(g_asepsis_log, "[%s] " s, g_asepsis_executable_path, __VA_ARGS__), pthread_mutex_unlock(&g_asepsis_mutex)

#define CHECK_OVERRIDE(x, name) \
if (x) { ERROR("  !> failed to override %s", # name); } else { DLOG("  -> overriden " # name " as %p (->%p)", name, name ## _reentry); }
