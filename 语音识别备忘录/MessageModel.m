
#import "MessageModel.h"

@implementation MessageModel

+ (instancetype)messageWithDict:(NSDictionary *)dict
{
    MessageModel *model = [[MessageModel alloc]init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
    
   
}

@end
