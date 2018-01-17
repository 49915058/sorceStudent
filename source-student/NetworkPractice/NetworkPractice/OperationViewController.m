//
//  OperationViewController.m
//  NetworkDemo
//
//  Created by Vincent on 01/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "OperationViewController.h"
#import "ImageOperation.h"
@interface OperationViewController ()
@property (nonatomic) NSOperationQueue *queue;

@end

@implementation OperationViewController

@synthesize profiles;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        self.queue =[[NSOperationQueue alloc]init ];
        [self.queue setMaxConcurrentOperationCount:3];
        self.profiles = @[
                          @{@"name":@"Apple Store",@"URL":@"https://graph.facebook.com/AppStore/picture?type=large"},
                          @{@"name":@"gaga",@"URL":@"https://graph.facebook.com/ladygaga/picture?type=large"},
                          @{@"name":@"CSIMiami",@"URL":@"https://graph.facebook.com/CSIMiami/picture?type=large"},
                          @{@"name":@"YahooTWNews",@"URL":@"https://graph.facebook.com/YahooTWNews/picture?type=large"},
                          @{@"name":@"kanpai.fans",@"URL":@"https://graph.facebook.com/kanpai.fans/picture?type=large"},
                          @{@"name":@"Apple Store",@"URL":@"https://graph.facebook.com/AppStore/picture?type=large"},
                          @{@"name":@"gaga",@"URL":@"https://graph.facebook.com/ladygaga/picture?type=large"},
                          @{@"name":@"CSIMiami",@"URL":@"https://graph.facebook.com/CSIMiami/picture?type=large"},
                          @{@"name":@"YahooTWNews",@"URL":@"https://graph.facebook.com/YahooTWNews/picture?type=large"},
                          @{@"name":@"kanpai.fans",@"URL":@"https://graph.facebook.com/kanpai.fans/picture?type=large"},
                          @{@"name":@"kanpai.fans",@"URL":@"https://graph.facebook.com/kanpai.fans/picture?type=large"},
                          @{@"name":@"Apple Store",@"URL":@"https://graph.facebook.com/AppStore/picture?type=large"},
                          @{@"name":@"gaga",@"URL":@"https://graph.facebook.com/ladygaga/picture?type=large"},
                          @{@"name":@"CSIMiami",@"URL":@"https://graph.facebook.com/CSIMiami/picture?type=large"},
                          @{@"name":@"YahooTWNews",@"URL":@"https://graph.facebook.com/YahooTWNews/picture?type=large"},
                          @{@"name":@"kanpai.fans",@"URL":@"https://graph.facebook.com/kanpai.fans/picture?type=large"},
                          @{@"name":@"Apple Store",@"URL":@"https://graph.facebook.com/AppStore/picture?type=large"},
                          @{@"name":@"gaga",@"URL":@"https://graph.facebook.com/ladygaga/picture?type=large"},
                          @{@"name":@"CSIMiami",@"URL":@"https://graph.facebook.com/CSIMiami/picture?type=large"},
                          @{@"name":@"YahooTWNews",@"URL":@"https://graph.facebook.com/YahooTWNews/picture?type=large"},
                          @{@"name":@"kanpai.fans",@"URL":@"https://graph.facebook.com/kanpai.fans/picture?type=large"},
                          @{@"name":@"Apple Store",@"URL":@"https://graph.facebook.com/AppStore/picture?type=large"},
                          @{@"name":@"gaga",@"URL":@"https://graph.facebook.com/ladygaga/picture?type=large"},
                          @{@"name":@"CSIMiami",@"URL":@"https://graph.facebook.com/CSIMiami/picture?type=large"},
                          @{@"name":@"YahooTWNews",@"URL":@"https://graph.facebook.com/YahooTWNews/picture?type=large"},
                          @{@"name":@"kanpai.fans",@"URL":@"https://graph.facebook.com/kanpai.fans/picture?type=large"},
                          @{@"name":@"kanpai.fans",@"URL":@"https://graph.facebook.com/kanpai.fans/picture?type=large"},
                          @{@"name":@"Apple Store",@"URL":@"https://graph.facebook.com/AppStore/picture?type=large"},
                          @{@"name":@"gaga",@"URL":@"https://graph.facebook.com/ladygaga/picture?type=large"},
                          @{@"name":@"CSIMiami",@"URL":@"https://graph.facebook.com/CSIMiami/picture?type=large"},
                          @{@"name":@"YahooTWNews",@"URL":@"https://graph.facebook.com/YahooTWNews/picture?type=large"},
                          @{@"name":@"kanpai.fans",@"URL":@"https://graph.facebook.com/kanpai.fans/picture?type=large"},
                          @{@"name":@"Apple Store",@"URL":@"https://graph.facebook.com/AppStore/picture?type=large"},
                          @{@"name":@"gaga",@"URL":@"https://graph.facebook.com/ladygaga/picture?type=large"},
                          @{@"name":@"CSIMiami",@"URL":@"https://graph.facebook.com/CSIMiami/picture?type=large"},
                          @{@"name":@"YahooTWNews",@"URL":@"https://graph.facebook.com/YahooTWNews/picture?type=large"},
                          @{@"name":@"kanpai.fans",@"URL":@"https://graph.facebook.com/kanpai.fans/picture?type=large"},
                          @{@"name":@"Apple Store",@"URL":@"https://graph.facebook.com/AppStore/picture?type=large"},
                          @{@"name":@"gaga",@"URL":@"https://graph.facebook.com/ladygaga/picture?type=large"},
                          @{@"name":@"CSIMiami",@"URL":@"https://graph.facebook.com/CSIMiami/picture?type=large"},
                          @{@"name":@"YahooTWNews",@"URL":@"https://graph.facebook.com/YahooTWNews/picture?type=large"},
                          @{@"name":@"kanpai.fans",@"URL":@"https://graph.facebook.com/kanpai.fans/picture?type=large"},
                          @{@"name":@"kanpai.fans",@"URL":@"https://graph.facebook.com/kanpai.fans/picture?type=large"},
                          @{@"name":@"Apple Store",@"URL":@"https://graph.facebook.com/AppStore/picture?type=large"},
                          @{@"name":@"gaga",@"URL":@"https://graph.facebook.com/ladygaga/picture?type=large"},
                          @{@"name":@"CSIMiami",@"URL":@"https://graph.facebook.com/CSIMiami/picture?type=large"},
                          @{@"name":@"YahooTWNews",@"URL":@"https://graph.facebook.com/YahooTWNews/picture?type=large"},
                          @{@"name":@"kanpai.fans",@"URL":@"https://graph.facebook.com/kanpai.fans/picture?type=large"},
                          @{@"name":@"Apple Store",@"URL":@"https://graph.facebook.com/AppStore/picture?type=large"},
                          @{@"name":@"gaga",@"URL":@"https://graph.facebook.com/ladygaga/picture?type=large"},
                          @{@"name":@"CSIMiami",@"URL":@"https://graph.facebook.com/CSIMiami/picture?type=large"},
                          @{@"name":@"YahooTWNews",@"URL":@"https://graph.facebook.com/YahooTWNews/picture?type=large"},
                          @{@"name":@"kanpai.fans",@"URL":@"https://graph.facebook.com/kanpai.fans/picture?type=large"},
                          @{@"name":@"Apple Store",@"URL":@"https://graph.facebook.com/AppStore/picture?type=large"},
                          @{@"name":@"gaga",@"URL":@"https://graph.facebook.com/ladygaga/picture?type=large"},
                          @{@"name":@"CSIMiami",@"URL":@"https://graph.facebook.com/CSIMiami/picture?type=large"},
                          @{@"name":@"YahooTWNews",@"URL":@"https://graph.facebook.com/YahooTWNews/picture?type=large"},
                          @{@"name":@"kanpai.fans",@"URL":@"https://graph.facebook.com/kanpai.fans/picture?type=large"},
                          @{@"name":@"kanpai.fans",@"URL":@"https://graph.facebook.com/kanpai.fans/picture?type=large"},
                          @{@"name":@"Apple Store",@"URL":@"https://graph.facebook.com/AppStore/picture?type=large"},
                          @{@"name":@"gaga",@"URL":@"https://graph.facebook.com/ladygaga/picture?type=large"},
                          @{@"name":@"CSIMiami",@"URL":@"https://graph.facebook.com/CSIMiami/picture?type=large"},
                          @{@"name":@"YahooTWNews",@"URL":@"https://graph.facebook.com/YahooTWNews/picture?type=large"},
                          @{@"name":@"kanpai.fans",@"URL":@"https://graph.facebook.com/kanpai.fans/picture?type=large"},
                          ];
        self.title = @"operation";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Reload" style:UIBarButtonItemStylePlain target:self action:@selector(reload:)];
    // Do any additional setup after loading the view from its nib.
}

