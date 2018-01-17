//
//  NoteViewController.m
//  NoteApp
//
//  Created by iiiedu2 on 2015/6/5.
//  Copyright (c) 2015年 Rossi. All rights reserved.
//

#import "NoteViewController.h"

@interface NoteViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (nonatomic) BOOL isNewImage;
@property (nonatomic) NSLayoutConstraint *imageRatioConstraint;
@end

@implementation NoteViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.textView.text = self.note.text;
	self.imageView.image = self.note.image;
	//邊框
	self.imageView.layer.borderWidth = 10;
	self.imageView.layer.borderColor = [UIColor grayColor].CGColor;
	//圓角
	self.imageView.layer.cornerRadius = 10;
	self.imageView.clipsToBounds = YES;//等於self.imageView.layer.masksToBounds
    
	//手動設定Constraint
    self.imageRatioConstraint = [self.imageView.heightAnchor constraintEqualToAnchor:self.imageView.widthAnchor multiplier:0.75];
    self.imageRatioConstraint.active = YES;
    
}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
	[super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
	if(newCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact){
		//橫向，拿掉4:3條件
        self.imageRatioConstraint.active = NO;
		
	}else{
		//直向
        self.imageRatioConstraint.active = YES;
	}
    [self.toolbar invalidateIntrinsicContentSize];
}

- (IBAction)camera:(id)sender {
	UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
	pickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
	pickerController.delegate = self;
	[self presentViewController:pickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
	UIImage *image = info[UIImagePickerControllerOriginalImage];
	self.imageView.image = image;
	self.isNewImage = YES;
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)done:(id)sender {
	self.note.text = self.textView.text;
	//self.note.image = self.imageView.image;
	
	//save file
	if(self.isNewImage){
		self.note.imageName = [self.note.noteID stringByAppendingString:@".jpg"];
		NSString *documentPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
		NSString *imagePath = [documentPath stringByAppendingPathComponent:self.note.imageName];
		NSLog(@"document %@",documentPath);
		NSData *imageData = UIImageJPEGRepresentation(self.imageView.image, 1);
		[imageData writeToFile:imagePath atomically:YES];
    }
	
	//image
	
	//程式去偵測是否有該方法
	if([self.delegate respondsToSelector:@selector(didFinishUpdateNote:)]){
		[self.delegate didFinishUpdateNote:self.note];
	}
	
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
