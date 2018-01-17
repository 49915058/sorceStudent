//
//  ViewController.m
//  HTMLParser
//
//  Created by Vincent on 13/1/17.
//  Copyright (c) 2013年 iCreativo. All rights reserved.
//

#import "ViewController.h"
#import "TFHpple.h"

@interface ViewController ()

@end

@implementation ViewController
#define kXPath @"xpath"
#define kURL @"webURL"


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataDict = [NSMutableDictionary dictionary];
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    if ( [userdefault objectForKey:kXPath]){
        self.patternTextField.text = [userdefault objectForKey:kXPath];
    }
    if ( [userdefault objectForKey:kURL]){
        self.urlTextField.text = [userdefault objectForKey:kURL];
    }
    self.title = @"XPath";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Parse" style:UIBarButtonItemStyleDone target:self action:@selector(doParse:)];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeKeyboard)];
    tap.numberOfTapsRequired = 1;
    [self.tableView addGestureRecognizer:tap];
}

-(void)closeKeyboard{
    if ([self.urlTextField isFirstResponder]){
        [self.urlTextField resignFirstResponder];
    }
    if ( [self.patternTextField isFirstResponder]){
        [self.patternTextField resignFirstResponder];
    }
    if ( [self.paramTextField isFirstResponder]){
        [self.paramTextField resignFirstResponder];
    }
    if ( [self.textView isFirstResponder]){
        [self.textView resignFirstResponder];
    }
}



-(IBAction)doParse:(id)sender{
    self.textView.text = @"Parsing..";
    [self.urlTextField resignFirstResponder];
    [self.patternTextField resignFirstResponder];
    NSString *text = self.urlTextField.text;
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    [userdefault setObject:self.patternTextField.text forKey:kXPath];
    [userdefault setObject:text forKey:kURL];
    NSData *data = nil;
    if ( [self.dataDict objectForKey:text]){
        data = [self.dataDict objectForKey:text];
        [self parseWithData:data];
    }else{
        
        NSURL *url = [NSURL URLWithString:text];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        if ( self.methodSwitch.on){
            request.HTTPMethod = @"POST";
            NSString *params = self.paramTextField.text;
            request.HTTPBody = [params dataUsingEncoding:NSUTF8StringEncoding];
        }
        
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            [self.dataDict setObject:data forKey:[url absoluteString]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self parseWithData:data];
            });
        }];
        [task resume];
    }
}


-(void)parseWithData:(NSData*)data{
    TFHpple *parser = [[TFHpple alloc]initWithHTMLData:data];
    NSMutableString *result = [NSMutableString string];
    NSArray *tds = [parser searchWithXPathQuery:self.patternTextField.text];
    if ( tds.count > 0 ){
        TFHppleElement *element = [tds objectAtIndex:0];
        [result appendFormat:@"總共找到有%lu個<%@>\n",(unsigned long)tds.count,element.tagName];
        [result appendFormat:@"---------------------\n"];
    }else{
        [result appendFormat:@"無任可節點"];
    }
    
    [tds enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        TFHppleElement *element = obj;
        //TFHppleElement *textElement  = [element firstTextChild];
        //TFHppleElement *textElement = [element.children objectAtIndex:3];
        if ( element.content.length > 0 ){
            [result appendFormat:@"第%lu個 <%@>= %@\n",idx+1,element.tagName,element.content];
        }else{
            NSString *attributeStr = @"";
            if ( element.attributes.count > 0 ){
                attributeStr = [NSString stringWithFormat:@"有attributes %@\n",element.attributes];
            }
            [result appendFormat:@"第%lu個 <%@> %@有%lu個child\n",idx+1,element.tagName,attributeStr,(unsigned long)element.children.count];
            NSArray *childs = element.children;
            [childs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx1, BOOL *stop) {
                TFHppleElement *child = obj;
                if ( child.isTextNode && [child.content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0){
                    [result appendFormat:@"child%lu: 是文字:%@\n",idx1+1,child.content];
                }else{
                    [result appendFormat:@"child%lu: <%@>\n",idx1+1,child.tagName];
                }
            }];
        }
        [result appendFormat:@"---------------------\n"];
    }];
    
    self.textView.text = result;

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
