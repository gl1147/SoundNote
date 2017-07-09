
#import <Foundation/Foundation.h>
typedef enum {
    MessageModelMe = 0,
    MessageModelrobot
}MessageModelType;
@interface MessageModel : NSObject


@property (nonatomic, copy)NSString *text;

@property (nonatomic, copy)NSString *time;

@property (nonatomic, assign)MessageModelType type;

@property (nonatomic,assign)BOOL hideTime;

+ (instancetype)messageWithDict:(NSDictionary *)dict;

@end
