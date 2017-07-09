
#import "ProfileViewController.h"
#import "EditProfileViewController.h"
#import "UIColor+Hash.h"

@interface ProfileViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *place;
@property (weak, nonatomic) IBOutlet UILabel *sex;
@property (weak, nonatomic) IBOutlet UILabel *birthday;
@property (weak, nonatomic) IBOutlet UILabel *smartSign;

@end

@implementation ProfileViewController

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    NSString *color = [[NSUserDefaults standardUserDefaults] objectForKey:@"color"];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorFromHexString:color]];

    
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"personal info";
    self.number.text = @"SilverFoxx";
    self.name.text = @"name1";
    self.email.text = @"jy1604@nyu.edu";
    self.place.text = @"nyc";
    self.sex.text = @"female";
    self.birthday.text = @"1996.01.01";
    self.smartSign.text = @"smart";
    
    
    _headView.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    _headView.layer.borderWidth = 3.0;
    
    _headView.layer.cornerRadius = 40.0f;
    
    _headView.backgroundColor = [UIColor clearColor];
    
    _headView.layer.masksToBounds = YES;

    
    
    NSData *imageData = [[NSUserDefaults standardUserDefaults] dataForKey:@"headview"];
    
    UIImage *image = [UIImage imageWithData:imageData];
    
    self.headView.image = image;
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSInteger tag = cell.tag;
    
    //select picture
    if (tag == 0) {
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"please select" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:@"take picture" otherButtonTitles:@"select from camera roll", nil];
        
        [sheet showInView:self.view];
        
    }
        if (tag == 1) {
            
            [self performSegueWithIdentifier:@"editsegue" sender:cell];
    
           
        }else {
            
            return;
            
        }
    
}

//pass value
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //get the controller that edits the personal information
    id destinationVC = segue.destinationViewController;
    
    if ([destinationVC isKindOfClass:[EditProfileViewController class]] ) {
        
        EditProfileViewController *editVC = destinationVC;
        
        editVC.cell = sender;
    }
    
}


#pragma mark actionsheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    //image picker
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    
    //set up delegate
    imagePicker.delegate = self;
    
    //allows picture editing
    imagePicker.allowsEditing = YES;
    
    if (buttonIndex == 0) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
    }
    
    if (buttonIndex == 1) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    }else{
        
        return;
        
        
    }
    
    //show the iamge picker
    
    [self presentViewController:imagePicker animated:YES completion:nil];
    
    
}

#pragma mark imagePickerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    //get image
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    self.headView.image = image;
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 100);
    
    [defaults setObject:imageData forKey:@"headview"];
    
    
    [defaults synchronize];
    
    
    
    //dismiss view controller
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
