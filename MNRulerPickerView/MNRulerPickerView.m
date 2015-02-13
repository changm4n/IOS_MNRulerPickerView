//
//  ViewController.h
//  MNRulerPickerView
//
//  Created by 이창민 on 2015. 2. 13..
//  Copyright (c) 2015년 MongTong. All rights reserved.
//

#import "MNRulerPickerView.h"
#import "MNRulerPickerViewCell.h"
#define DEGREES_TO_RADIANS(x) (M_PI * (x) / 180.0)

@interface MNRulerPickerView() <UITableViewDataSource, UITableViewDelegate>

@end

@implementation MNRulerPickerView {
  UITableView *_tableView;
}

- (id)initWithFrame:(CGRect)frame{
  CGFloat x = frame.origin.x;
  CGFloat y = frame.origin.y;
  CGFloat w = frame.size.width;
  CGFloat h = frame.size.height;
  self = [super initWithFrame:CGRectMake(x+(w-h)/2, y+(h-w)/2, h, w)];
  if (self) {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];

    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.allowsSelection = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.bounces=NO;
    UIView *v =[[UIView alloc]init];
    [_tableView setTableFooterView:v];
    

    self.overlayCell = [[UIView alloc] init];
    self.overlayCell.backgroundColor = [UIColor redColor];
    self.overlayCell.userInteractionEnabled = NO;
    
  }
  return self;
}

- (void)layoutSubviews {
  CGFloat rowHeight = [self.delegate rowHeightForMNRulerPickerView:self];
  _tableView.contentInset = UIEdgeInsetsMake(rowHeight, 0,rowHeight, 0);
  // Move overlay to center of table view
  CGFloat centerY = (self.frame.size.width)/2.0;
  self.overlayCell.frame = CGRectMake(self.frame.size.height/2, centerY-1, self.frame.size.height/2, 3);
  
  
  [self addSubview:_tableView];
  [self addSubview:_overlayCell];
}

/*
- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
	// Always pass all touches on this view to the table view
	return _tableView;
}*/

- (void)min:(NSInteger)min max:(NSInteger)max{
  _minValue = min;
  _maxValue = max;
}





- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _tableView.backgroundColor = backgroundColor;
}

#pragma mark - UITableViewDelegate functions

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

  //return [self.dataSource numberOfRowsInMNRulerPickerView:self];
  return _maxValue-_minValue+1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  MNRulerPickerViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
  
  
  if(cell ==nil){
    [tableView registerNib:[UINib nibWithNibName:@"MNRulerPickerViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
  
  }
  CGAffineTransform rotate = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(90));
  rotate = CGAffineTransformScale(rotate,1,1);
  [cell.myLabel setTransform:rotate];
  cell.myLabel.text =[NSString stringWithFormat:@"%d",(int)([self.delegate MNRulerPickerView:self titleForRow:indexPath.row]+_minValue)];
  
  
  return cell;
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.delegate rowHeightForMNRulerPickerView:self];
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
  CGFloat rowHeight = [self.delegate rowHeightForMNRulerPickerView:self];
  NSInteger currentRow =(int)(_tableView.contentOffset.y+(self.frame.size.width-rowHeight)/2)/10;
  [self.delegate MNRulerPickerView:self didSelectRowAtIndexPath:[NSIndexPath indexPathForRow: currentRow+_minValue*10 inSection:0]];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
  CGFloat rowHeight = 10;
  
	// Auto scroll to next multiple of rowHeight
	CGFloat floatVal = targetContentOffset->y / rowHeight;
	NSInteger rounded = (NSInteger)(ceilf(floatVal));

	targetContentOffset->y = rounded * rowHeight;
}

- (void)selectRow:(NSInteger)row {
  CGFloat rowHeight = [self.delegate rowHeightForMNRulerPickerView:self];
  [_tableView setContentOffset:CGPointMake(0.0, row * rowHeight)];
}



@end
