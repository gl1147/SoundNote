
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class MessageModel;
@interface MessageFrameModel : NSObject

@property (nonatomic, assign,readonly)CGRect timeF;

@property (nonatomic, assign,readonly)CGRect textViewF;

@property (nonatomic, assign,readonly)CGRect iconF;

@property (nonatomic, assign,readonly)CGFloat cellH;

@property (nonatomic, strong)MessageModel *message;
@end
