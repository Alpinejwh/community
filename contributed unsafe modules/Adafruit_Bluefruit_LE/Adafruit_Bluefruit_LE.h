#include <stdint.h>

#define false 0
#define true 1

#ifndef int32
// this should only occur on the AVR platform
#define int32 long
#endif

#ifndef uint32
// this should only occur on the AVR platform
#define uint32 unsigned long
#endif

#ifndef bool
// this should only occur on the AVR platform
#ifdef __clang_version__
#define bool _Bool
#endif
#endif

#ifdef __clang_version__
#define NOT_NULLABLE __nonnull
#define NULLABLE __nullable
#else
#define NOT_NULLABLE 
#define NULLABLE 
#endif

#ifndef __clang_version__
extern "C" {
#endif

	bool btstart();
	bool btreset();
	bool btecho(bool on);
	bool btcheckminimumversion(const char * version);
	bool btfactoryreset();
	bool btisconnected();
	bool btsetmode(uint8_t new_mode);
	bool btsendcommandbuffer(const char * cmd);
	bool btsendcommandfixedstring(const char * cmd);
	bool btwaitforok();
	void btprintbuffer(const char * cmd, bool addNewline);
	void btprintfixedstring(const char * cmd, bool addNewline);
	uint16_t btavailable();
	uint16_t btread();

  extern const bool BLUEFRUIT_MODE_DATA;
  extern const bool BLUEFRUIT_MODE_COMMAND;
#ifndef __clang_version__
}
#endif