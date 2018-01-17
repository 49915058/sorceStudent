//
//  NodeListViewController.m
//  NoteApp
//
//  Created by iiiedu2 on 2015/6/4.
//  Copyright (c) 2015年 Rossi. All rights reserved.
//

#import "NoteListViewController.h"
#import "Note.h"
#import "NoteCell.h"
#import "NoteViewController.h"

@interface NoteListViewController () <UITableViewDataSource,UITableViewDelegate,NoteViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray *notes;
@end

@implementation NoteListViewController
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
		
		self.notes = [NSMutableArray array];
		for(int i = 0; i < 10; i++){
			Note *note = [[Note alloc] init];
			note.text = [NSString stringWithFormat:@"Note %d",i];
			[self.notes addObject:note];
		}
		
		self.navigationItem.title = @"List1";
    }
    return self;
}

- (void)dealloc{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.tableView.dataSource = self;
	self.tableView.delegate = self;
	
	self.tableView.estimatedRowHeight = 44;
	self.tableView.rowHeight = UITableViewAutomaticDimension;
	
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
	[super setEditing: editing animated:animated];
	[self.tableView setEditing:editing animated:YES];
}

- (IBAction)addNote:(id)sender {
	Note *note = [[Note alloc] init];
	note.text = @"New Note";
	[self.notes addObject:note];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.notes.count-1 inSection:0];
	[self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (IBAction)edit:(id)sender {
	[self.tableView setEditing:!self.tableView.editing animated:YES];
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
	//NSLog(@"%lu",sourceIndexPath.row);
	Note *note = self.notes[sourceIndexPath.row];
	[self.notes removeObject:note];
	[self.notes insertObject:note atIndex:destinationIndexPath.row];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
	if(editingStyle == UITableViewCellEditingStyleDelete){
        [self.notes removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return self.notes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.showsReorderControl = YES;
	Note *note = self.notes[indexPath.row];
	cell.textLabel.text = note.text;
	cell.imageView.image = note.thumbnailImage;
	return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if([segue.identifier isEqualToString:@"note"]){
		NoteViewController *noteViewController = segue.destinationViewController;
		NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
		Note *note = self.notes[indexPath.row];
		noteViewController.note = note;
		noteViewController.delegate = self;
	}
}

- (void)didFinishUpdateNote:(Note *)note{
	//index
	NSUInteger index = [self.notes indexOfObject:note];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
	
	//reload
	[self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
	//[self saveToFile];
}
@end
