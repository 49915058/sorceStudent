//
//  ProfileViewController.h
//  NetworkDemo
//
//  Created by Vincent on 01/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>


@interface ProfileViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *profiles;
    NSMutableDictionary *imageDictionary;
    BOOL async;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSArray *profiles;
@property (nonatomic,strong)NSMutableDictionary *imageDictionary;
@end
