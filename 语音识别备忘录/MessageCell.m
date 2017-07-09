

#import "MessageCell.h"
#import "MessageFrameModel.h"
#import "MessageModel.h"
#import "Constant.h"
#import "UIImage+ResizImage.h"
@interface MessageCell()
//time
@property (nonatomic, weak)UILabel *time;
//text
@property (nonatomic, weak)UIButton *textView;
//profile pic
@property (nonatomic, weak)UIImageView *icon;

@end

@implementation MessageCell
+ (instancetype)messageCellWithTableView:(UITableView *)tableview
{
    static NSString *ID = @"messageCell";
    MessageCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //time
        UILabel *time = [[UILabel alloc]init];
        time.textAlignment = NSTextAlignmentCenter;
        time.font = [UIFont systemFontOfSize:13.0f];
        [self.contentView addSubview:time];
        self.time = time;
        
        //text
        UIButton *textView = [[UIButton alloc]init];
        textView.titleLabel.font = bBtnFont;
        textView.titleLabel.numberOfLines = 0;
        textView.contentEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
        [textView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:textView];
        self.textView = textView;
        
        //profile pic
        UIImageView *icon = [[UIImageView alloc]init];
        icon.layer.masksToBounds = YES;
        icon.layer.cornerRadius = 25.0;
        icon.layer.borderColor = [UIColor whiteColor].CGColor;
        icon.layer.borderWidth = 1.0;
        [self.contentView addSubview:icon];
        self.icon = icon;
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

//set content and frame
- (void)setFrameMessage:(MessageFrameModel *)frameMessage
{
    _frameMessage = frameMessage;
    
    MessageModel *model = frameMessage.message;
    
    //1.time
    self.time.frame = frameMessage.timeF;
    self.time.text = model.time;
    
    //2.image
    self.icon.frame = frameMessage.iconF;
    if (model.type == MessageModelMe) {
        self.icon.image = [UIImage imageNamed:@"me.jpg"];
    }else{
        self.icon.image = [UIImage imageNamed:@"robot.jpg"];
    }
    
    //3.text
    self.textView.frame = frameMessage.textViewF;
    [self.textView setTitle:model.text forState:UIControlStateNormal];
    
    
    if (model.type == MessageModelMe) {
        
        [self.textView setBackgroundImage:[UIImage resizeWithImageName:@"chat_send_nor"] forState:UIControlStateNormal];
    }else{
        [self.textView setBackgroundImage:[UIImage resizeWithImageName:@"chat_recive_nor"] forState:UIControlStateNormal];
    }
    
}




@end
