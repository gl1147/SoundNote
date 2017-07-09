//
//  DetailViewController.m
//  SoundNote
//
//  Created by yujiaqi on 4/25/17.
//  Copyright © 2017 yujiaqi. All rights reserved.
//


#import "DetailViewController.h"
#import "MainViewController.h"
#import "AddNoteViewController.h"
#import "PopupView.h"
#import "Definition.h"
#import "iflyMSC/IFlySpeechConstant.h"
#import "iflyMSC/IFlySpeechUtility.h"
#import "iflyMSC/IFlyRecognizerView.h"


@interface DetailViewController ()<UIAlertViewDelegate,UITextViewDelegate,IFlyRecognizerViewDelegate>

{
    NSDate *_selected;
    UIBarButtonItem *_saveBtn;
}

@property  IBOutlet UITextView *mytextView;
@property (weak, nonatomic) IBOutlet UILabel *countDay;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;
@property (weak, nonatomic) IBOutlet UIView *ViewCell;
@property (weak, nonatomic) IBOutlet UIButton *remindBtn;
@property (weak, nonatomic) IBOutlet UIButton *pictureBtn;
@property (weak, nonatomic) IBOutlet UIButton *recordBtn;

//@property UITextView *mytextView;
@end

@implementation DetailViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self = [[[NSBundle mainBundle]loadNibNamed:@"DetailViewController" owner:nil options:nil]firstObject];

    }
    return self;
}

//remind button
- (IBAction)remind:(UIButton *)sender {
    
    _ViewCell.hidden = NO;
    _pictureBtn.hidden = NO;
    _finishBtn.hidden = NO;
    _remindBtn.hidden = YES;
    _pictureBtn.hidden = YES;
    _recordBtn.hidden = YES;
    _datePicker.hidden = NO;
    
    
    
}
- (IBAction)help:(UIButton *)sender {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Help" message:@"Press record buttion to start voice recognition" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    
}

- (IBAction)startRecord:(UIButton *)sender {
    
    
    [self startListenning:sender];
    
}

//finish button
- (IBAction)finished:(UIButton *)sender {

    //get the user chosen date and time
    NSDate *selected = [self.datePicker date];
    //create a date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //set up string for date formatter
    [dateFormatter setDateFormat:@"yyyy年MM月dd日  HH:mm "];

    NSTimeZone *zone1 = [NSTimeZone systemTimeZone];
    NSInteger interval1 = [zone1 secondsFromGMTForDate:selected];
    NSDate *localTime1 = [selected dateByAddingTimeInterval:interval1];
    
    //get the current system time
    NSDate *now = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:now];
    NSDate *localTime = [now dateByAddingTimeInterval:interval];
    
    
    //get the time difference
    NSTimeInterval time = [localTime1 timeIntervalSinceDate:localTime];
    
    int days = ((int)time)/(3600*24);
    int hours = ((int)time)%(3600*24)/3600;
    int minute = ((int)time)%(3600*24)%3600/60;
    
    if (days <= 0&&hours <= 0&&minute <= 0)
    {_countDay.text=@"0天0小时0分钟";}
    
    else{
        _countDay.text=[[NSString alloc] initWithFormat:@"%i天%i小时%i分钟",days,hours,minute];}
    
    _selected = selected;
    self.datePicker.hidden = YES;
    self.recordBtn.hidden =NO;
    self.remindBtn.hidden = NO;
    self.pictureBtn.hidden = NO;
    self.ViewCell.hidden = YES;
    self.finishBtn.hidden = YES;
    
    //_saveBtn.enabled = YES;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    //become first responder
    [_mytextView becomeFirstResponder];
    
    _mytextView.delegate = self;
    _mytextView.returnKeyType = UIReturnKeyDefault;
    
    _popView = [[PopupView alloc] initWithFrame:CGRectMake(100, 150, 0, 0)];
    _popView.ParentView = self.view;
    
    //create object for voice recognition
    self.iflyRecognizerView= [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
    
    //delegate needs to set up，to make sure delegate call back return normally
    _iflyRecognizerView.delegate = self;

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIBarButtonItem *saveBtn = [[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveclicked)];
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelClicked)];
    
    self.navigationItem.leftBarButtonItem = cancelBtn;
    self.navigationItem.rightBarButtonItem = saveBtn;
    _saveBtn = saveBtn;
    
    self.hidesBottomBarWhenPushed = YES;
}

-(void)cancelClicked {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"note"];
    
    
    NSString *oldtext = [array objectAtIndex:self.index];
    
    self.mytextView.text = oldtext;
    
        
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark save function
-(void)saveclicked {
    
    NSMutableArray *mutableArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"note"] mutableCopy];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init ];
    
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    
    NSDate *now = [NSDate date];
    
    NSString *datestring = [dateFormatter stringFromDate:now];
    
    NSString *textstring = [self.mytextView text];
    
    [mutableArray replaceObjectAtIndex:self.index withObject:textstring];
    
    [[NSUserDefaults standardUserDefaults] setObject:mutableArray forKey:@"note"];
    
    
    
    //create a date formatter
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc]init];
    //set up string for date formatter
    [dateFormatter1 setDateFormat:@"yyyy年MM月dd日  HH:mm "];
    
    
    
    NSMutableArray *tempCountDateArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"countdate"] mutableCopy];
    
    if (![self.mytextView.text isEqualToString:mutableArray[self.index]]) {
        [tempCountDateArray replaceObjectAtIndex:self.index withObject:_selected];
        [[NSUserDefaults standardUserDefaults] setObject:tempCountDateArray forKey:@"countdate"];
    }
    
    NSMutableArray *mutableDateArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"date"] mutableCopy];
    
    
    [mutableDateArray replaceObjectAtIndex:self.index withObject:datestring];

    
    [[NSUserDefaults standardUserDefaults] setObject:mutableDateArray forKey:@"date"];
    
  
    [self.mytextView resignFirstResponder];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Changes have been saved" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    
    [alert show];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    [self.navigationController popViewControllerAnimated:YES];

}

-(void)viewWillDisappear:(BOOL)animated
{
    //end recognition
    [_iflyRecognizerView cancel];
    [_iflyRecognizerView setDelegate:nil];
    
    [super viewWillDisappear:animated];
}

/**
start button response method
 */
- (void)startListenning:(id)sender
{
    [_iflyRecognizerView setParameter: @"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    
    //set the result data format，can be json，xml，plain，default json
    [_iflyRecognizerView setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
    
    [_iflyRecognizerView start];
    
    NSLog(@"start listenning...");
}

#pragma mark IFlyRecognizerViewDelegate

/** recognition result call back
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

/** identify end call back function
 @param error
 */
- (void)onError:(IFlySpeechError *)error
{
    [self.view addSubview:_popView];
    
    [_popView setText:@"Session ended"];
    
    NSLog(@"errorCode:%d",[error errorCode]);
}




//return button
- (IBAction)back:(UIBarButtonItem *)sender {
    
    [self saveclicked];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}


@end
