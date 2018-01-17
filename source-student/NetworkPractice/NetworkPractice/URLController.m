//
//  URLController.m
//  NetworkDemo
//
//  Created by Vincent on 12/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "URLController.h"

@interface URLController ()

@end

@implementation URLController

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.title = @"NSURL";

    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Connect" style:UIBarButtonItemStylePlain target:self action:@selector(connection:)];
    //initialize your NSURL, NSURLRequest and NSURLConnection
    
    
    
    NSMutableDictionary * dict=[[NSMutableDictionary alloc] init];
    dict[@"className"]= @"ios網路應用課程";
    dict[@"hours"]=[NSNull null ];
    
    dict[@"strted"]=[NSNumber numberWithBool:YES];
    
    NSMutableDictionary *Address= [[NSMutableDictionary alloc] init];
    Address[@"address"] = @"復興南路一段390號";
    Address[@"city"] = @"台北市";
    Address[@"postalcode"] = @"100";
    
    
    dict[@"address"]= Address;
    
    dict[@"phonNumber"]=@[@{@"type":@"office",@"number":@"02-6631-6599"},
                          @{@"type":@"home",@"number":@"02-1111-2222"}];
    
    
    NSData *data =[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *json=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"jsin = %@",json);

    
    ///
    
    
}

- (IBAction)connection:(id)sender {

    //google geocode URL: https://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=false
    //facebook profile image URL: https://graph.facebook.com/AppStore/picture?type=large
    //command: /usr/bin/nscurl --ats-diagnostics --verbose https://graph.facebook.com/AppStore/picture?type=large
    
  //  NSURL *url = [NSURL URLWithString:@"https://graph.facebook.com/AppStore/picture?type=large"];
    
   
    
   /* dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        //下載圖片變成NSData
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //轉成UIImage
            UIImage *image = [UIImage imageWithData:imageData];
            UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
            [self.view addSubview:imageView];
            
        } );
    });
    */
    
    /*
    NSString *chinese = @"台北市復興南路一段390號";
    chinese = [chinese stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSString *address = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=false",chinese];
    
    
    NSURL *url = [NSURL URLWithString:address];
    
    NSString *geoString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    
    NSData *geoData =[NSData dataWithContentsOfURL:url];
    NSDictionary *info=[ NSJSONSerialization JSONObjectWithData:geoData options:0 error:nil];
    
    NSArray *results = info [@"results"];
    NSDictionary *firstResulr= results[0];
    NSDictionary * geometry =firstResulr[@"geometry"];
    NSDictionary * location =geometry[@"location"];
    //去出lat,lng組成座標
    NSString *geocode=[NSString stringWithFormat:@"%@,%@",location[@"lat"],location[@"lng"] ];
    
    
    
    UITextView *textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    
    textView.text = geocode;
    //textView.text = geoString;
    [self.view addSubview:textView];*/
    
    NSURL *url =[NSURL URLWithString:@"https://graph.facebook.com/AppStore/picture?type=large"];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //產生session物件
    NSURLSession * session =[NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];
    
    //利用dataTaskWithRequest產生dataTakes
    NSURLSessionDataTask *task =[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error%@",error);
        }
        //gcd
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:data];
            UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
            [self.view addSubview:imageView];
            
        } );
    }];
    
    [task resume ];
    
    
    
    
    
    
    
    
                

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)encodeString:(NSString *)string
{
    //This is the encode function when stringByAddingPercentEscape not working
    NSString *result = (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                             (__bridge CFStringRef)string,
                                                                                             NULL,
                                                                                             (CFStringRef)@"!;/?:@&=$+{}<>,()'*",
                                                                                             kCFStringEncodingUTF8);
    return result;
}

#pragma mark NSURLSessionDataDelegate
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    
}
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    
}
@end
