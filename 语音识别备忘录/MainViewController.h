//
//  MainViewController.h
//  SoundNote
//
//  Created by yujiaqi on 4/25/17.
//  Copyright © 2017 yujiaqi. All rights reserved.
//



#import <UIKit/UIKit.h>

@interface MainViewController : UITableViewController
@property(nonatomic,strong) NSMutableArray *noteArray;//note array
@property(nonatomic,strong) NSMutableArray *dateArray;//time array
@property(nonatomic,strong) NSMutableArray *countDateArray;//count date array
@end
