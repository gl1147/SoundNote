//
//  DetailViewController.h
//  SoundNote
//
//  Created by yujiaqi on 4/25/17.
//  Copyright © 2017 yujiaqi. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "iflyMSC/IFlyRecognizerViewDelegate.h"
@class IFlyRecognizerView;
@class PopupView;

@interface DetailViewController : UIViewController
@property (nonatomic, assign) NSInteger index;
@property (nonatomic,strong) IFlyRecognizerView *iflyRecognizerView;
@property (nonatomic,strong) PopupView* popView;

@end
