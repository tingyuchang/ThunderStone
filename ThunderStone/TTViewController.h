//
//  TTViewController.h
//  ThunderStone
//
//  Created by TingYu Chang on 13/5/14.
//  Copyright (c) 2013年 TingYu Chang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>{
    NSArray *heros; // 4
    NSArray *villagersAndWeapons; // 8
    NSArray *monsters; //3
    
    UITableView *resultTableView;
    
    UIView *backgroundView;
}

@end
