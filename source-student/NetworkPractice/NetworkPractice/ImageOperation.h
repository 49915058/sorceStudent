//
//  ImageOperation.h
//  NetworkPractice
//
//  Created by user38 on 2018/1/16.
//  Copyright © 2018年 iiiedu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageOperation : NSOperation
@property(nonatomic) NSURL *imageURL;
@property(nonatomic) UITableView *tbaleView;
@property(nonatomic) NSIndexPath *indexPath;
@end
