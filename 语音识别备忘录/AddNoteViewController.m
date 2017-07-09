//
//  AddNoteViewController.m
//  SoundNote
//
//  Created by yujiaqi on 4/25/17.
//  Copyright © 2017 yujiaqi. All rights reserved.
//


#import "AddNoteViewController.h"
#import "MainViewController.h"
#import "Definition.h"
#import "iflyMSC/IFlySpeechConstant.h"
#import "iflyMSC/IFlySpeechUtility.h"
#import "iflyMSC/IFlyRecognizerView.h"
#import "PopupView.h"
#import <UIKit/UIKit.h>
#import "UIColor+Hash.h"

@interface AddNoteViewController ()<UIAlertViewDelegate,UITextViewDelegate>
{
    NSDate *_selected;
    UIButton *_saveBtn;
}



@property (weak, nonatomic) IBOutlet UIButton *remindBtn;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *savaFinish;
@property (strong, nonatomic) IBOutlet UIButton *ringhtBtn;
@property (weak, nonatomic) IBOutlet UITextView *mytextView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UIButton *recordBtn;
@property (strong, nonatomic) IBOutlet UIView *viewCell;
@property (strong, nonatomic) IBOutlet UIButton *finishBtn;
@property (strong, nonatomic) IBOutlet UILabel *countDay;
@property (assign, nonatomic) NSInteger num;

@end

@implementation AddNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *color = [[NSUserDefaults standardUserDefaults] objectForKey:@"color"];
    self.navigationController.navigationBar.barTintColor = [UIColor colorFromHexString:color];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    _mytextView.delegate = self;
    
    _mytextView.returnKeyType = UIReturnKeyDefault;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _popView = [[PopupView alloc] initWithFrame:CGRectMake(100, 150, 0, 0)];
    _popView.ParentView = self.view;
    
    //creating the object for voice recognition
    self.iflyRecognizerView= [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
    
    //delegate needs set up ，make sure delegate call back can return normally
    _iflyRecognizerView.delegate = self;
    
    _savaFinish.enabled = NO;
}

//select date
- (IBAction)dateBtn:(UIButton *)sender {
    
    self.datePicker.hidden = NO;
    self.recordBtn.hidden =YES;
    self.remindBtn.hidden = YES;
    self.ringhtBtn.hidden = YES;
    self.viewCell.hidden = NO;
    self.finishBtn.hidden = NO;
    
}

// dismiss
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//finish button
- (IBAction)finishedBtn:(id)sender {
    
    
    //create the user selected time
    NSDate *selected = [self.datePicker date];
    //Create a date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //Sets the format string for the date formatter
    [dateFormatter setDateFormat:@"yyyy年MM月dd日  HH:mm "];
    //Format date, time using date builder
    //NSString *dateString = [dateFormatter stringFromDate:selected];
    //NSString *message =  [NSString stringWithFormat:@"the date and time you choose is ：%@", dateString];
    NSTimeZone *zone1 = [NSTimeZone systemTimeZone];
    NSInteger interval1 = [zone1 secondsFromGMTForDate:selected];
    NSDate *localTime1 = [selected dateByAddingTimeInterval:interval1];
    
    NSLog(@"%@",localTime1);
    
    
    _selected = selected;
    
    //get the current system time
    NSDate *now = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:now];
    NSDate *localTime = [now dateByAddingTimeInterval:interval];
    

    //get the time difference
    NSTimeInterval time = [localTime1 timeIntervalSinceDate:localTime];
    
    //notification
    UILocalNotification *local = [[UILocalNotification alloc]init];
    local.fireDate = [NSDate dateWithTimeIntervalSinceNow:time];
    local.alertBody = self.mytextView.text;
    local.soundName = @"";
    [local setApplicationIconBadgeNumber:1];
    [[UIApplication sharedApplication] scheduleLocalNotification:local];

    
    int days = ((int)time)/(3600*24);
    int hours = ((int)time)%(3600*24)/3600;
    int minute = ((int)time)%(3600*24)%3600/60;
    
    if (days <= 0&&hours <= 0&&minute <= 0)
    {_countDay.text=@"0天0小时0分钟";}
    
    else{
        _countDay.text=[[NSString alloc] initWithFormat:@"%i天%i小时%i分钟",days,hours,minute];}

    
    self.datePicker.hidden = YES;
    self.recordBtn.hidden =NO;
    self.remindBtn.hidden = NO;
    self.ringhtBtn.hidden = NO;
    self.viewCell.hidden = YES;
    self.finishBtn.hidden = YES;
    _savaFinish.enabled = YES;

}


