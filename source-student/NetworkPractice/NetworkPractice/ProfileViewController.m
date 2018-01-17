//
//  ProfileViewController.m
//  NetworkDemo
//
//  Created by Vincent on 01/01/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

@synthesize profiles;

@synthesize imageDictionary;

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.profiles = @[];
        self.imageDictionary = [NSMutableDictionary dictionary];
        self.title = @"sync";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *sync = [[UIBarButtonItem alloc] initWithTitle:@"sync" style:UIBarButtonItemStylePlain target:self action:@selector(sync:)];
    UIBarButtonItem *asyncItem = [[UIBarButtonItem alloc] initWithTitle:@"async" style:UIBarButtonItemStylePlain target:self action:@selector(async:)];
    self.navigationItem.rightBarButtonItems = @[sync,asyncItem];
    // Do any additional setup after loading the view from its nib.
}

-(void)loadProfileData{
    self.profiles = @[@{@"name":@"Apple Store",@"URL":@"https://graph.facebook.com/AppStore/picture?type=square"},
    @{@"name":@"gaga",@"URL":@"https://graph.facebook.com/ladygaga/picture?type=square"},
    @{@"name":@"CSIMiami",@"URL":@"https://graph.facebook.com/CSIMiami/picture?type=square"},
    @{@"name":@"YahooTWNews",@"URL":@"https://graph.facebook.com/YahooTWNews/picture?type=square"},
    @{@"name":@"kanpai.fans",@"URL":@"https://graph.facebook.com/kanpai.fans/picture?type=square"},
                      
    ];
}

- (void)async:(id)sender {
    [self loadProfileData];
    async = YES;
    self.title = @"async";
    [self.imageDictionary removeAllObjects];
    [self.tableView reloadData];
}

- (void)sync:(id)sender {
    [self loadProfileData];
    async = NO;
    self.title = @"sync";
    NSArray *cells = [self.tableView visibleCells];
    [cells enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UITableViewCell *cell = obj;
        cell.textLabel.text = nil;
        cell.imageView.image = nil;
    }];
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
        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    cell.imageView.image =nil;
    NSDictionary *profile = [self.profiles objectAtIndex:indexPath.row];
    cell.textLabel.text = [profile objectForKey:@"name"];

    NSURL *imageUrl = [NSURL URLWithString:[profile objectForKey:@"URL"]];
    if ( async) {
        NSURLSessionTask *task =  [[NSURLSession sharedSession] dataTaskWithURL:imageUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if ( data) {
                UITableViewCell *cell1 = [tableView cellForRowAtIndexPath:indexPath];
                if ( cell1 ){
                    UIImage *image = [UIImage imageWithData:data];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        cell1.imageView.image = image;
                        [cell1 setNeedsLayout];
                    });
                }
            }
        }];
        [task resume];
    } else {
        NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
        cell.imageView.image = [UIImage imageWithData:imageData];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.imageView.layer.cornerRadius = 5.0;
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.borderWidth = 2;
    cell.imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

@end
