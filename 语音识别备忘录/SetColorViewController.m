
#import "SetColorViewController.h"

@interface SetColorViewController ()

@end

@implementation SetColorViewController

+(void)initialize{
    
    
    
}


+(void)setupNavTheme{

    UINavigationBar *navBar = [UINavigationBar appearance
                               ];

    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSForegroundColorAttributeName] = [UIColor whiteColor];
    att[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    
    [navBar setTitleTextAttributes:att];
    
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}


@end
