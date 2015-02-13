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
@interface ViewController () <MNRulerPickerViewDelegate>

@end
@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  _lb = [[UILabel alloc]initWithFrame:CGRectMake(110, 70, 100, 100)];
  MNRulerPickerView *MNRuler = [[MNRulerPickerView alloc]initWithFrame:CGRectMake(50, 200, 200, 80)];
  [MNRuler min:70 max:100];
  CGAffineTransform rotate = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(270));
  rotate = CGAffineTransformScale(rotate,1,1);
  [MNRuler setTransform:rotate];
  [MNRuler setBackgroundColor:[UIColor blueColor]];
  MNRuler.delegate = self;
  
  [self.view addSubview:MNRuler];
  [self.view addSubview:_lb];
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
- (void)MNRulerPickerView:(MNRulerPickerView*)MNRulerPickerView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  _lb.text = [NSString stringWithFormat:@"%0.1f cm",(float)indexPath.row/10];
}
- (CGFloat)rowHeightForMNRulerPickerView:(MNRulerPickerView *)MNRulerPickerView{
  return 100;
}




@end
