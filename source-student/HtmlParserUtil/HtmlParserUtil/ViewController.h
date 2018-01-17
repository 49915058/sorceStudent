//
//  ViewController.h
//  HTMLParser
//
//  Created by Vincent on 13/1/17.
//  Copyright (c) 2013年 iCreativo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *patternTextField;
@property (weak, nonatomic) IBOutlet UISwitch *methodSwitch;
@property (weak, nonatomic) IBOutlet UITextField *paramTextField;

@property(nonatomic) NSMutableDictionary *dataDict;
@property(nonatomic)NSMutableData *responseData;
@end
