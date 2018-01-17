//
//  ImageOperation.m
//  NetworkPractice
//下載單一的圖片，更新回tableView cwll
//  Created by user38 on 2018/1/16.
//  Copyright © 2018年 iiiedu. All rights reserved.
//

#import "ImageOperation.h"

@implementation ImageOperation
-(void)main{
    
    if ([self isCancelled]) {
        return;
    }
    NSData *data = [NSData dataWithContentsOfURL:self.imageURL];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //利用之前的外置，札巡看看該位置是否在畫面上，如果不在畫面上
        //回傳的cell會空直
        UITableViewCell *cell1=[self.tbaleView cellForRowAtIndexPath:self.indexPath];
        
        if (cell1) {
            
            cell1.imageView.image = [UIImage imageWithData:data];
            [cell1 setNeedsLayout];//重新排版
            
        }
    } );
}

@end
