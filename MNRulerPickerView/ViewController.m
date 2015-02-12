//
//  ViewController.m
//  MNRulerPickerView
//
//  Created by 이창민 on 2015. 2. 13..
//  Copyright (c) 2015년 MongTong. All rights reserved.
//

#import "ViewController.h"
#import "MNRulerPickerView.h"
#define DEGREES_TO_RADIANS(x) (M_PI * (x) / 180.0)
@interface ViewController () <MNRulerPickerViewDelegate, MNRulerPickerViewDataSource>

@end
@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor blueColor];
  
  _pickerData = [[NSArray alloc]initWithObjects:@"Hello", @"This", @"Is", @"The", @"Custom", @"djuPickerView", @"It", @"Works", @"And", @"Looks", @"Great", nil];
  
  // Do any additional setup after loading the view, typically from a nib.
  MNRulerPickerView *djuPickerView = [[MNRulerPickerView alloc] initWithFrame:CGRectMake(10,200,300,100)];
  CGAffineTransform rotate = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(270));
  rotate = CGAffineTransformScale(rotate,1,1);
  [djuPickerView setTransform:rotate];
  djuPickerView.delegate = self;
  djuPickerView.dataSource = self;
  // djuPickerView.backgroundColor = [UIColor colorWithRed:0.6980392157 green:0.6980392157 blue:0.6980392157 alpha:1.0];
  
  [self.view addSubview:djuPickerView];
  
  [djuPickerView selectRow:3];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - MNRulerPickerViewDelegate functions

- (NSString *)djuPickerView:(MNRulerPickerView *)djuPickerView titleForRow:(NSInteger)row {
  return [_pickerData objectAtIndex:row];
}

- (void)djuPickerView:(MNRulerPickerView*)djuPickerView didSelectRow:(NSInteger)row {
  NSLog(@"Row is %d", (int)row);
}

- (CGFloat)rowHeightForMNRulerPickerView:(MNRulerPickerView *)djuPickerView {
  return 60.0;
}

- (void)labelStyleForMNRulerPickerView:(MNRulerPickerView*)djuPickerView forLabel:(UILabel*)label {
  label.textColor = [UIColor blackColor];
  label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:24.0];
}

#pragma mark - MNRulerPickerViewDataSource functions

- (NSInteger)numberOfRowsInMNRulerPickerView:(MNRulerPickerView*)djuPickerView {
  return [_pickerData count];
}

@end
