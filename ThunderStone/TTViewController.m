//
//  TTViewController.m
//  ThunderStone
//
//  Created by TingYu Chang on 13/5/14.
//  Copyright (c) 2013年 TingYu Chang. All rights reserved.
//

#import "TTViewController.h"

@interface TTViewController ()

@end

@implementation TTViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set array value
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Thunder Stone" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    heros = [[NSArray alloc] initWithArray:[self shuffle:[dict objectForKey:@"Heros"]]];
    villagersAndWeapons = [[NSArray alloc] initWithArray:[self shuffle:[dict objectForKey:@"Villagers_and_Weapons"]]];
    monsters = [[NSArray alloc] initWithArray:[self shuffle:[dict objectForKey:@"Monsters"]]];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    resultTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, screenBounds.size.height-20)];
    [resultTableView setDataSource:self];
    [resultTableView setDelegate:self];
    [self.view addSubview:resultTableView];
    
    UIButton *randomButton = [UIButton buttonWithType:110];
    [randomButton setFrame:CGRectMake(240, 5, 75, 30)];
    [randomButton setTitle:@"Random" forState:UIControlStateNormal];
    [randomButton addTarget:self action:@selector(random) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:randomButton];
}

- (void)random{
    heros = [[NSArray alloc] initWithArray:[self shuffle:heros]];
    villagersAndWeapons = [[NSArray alloc] initWithArray:[self shuffle:villagersAndWeapons]];
    monsters = [[NSArray alloc] initWithArray:[self shuffle:monsters]];
    [resultTableView reloadData];
}

-(NSMutableArray *)shuffle:(NSArray *)array{
    NSMutableArray *randomArray = [[NSMutableArray alloc] initWithArray:array];
    NSUInteger count = [array count];
    for (NSUInteger i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        NSInteger nElements = count - i;
        NSInteger n = (arc4random() % nElements) + i;
        [randomArray exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    
    return randomArray;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tapToDisappear{
    [backgroundView removeFromSuperview];
}


#pragma mark UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int rowNUm = 0;
    
    switch (section) {
        case 0:
            rowNUm = 4;
            break;
        case 1:
            rowNUm = 8;
            break;
        case 2:
            rowNUm = 3;
            break;
        default:
            break;
    }
    return rowNUm;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentify = @"MyCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
    }
    
    switch ([indexPath section]) {
        case 0:
            [cell.textLabel setText:[heros objectAtIndex:[indexPath row]]];
            break;
        case 1:
            [cell.textLabel setText:[villagersAndWeapons objectAtIndex:[indexPath row]]];

            break;
        case 2:
            [cell.textLabel setText:[monsters objectAtIndex:[indexPath row]]];

            break;
        default:
            break;
    }
    
    
    return cell;

}

#pragma mark UITabeleView Delegete


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, screenBounds.size.height)];
    [self.view addSubview:backgroundView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToDisappear)];
    [backgroundView addGestureRecognizer:tap];
    

    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, screenBounds.size.height)];
    [maskView setBackgroundColor:[UIColor blackColor]];
    [maskView setAlpha:0.5];
    [backgroundView addSubview:maskView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 250, 360)];
    [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", cell.textLabel.text]]];
    [imageView setCenter:CGPointMake(160, screenBounds.size.height/2-10)];
    if (imageView.image) {
        [backgroundView addSubview:imageView];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"oh" message:@"No Image" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }


    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    [headerView setBackgroundColor:[UIColor orangeColor]];
    NSString *HearderTitle;
    switch (section) {
        case 0:
            HearderTitle = @"Heros";
            break;
        case 1:
            HearderTitle = @"Villagers And Weapons";
            break;
        case 2:
            HearderTitle = @"Monsters";
            break;
        default:
            break;
    }
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    [headerLabel setText:HearderTitle];
    [headerLabel setTextColor:[UIColor whiteColor]];
    [headerLabel setBackgroundColor:[UIColor clearColor]];
    [headerLabel setTextAlignment:NSTextAlignmentCenter];
    [headerLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [headerView addSubview:headerLabel];
    
    return headerView;
}
// - (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{}




#pragma mark UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self tapToDisappear];
}
@end
