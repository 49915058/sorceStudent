//
//  NoteViewController.h
//  NoteApp
//
//  Created by iiiedu2 on 2015/6/5.
//  Copyright (c) 2015年 Rossi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

@protocol NoteViewControllerDelegate <NSObject>
@optional
- (void)didFinishUpdateNote:(Note *)note;
@end

@interface NoteViewController : UIViewController
@property (nonatomic) Note *note;
//用delegate時property要加上weak
@property (nonatomic,weak) id<NoteViewControllerDelegate> delegate;
@end
