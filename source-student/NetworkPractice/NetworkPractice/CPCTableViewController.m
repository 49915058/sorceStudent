//
//  CPCTableViewController.m
//  NetworkPractice
//
//  Created by user38 on 2018/1/16.
//  Copyright © 2018年 iiiedu. All rights reserved.
//

#import "CPCTableViewController.h"
#import "GDataXMLNode.h"
@interface CPCTableViewController ()
@property(nonatomic)GDataXMLDocument *doc;
@property(nonatomic)NSArray<GDataXMLElement*>*stations;//data

@end

@implementation CPCTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.refreshControl =[[UIRefreshControl alloc]init ];
    //使用者下拉tableView,呼叫query
    [self.refreshControl addTarget:self action:@selector(query:) forControlEvents:UIControlEventValueChanged];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (IBAction)query:(id)sender {
    
    
    NSURL *url=[NSURL URLWithString:@"https://quality.data.gov.tw/dq_download_xml.php?nid=6065&md5_url=911fbd1ed38fd9e30cfea580ee3ed795"];
   
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data=[NSData dataWithContentsOfURL:url];
        GDataXMLDocument *doc =[[GDataXMLDocument alloc]initWithData:data options:0 error:nil];
        self.doc = doc; //沒有放在@property上會有問題
        
        GDataXMLElement *root = doc.rootElement; //<table>
        NSArray *rows=[root elementsForName:@"row"];
        self.stations =rows;
        GDataXMLElement *row0 = rows[0];
        
        GDataXMLElement *name = [row0 elementsForName:@"Col1"][0];
        NSLog(@"代號 = %@",name.stringValue);
        
        
        /*
        GDataXMLNode *node = [root attributeForName:@"status"];
        NSLog(@"status= %@",node.stringValue);
        
        
        NSArray *nodes=[root elementsForName:@"mediaid"];
        GDataXMLElement *idElement=nodes[0];
        NSLog(@"mediaid =%@ ",idElement.stringValue);
         */
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
        } );
    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    
    return self.stations.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    GDataXMLElement *row0=self.stations[indexPath.row];
    GDataXMLElement *name =[row0 elementsForName:@"Col3"][0];
    cell.textLabel.text=name.stringValue;
    
    GDataXMLElement *tel= [row0 elementsForName:@"Col7"][0];
    cell.detailTextLabel.text=tel.stringValue;
    
   
   // GDataXMLElement *
    
    
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
