////
////  ChangeColorViewController.m
////  SoundNote
////
////  Created by yujiaqi on 5/12/17.
////  Copyright © 2017 yujiaqi. All rights reserved.
////
//
//#import <Foundation/Foundation.h>
//#import "ChangeColorViewController.h"
//
//@interface ChangeColorViewController ()
//@property (weak, nonatomic) IBOutlet UISlider *RedSlider;
//@property (weak, nonatomic) IBOutlet UISlider *GreenSlider;
//@property (weak, nonatomic) IBOutlet UISlider *BlueSlider;
//@property (weak, nonatomic) IBOutlet UILabel *colorDemo;
//
//@end
//
//@implementation ChangeColorViewController
//
//-(void) viewDidLoad{
//    [super viewDidLoad];
//    self.RedInt=255.0;
//     self.BlueInt=255.0;
//     self.GreenInt=255.0;
//    self.colorDemo.backgroundColor= [UIColor blackColor];
//    
//}
//
//- (IBAction)sliderMovedRed:(id)sender {
//    UISlider *RedSlider = (UISlider *) sender;
//    self.RedInt=(int) (RedSlider.value*255.0);
//    self.colorDemo.backgroundColor  = [UIColor colorWithRed:self.RedInt/255.0
//                                           
//                                                          green:self.GreenInt/255.0
//                                                           blue:self.BlueInt/255.0
//                                                          alpha:0.5];
//}
//- (IBAction)sliderMovedGreen:(id)sender {
//    UISlider *GreenSlider = (UISlider *) sender;
//    self.GreenInt=(int) (GreenSlider.value*255.0);
//    self.colorDemo.backgroundColor  = [UIColor colorWithRed:self.RedInt/255.0
//                                       
//                                                      green:self.GreenInt/255.0
//                                                       blue:self.BlueInt/255.0
//                                                      alpha:0.5];
//}
//- (IBAction)sliderMovedBlue:(id)sender {
//    UISlider *BlueSlider = (UISlider *) sender;
//    self.BlueInt=(int) (BlueSlider.value*255.0);
//    self.colorDemo.backgroundColor  = [UIColor colorWithRed:self.RedInt/255.0
//                                       
//                                                      green:self.GreenInt/255.0
//                                                       blue:self.BlueInt/255.0
//                                                      alpha:0.5];
//}
//
//-(IBAction)completeSignIn:(UIStoryboardSegue *    )segue {
//
//
//}
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue
//                 sender:(id)sender {
//     if ([segue.identifier isEqualToString:@"completeChangeColor"]) {
//         
//       
//     }
//    
//}
//
//@end
