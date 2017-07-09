//
//  MainViewController.m
//  SoundNote
//
//  Created by yujiaqi on 4/25/17.
//  Copyright © 2017 yujiaqi. All rights reserved.
//


#import "MainViewController.h"
#import "AddNoteViewController.h"
#import "DetailViewController.h"
#import "UIColor+Hash.h"
#import "ChangeColorViewController.h"

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate,UISearchControllerDelegate>

@property NSMutableArray *filteredNoteArray;//filter note array
@property UISearchBar *bar;//search bar
@property UISearchDisplayController *searchCtrl;// search control
@property (nonatomic,strong)NSMutableArray *dateTemp;
@property (nonatomic,strong)NSMutableArray *noteTemp;
@property (nonatomic,strong)NSMutableArray *countDateTemp;
@property (nonatomic,copy) NSString *color;
//@property (nonatomic, assign) NSInteger RedInt;
//@property (nonatomic, assign) NSInteger GreenInt;
//@property (nonatomic, assign) NSInteger BlueInt;

@end

@implementation MainViewController

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
   //single data save
    self.noteArray  = [[NSUserDefaults standardUserDefaults] objectForKey:@"note"];
    
    self.noteTemp = [NSMutableArray arrayWithArray:self.noteArray];

    self.dateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
    
    self.dateTemp = [NSMutableArray arrayWithArray:self.dateArray];
 
    self.countDateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"countdate"];
    
    self.countDateTemp = [NSMutableArray arrayWithArray:self.countDateArray];
    
    [self.tableView reloadData];
    
    
    //save the theme color
    self.color = [[NSUserDefaults standardUserDefaults] objectForKey:@"color"];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorFromHexString:_color]];

    [self.tabBarController.tabBar setBarTintColor:[UIColor colorFromHexString:_color]];
    
    
    //get wall paper
    
    NSData *imageData = [[NSUserDefaults standardUserDefaults] dataForKey:@"wall"];
    
    UIImage *image = [UIImage imageWithData:imageData];
    
    
    UIImageView *iamge = [[UIImageView alloc]initWithImage:image];
    
    [self.tableView setBackgroundView:iamge];
    
    //custom color
//    if(self.RedInt!=255.0 && self.BlueInt!=255.0 && self.GreenInt!=255.0){
//        [self. navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:self.RedInt/255.0
//                                                                   
//                                                                                  green:self.GreenInt/255.0
//                                                                                   blue:self.BlueInt/255.0
//                                                                                  alpha:0.5]];
//        [self. tabBarController.tabBar setBarTintColor:[UIColor colorWithRed:self.RedInt/255.0
//                                                                   
//                                                                                  green:self.GreenInt/255.0
//                                                                                   blue:self.BlueInt/255.0
//                                                                                  alpha:0.5]];
//    
//    }
    

}


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.RedInt=255.0;
//    self.BlueInt=255.0;
//    self.GreenInt=255.0;
   
    NSLog(@"%@",_color);
    if (!self.color) {
        [self.navigationController.navigationBar setBarTintColor:[UIColor colorFromHexString:@"#007fcc"]];
        [self.tabBarController.tabBar setBarTintColor:[UIColor colorFromHexString:@"#007fcc"]];
    }
    
    //initilize the search bar
    _bar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 44)];
    
      
    [_bar sizeToFit];
    
    _bar.placeholder = @"Search";
    
    _searchCtrl = [[UISearchDisplayController alloc]initWithSearchBar:_bar contentsController:self];

    _searchCtrl.delegate = self;
    
    _searchCtrl.searchResultsDataSource = self;
    
    _searchCtrl.searchResultsDelegate = self;
    
    self.tableView.tableHeaderView = _bar;
    
        
    //set the navigation bar color to white
    [self navigationController].navigationBar.tintColor = [UIColor whiteColor];

    self.hidesBottomBarWhenPushed = NO;
    
    //set up review tab background color
    
   
    UIImageView *iamge = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"背景1.jpg"]];
    
    [self.tableView setBackgroundView:iamge];
    
    [self.tabBarController.tabBar setTintColor:[UIColor whiteColor]];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    if(tableView == self.searchDisplayController.searchResultsTableView) {
        
        return [_filteredNoteArray count];
        
    }else {
        
        return [self.noteTemp count];
        
    }

}


//table view: cell at row index
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSString *note = nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        note = [_filteredNoteArray objectAtIndex:indexPath.row];
        
    }else if (tableView == self.tableView){
        
        note = [self.noteArray objectAtIndex:indexPath.row];
        
    };
    
    NSString *date = [_dateArray objectAtIndex:indexPath.row];
    
    NSUInteger charnum = [note length];
    
    if (charnum <22) {
        
        cell.textLabel.text = note;
    
    }else{
        
        cell.textLabel.text = [[note substringToIndex:18] stringByAppendingString:@"..."];
        
    }
    cell.detailTextLabel.text = date;
    
    cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
    
 
    cell.backgroundColor = [UIColor clearColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
    
}

//select a row
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

   DetailViewController *detail = [[DetailViewController alloc]initWithNibName:nil bundle:nil];
    
    NSInteger row = [indexPath row];
    
    detail.index = row;
    
    [self.navigationController pushViewController:detail animated:YES];

    
}



-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
 
        
        [self.noteTemp removeObjectAtIndex:indexPath.row];
        [self.dateTemp removeObjectAtIndex:indexPath.row];
        [self.countDateTemp removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];

        [[NSUserDefaults standardUserDefaults] setObject:self.noteTemp forKey:@"note"];
        [[NSUserDefaults standardUserDefaults] setObject:self.dateTemp forKey:@"date"];
        [[NSUserDefaults standardUserDefaults] setObject:self.countDateTemp forKey:@"countdate"];
        
        [self.tableView reloadData];
    }
    
    
}



#pragma mark UISearchDisplayDelegate

//search and filter
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString

{
    [_filteredNoteArray removeAllObjects];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@",searchString];
    
    NSArray *tempArray = [_noteArray filteredArrayUsingPredicate:predicate];
    
    _filteredNoteArray = [NSMutableArray arrayWithArray:tempArray];
    
    return YES;
    
}



- (NSMutableArray *)noteArray {
    if (_noteArray == nil) {
        _noteArray = [NSMutableArray array];
        
    }
    return _noteArray;
}

- (NSMutableArray *)dateArray {
    if (_dateArray == nil) {
        _dateArray = [NSMutableArray array];
      
    }
    return _dateArray;
}

//-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    ChangeColorViewController *changeVC = segue.destinationViewController;
//    changeVC.RedInt = self.RedInt;
//    changeVC.GreenInt=self.GreenInt;
//    changeVC.BlueInt=self.BlueInt;
//}

@end
