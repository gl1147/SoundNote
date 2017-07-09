
#import "MessageFrameModel.h"
#import "Constant.h"
#import "MessageModel.h"
#import <UIKit/UIKit.h>
@implementation MessageFrameModel

- (void)setMessage:(MessageModel *)message
{
    _message = message;
    
    CGFloat padding = 10;
    //1. time
    if (message.hideTime == NO) {
        CGFloat timeX = 0;
        CGFloat timeY = 0;
        CGFloat timeW = bScreenWidth;
        CGFloat timeH = bNormalH;
        
        _timeF = CGRectMake(timeX, timeY, timeW, timeH);
    }
    
    
    
    
    //2.profile pic
    CGFloat iconX;
    CGFloat iconY = CGRectGetMaxY(_timeF);
    CGFloat iconW = bIconW;
    CGFloat iconH = bIconH;
    
    if (message.type == MessageModelMe) {//self sent
        
        iconX = bScreenWidth - iconW - padding;
        
    }else{//other sent
        iconX = padding;
    }
    
    _iconF =  CGRectMake(iconX, iconY, iconW, iconH);
    
    //3.text
    CGFloat textX;
    CGFloat textY = CGRectGetMaxY(_timeF);
    
    CGSize textMaxSize = CGSizeMake(150, MAXFLOAT);
    CGSize textRealSize = [message.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:bBtnFont} context:nil].size;
    
    CGSize btnSize = CGSizeMake(textRealSize.width + 40, textRealSize.height + 40);
    
    if (message.type == MessageModelMe) {
        textX = bScreenWidth - iconW - padding*2 - btnSize.width;
    }else{
        textX = padding*2 + iconW;
    }

    _textViewF = (CGRect){{textX,textY},btnSize};
    
    //4.cell height
    
    CGFloat iconMaxY = CGRectGetMaxY(_iconF);
    CGFloat textMaxY = CGRectGetMaxY(_textViewF);
    
    _cellH = MAX(iconMaxY, textMaxY);
    
    
}

@end