- (void)reload:(id)sender {

    [self.tableView reloadData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.profiles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString static *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if ( !cell ){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    //清掉image防止requse時，用到上次的圖片
    cell.imageView.image=nil;
    
    NSDictionary *profile = [self.profiles objectAtIndex:indexPath.row];
    cell.textLabel.text = [profile objectForKey:@"name"];
    NSURL *imageUrl = [NSURL URLWithString:[profile objectForKey:@"URL"]];
    
    
    ImageOperation *operation = [[ImageOperation alloc]init];
    operation.imageURL =imageUrl;
    operation.tbaleView = tableView;
    operation.indexPath = indexPath;
    [self.queue addOperation:operation];
    
    
    
   /*
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:imageUrl];
       
        dispatch_async(dispatch_get_main_queue(), ^{
            //利用之前的外置，札巡看看該位置是否在畫面上，如果不在畫面上
            //回傳的cell會空直
            UITableViewCell *cell1=[tableView cellForRowAtIndexPath:indexPath];
            
            if (cell1) {
                
                cell1.imageView.image = [UIImage imageWithData:data];
                [cell1 setNeedsLayout];//重新排版
                
            }
        } );
    });
*/
    
  
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *opreations = self.queue.operations;
    for (NSOperation *operation in opreations) {
        ImageOperation *imageOperation = (ImageOperation*)operation;
        if ([indexPath compare:imageOperation.indexPath] == NSOrderedSame ) {
            [imageOperation cancel];
        }
        
    }
    
}


@end