//help button
- (IBAction)help:(UIButton *)sender {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Help" message:@"Press record buttion to start voice recognition." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    
    
}


//release record button
- (IBAction)recordBtn:(UIButton *)sender {
    [self startListenning:sender];

    
}

//save
- (IBAction)savaBtn:(UIBarButtonItem *)sender {
    
    [self saveclicked];
    
    
}


//keyboard return
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
//    if ([text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder];
//        return NO;
//    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length>0) {
        _savaFinish.enabled = YES;
    }
    
}


#pragma mark save function
-(void)saveclicked {
    
    
    NSMutableArray *initNoteArray = [[NSMutableArray alloc]init];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"note"] == nil) {
        
        [[NSUserDefaults standardUserDefaults] setObject:initNoteArray forKey:@"note"];
        
    }
    
    NSArray *tempNoteArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"note"];
    
    NSMutableArray *mutableNoteArray = [tempNoteArray mutableCopy];
    
    NSString *textstring = [self.mytextView text];
    
    [mutableNoteArray insertObject:textstring atIndex:0];
    
    MainViewController *mainControl = [[MainViewController alloc]init];
    
    mainControl.noteArray = mutableNoteArray;
    
    [[NSUserDefaults standardUserDefaults] setObject:mutableNoteArray forKey:@"note"];
    
    NSMutableArray *initDateArray = [[NSMutableArray alloc]init];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"date"]==nil) {
        
        [[NSUserDefaults standardUserDefaults] setObject:initDateArray forKey:@"date"];
    
    }
    
    NSArray *tempDateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
    
    NSMutableArray *mutableDateArray = [tempDateArray mutableCopy];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init ];
    
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
   
    NSDate *now = [NSDate date];
    
    NSString *datestring = [dateFormatter stringFromDate:now];
    
    [mutableDateArray insertObject:datestring atIndex:0 ];
    
    mainControl.dateArray = mutableDateArray;
    
    [[NSUserDefaults standardUserDefaults] setObject:mutableDateArray forKey:@"date"];
    
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"countdate"] == nil) {
        
        [[NSUserDefaults standardUserDefaults] setObject:initDateArray forKey:@"countdate"];
    }
    
    
   
    //create a date formatter
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc]init];
    //create format string for date formatter
    [dateFormatter1 setDateFormat:@"yyyy年MM月dd日  HH:mm "];
    
    

    NSArray *tempCountDateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"countdate"];
    
    NSMutableArray *mutableCountDateArray = [tempCountDateArray mutableCopy];
    
    //NSString *countDayString = [dateFormatter1 stringFromDate:_selected];
    
       
//    [mutableCountDateArray insertObject:_selected atIndex:0];
    
    [mutableCountDateArray insertObject:datestring atIndex:0];
    
    mainControl.countDateArray = mutableCountDateArray;
    
    [[NSUserDefaults standardUserDefaults] setObject:mutableCountDateArray forKey:@"countdate"];
    
    
    
    [self.mytextView resignFirstResponder];
    
    UIAlertView *saveAlert = [[UIAlertView alloc]initWithTitle:nil message:@"New note has been saved" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [saveAlert show];
    
    
    
}

//click action
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
      if (buttonIndex == 0) {
            [self dismissViewControllerAnimated:YES completion:nil];
}

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    //end recognition
    [_iflyRecognizerView cancel];
    [_iflyRecognizerView setDelegate:nil];
    
    [super viewWillDisappear:animated];
}

/**
start button listeining
 */
- (void)startListenning:(id)sender
{
    [_iflyRecognizerView setParameter: @"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    
    //set up result data format，can be json，xml，plain, default json
    [_iflyRecognizerView setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
    
    [_iflyRecognizerView start];
    
    NSLog(@"Start listening...");
}

#pragma mark IFlyRecognizerViewDelegate

/** recognition result call back function
 @param resultArray
 @param isLast YES
 */
- (void)onResult:(NSArray *)resultArray isLast:(BOOL)isLast
{
    NSMutableString *result = [[NSMutableString alloc] init];
    NSDictionary *dic = [resultArray objectAtIndex:0];
    
    for (NSString *key in dic) {
        [result appendFormat:@"%@",key];
    }
    
    _mytextView.text = [NSString stringWithFormat:@"%@%@",_mytextView.text,result];

  

}

/** end recognition result call back fn
 @param error recognition error
 */
- (void)onError:(IFlySpeechError *)error
{
    [self.view addSubview:_popView];
    
    [_popView setText:@"Session ended"];
    
    NSLog(@"errorCode:%d",[error errorCode]);
}



@end
