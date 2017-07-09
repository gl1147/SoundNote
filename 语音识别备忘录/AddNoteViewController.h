//
//  AddNoteViewController.h
//  SoundNote
//
//  Created by yujiaqi on 4/25/17.
//  Copyright © 2017 yujiaqi. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "iflyMSC/IFlyRecognizerViewDelegate.h"

@class IFlyRecognizerView;
@class PopupView;
/**
 we implement the iflyMSC 
 There are UI speech recognition demo
  It takes only four steps to use this function
  1. Create recognition objects;
  2. Set the identification parameters;
  3. Selective implementation to identify callbacks;
  4. Start recognition
 */

@interface AddNoteViewController : UIViewController<IFlyRecognizerViewDelegate>

//interface with the object for recognition

@property (nonatomic,strong) IFlyRecognizerView * iflyRecognizerView;

@property (nonatomic,strong) PopupView          * popView;

@property (weak, nonatomic) IBOutlet UITextView *textView;


@end
