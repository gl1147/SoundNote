//
//  PopupView.h
//  SoundNote
//
//  Created by yujiaqi on 4/28/17.
//  Copyright © 2017 yujiaqi. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface PopupView : UIView
{
    UILabel *_textLabel;
    int     _queueCount;
    
}
@property (strong) UIView*  ParentView;
- (void) setText:(NSString *) text;

@end
