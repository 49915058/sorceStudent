//
//  OperationViewController.h
//  NetworkDemo
//
//  Created by Vincent on 01/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//



@interface OperationViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *profiles;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)NSArray *profiles;
@end
