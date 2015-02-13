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
  
  _pickerData = [[NSArray alloc]initWithObjects:@"Hello", @"This", @"Is", @"The", @"Custom", @"MNRulerPickerView", @"It", @"Works", @"And", @"Looks", @"Great", nil];
  
  // Do any additional setup after loading the view, typically from a nib.
  MNRulerPickerView *MNRuler = [[MNRulerPickerView alloc]initWithFrame:CGRectMake(10,200,300,100)];
  [MNRuler min:10 max:30];
  CGAffineTransform rotate = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(270));
  rotate = CGAffineTransformScale(rotate,1,1);
  [MNRuler setTransform:rotate];
  
  MNRuler.delegate = self;
  MNRuler.dataSource = self;
  // MNRulerPickerView.backgroundColor = [UIColor colorWithRed:0.6980392157 green:0.6980392157 blue:0.6980392157 alpha:1.0];
  
  [self.view addSubview:MNRuler];
  
  [MNRuler selectRow:5];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - MNRulerPickerViewDelegate functions

- (NSInteger)MNRulerPickerView:(MNRulerPickerView *)MNRulerPickerView titleForRow:(NSInteger)row {
  return row;
}
- (void)MNRulerPickerView:(MNRulerPickerView*)MNRulerPickerView didSelectRow:(NSInteger)row {
  NSLog(@"Row is %ld", (long)row);
}

- (CGFloat)rowHeightForMNRulerPickerView:(MNRulerPickerView *)MNRulerPickerView{
  return 10;
}


- (void)labelStyleForMNRulerPickerView:(MNRulerPickerView*)MNRulerPickerView forLabel:(UILabel*)label {
  label.textColor = [UIColor blackColor];
  label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:25.0];
  label.backgroundColor = [UIColor grayColor];
}

#pragma mark - MNRulerPickerViewDataSource functions


- (NSInteger)numberOfRowsInMNRulerPickerView:(MNRulerPickerView*)MNRulerPickerView {
  return [_pickerData count];
}

@end
