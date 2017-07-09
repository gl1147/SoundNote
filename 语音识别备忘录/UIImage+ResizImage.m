
#import "UIImage+ResizImage.h"

@implementation UIImage (ResizImage)
+ (UIImage *)resizeWithImageName:(NSString *)name {
    
    UIImage *normal = [UIImage imageNamed:name];
    
    CGFloat w = normal.size.width*0.5;
    CGFloat h = normal.size.height*0.5;
   
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];

}
@end
