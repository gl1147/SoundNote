
#import <Foundation/Foundation.h>
#define Margin  5
#define Padding 10
#define iOS7TopMargin 64 
#define IOS7_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define ButtonHeight 44
#define NavigationBarHeight 44
#define APPID_VALUE @"5549f95d"
#define URL_VALUE             @""                 // url
#define TIMEOUT_VALUE         @"10000"            // timeout
#define BEST_URL_VALUE        @"1"                // best_search_url 

#define SEARCH_AREA_VALUE     @"New York"
#define ASR_PTT_VALUE         @"1"
#define VAD_BOS_VALUE         @"5000"
#define VAD_EOS_VALUE         @"1800"
#define PLAIN_RESULT_VALUE    @"1"
#define ASR_SCH_VALUE         @"1"

#ifdef __IPHONE_6_0
# define IFLY_ALIGN_CENTER NSTextAlignmentCenter
#else
# define IFLY_ALIGN_CENTER UITextAlignmentCenter
#endif

#ifdef __IPHONE_6_0
# define IFLY_ALIGN_LEFT NSTextAlignmentLeft
#else
# define IFLY_ALIGN_LEFT UITextAlignmentLeft
#endif

@interface Definition : NSObject

@end
