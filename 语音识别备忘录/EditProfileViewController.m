

#import "EditProfileViewController.h"

@interface EditProfileViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textfield;

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.cell.textLabel.text;
    
    self.textfield.text = self.cell.detailTextLabel.text;

    //add a save button
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveBtn)];

}


-(void)saveBtn{
    
    self.cell.detailTextLabel.text = self.textfield.text;
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [self.cell layoutSubviews];

    
}


@end
