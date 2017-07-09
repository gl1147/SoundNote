
#import <UIKit/UIKit.h>
@class MessageFrameModel;
@interface MessageCell : UITableViewCell

+ (instancetype)messageCellWithTableView:(UITableView *)tableview;

//frame model
@property (nonatomic, strong)MessageFrameModel *frameMessage;

@end
