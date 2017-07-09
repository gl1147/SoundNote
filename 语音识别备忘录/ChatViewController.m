
#import "ChatViewController.h"
#import "MessageModel.h"
#import "MessageCell.h"
#import "MessageFrameModel.h"
#import "UIColor+Hash.h"
@interface ChatViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSString *_results;
}
@property (weak, nonatomic) IBOutlet UITextField *inputView;
@property (nonatomic, strong)NSMutableArray *messages;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ChatViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSString *color = [[NSUserDefaults standardUserDefaults] objectForKey:@"color"];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorFromHexString:color];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    self.title = @"正在与机器人聊天...";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.inputView.delegate = self;
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    //cell not seletable
    self.tableView.allowsSelection = NO;
    
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ali.jpg"]];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
    
    self.inputView.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
    
    self.inputView.leftViewMode = UITextFieldViewModeAlways;
    
}


//send button
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"%@",textField.text);
    //send a message
    [self addmessage:textField.text type:MessageModelMe];
    
    //clear textfield
    self.inputView.text = @"";
    
    
    return YES;
}



//add a message

- (void)addmessage:(NSString *)text type:(MessageModelType)type
{
    
    if (type == MessageModelMe)
    {
        [self addMessageTest:text type:type];
    }
    
    
    NSString *message = self.inputView.text;
    
    //check if its a space
    if (message.length >0 && [message isEqualToString:text])
    {
        NSString *lastUrl = [NSString stringWithFormat:@"http://op.juhe.cn/robot/index?info=%@&key=2be777a4ecb0b45179dbaff56fb711df",message];
        
        
        NSString *changeUrl = [lastUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *url = [NSURL URLWithString:changeUrl];
        
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        __weak ChatViewController *weakSelf = self;
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            
            if (connectionError || data == nil) {
                NSLog(@"Busy");
                return;
            }
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            
            
            NSDictionary *info = dict[@"result"];
            if ([info isEqual:[NSNull null]]) {
                _results = @"Please wait";
            }else {
                _results = info[@"text"];
                
                NSLog(@"Respond:%@",_results);
            }

            [weakSelf addMessageTest:_results type:MessageModelrobot];
        }];
        
    }
}

//
- (void)addMessageTest:(NSString *)text type:(MessageModelType)type
{
    
    //1. add message model
    MessageModel *msg = [[MessageModel alloc]init];
    
    //set values
    NSDate *date = [NSDate date];
    
    NSDateFormatter  *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"MM-dd HH:mm:ss"];
    
    
    msg.time =  [formatter stringFromDate:date];
    msg.text = text;
    msg.type = type;
    
    //set content and frame
    MessageFrameModel *fm = [[MessageFrameModel alloc]init];
    //set frame message
    fm.message = msg;
    [self.messages addObject:fm];
    
    //2. refresh
    [self.tableView reloadData];
    
    

    NSIndexPath *path = [NSIndexPath indexPathForRow:self.messages.count - 1
                                           inSection:0];

    [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}



//when change in keyboard frame detected
- (void)keyboardDidChangeFrame:(NSNotification *)noti
{
    
    //change window color
    self.view.window.backgroundColor = self.tableView.backgroundColor;
    
    //final keyboard frame
    CGRect frame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat keyY = frame.origin.y;
    
    //screen height
    CGFloat screenH = [[UIScreen mainScreen] bounds].size.height;
    
    //animation time
    CGFloat keyDuration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:keyDuration animations:^{
        
        self.view.transform = CGAffineTransformMakeTranslation(0, keyY - screenH);
    }];
    
    
    
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [self.view endEditing:YES];
}



-(NSMutableArray *)messages {
    
    if (_messages == nil) {
        _messages = [NSMutableArray array];
    }
    
    return _messages;
}

#pragma mark tableview data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageFrameModel *model = self.messages[indexPath.row];
    return model.cellH;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCell *cell = [MessageCell messageCellWithTableView:tableView];
    MessageFrameModel *model = self.messages[indexPath.row];
    cell.frameMessage = model;
    
    return cell;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
