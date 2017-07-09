//
//  CycleScrollView.h
//  SoundNote
//
//  Created by yujiaqi on 4/28/17.
//  Copyright © 2017 yujiaqi. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface CycleScrollView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong, readonly) UIPageControl *pageControl;
@property (nonatomic , readonly) UIScrollView *scrollView;

- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration;


@property (nonatomic , copy) NSInteger (^totalPagesCount)(void);

@property (nonatomic , copy) UIView *(^fetchContentViewAtIndex)(NSInteger pageIndex);

@property (nonatomic , copy) void (^TapActionBlock)(NSInteger pageIndex);


@end
