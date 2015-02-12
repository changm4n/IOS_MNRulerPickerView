//
//  ViewController.h
//  MNRulerPickerView
//
//  Created by 이창민 on 2015. 2. 13..
//  Copyright (c) 2015년 MongTong. All rights reserved.
//

#import "MNRulerPickerView.h"
#define DEGREES_TO_RADIANS(x) (M_PI * (x) / 180.0)

@interface MNRulerPickerView() <UITableViewDataSource, UITableViewDelegate>

@end

@implementation MNRulerPickerView {
  UITableView *_tableView;
}

- (id)initWithFrame:(CGRect)frame {
  CGFloat x = frame.origin.x;
  CGFloat y = frame.origin.y;
  CGFloat w = frame.size.width;
  CGFloat h = frame.size.height;
  self = [super initWithFrame:CGRectMake(x+(w-h)/2, y+(h-w)/2, h, w)];
  if (self) {
    // Initialization code
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];

    _tableView.delegate = self;
    _tableView.dataSource = self;
    //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.allowsSelection = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    
    self.overlayCell = [[UIView alloc] init];
    self.overlayCell.backgroundColor = [UIColor redColor];
    self.overlayCell.userInteractionEnabled = NO;
    self.overlayCell.alpha = 0.5;
    
  }
  return self;
}

- (void)layoutSubviews {
  CGFloat rowHeight = [self.delegate rowHeightForMNRulerPickerView:self];
  
  // Move overlay to center of table view
  CGFloat centerY = (self.frame.size.width - rowHeight) / 2.0;
  self.overlayCell.frame = CGRectMake(0.0, centerY, self.frame.size.height, rowHeight);
  
  // Calculate height of table based on height of cell and height of frame
  // Figure out the number of cells that will fit on the table
  //NSInteger numCells = (NSInteger)(floor(self.frame.size.height / [self.delegate rowHeightForMNRulerPickerView:self]));


  
  [self addSubview:_tableView];
 [self addSubview:_overlayCell];
}

/*
- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
	// Always pass all touches on this view to the table view
	return _tableView;
}*/

- (void)selectRow:(NSInteger)row {
    CGFloat rowHeight = [self.delegate rowHeightForMNRulerPickerView:self];
    
	[_tableView setContentOffset:CGPointMake(0.0, row * rowHeight)];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _tableView.backgroundColor = backgroundColor;
}

#pragma mark - UITableViewDelegate functions

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.dataSource numberOfRowsInMNRulerPickerView:self];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	CGFloat rowHeight = [self.delegate rowHeightForMNRulerPickerView:self];
    
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		
	if (cell == nil) {
		// Alloc a new cell
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
			
		UIView *contentView = cell.contentView;
				
		UILabel *textLabel;
		if (indexPath.row == 0) {
			textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, self.overlayCell.frame.origin.y, self.frame.size.width, rowHeight)];
		} else {
			textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, rowHeight)];
		}
		textLabel.tag = -1;
		textLabel.text = [self.delegate djuPickerView:self titleForRow:indexPath.row];
      textLabel.backgroundColor = [UIColor clearColor];
      [self.delegate labelStyleForMNRulerPickerView:self forLabel:textLabel];

		[contentView addSubview:textLabel];
		
	}
  else {
		// Reuse cell
		UIView *contentView = cell.contentView;
				
		UILabel *textLabel = (UILabel*)[contentView viewWithTag:-1];
		textLabel.text = [self.delegate djuPickerView:self titleForRow:indexPath.row];
		
		if (indexPath.row == 0) {
			textLabel.frame = CGRectMake(0.0, self.overlayCell.frame.origin.y, self.frame.size.width, rowHeight);
		} else {
			textLabel.frame = CGRectMake(0.0, 0.0, self.frame.size.width, rowHeight);
		}
	}
		
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat rowHeight = [self.delegate rowHeightForMNRulerPickerView:self];
    
	// Add front and back padding to make this more closely resemble a picker view
	if (indexPath.row == 0) {
		return (self.overlayCell.frame.origin.y + rowHeight);
	}
  else if (indexPath.row == [self.dataSource numberOfRowsInMNRulerPickerView:self] - 1) {
		return (self.overlayCell.frame.origin.y + rowHeight);
	}
	return rowHeight;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGFloat rowHeight = [self.delegate rowHeightForMNRulerPickerView:self];
    
	// Auto scroll to next multiple of rowHeight
	CGFloat floatVal = targetContentOffset->y / rowHeight;
	NSInteger rounded = (NSInteger)(lround(floatVal));

	targetContentOffset->y = rounded * rowHeight;
    
    // Tell delegate where we're landing
    [self.delegate djuPickerView:self didSelectRow:rounded];
}

@end
