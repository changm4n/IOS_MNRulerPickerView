//
//  ViewController.h
//  MNRulerPickerView
//
//  Created by 이창민 on 2015. 2. 13..
//  Copyright (c) 2015년 MongTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MNRulerPickerViewDelegate;
@protocol MNRulerPickerViewDataSource;

@interface MNRulerPickerView : UIView

- (void)selectRow:(NSInteger)row;
- (void)min:(NSInteger)min max:(NSInteger)min;

@property (nonatomic, strong) UIView *overlayCell;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic) NSInteger maxValue;
@property (nonatomic) NSInteger minValue;

@property (nonatomic, weak) id <MNRulerPickerViewDelegate> delegate;
@property (nonatomic, weak) id <MNRulerPickerViewDataSource> dataSource;

@end

@protocol MNRulerPickerViewDelegate

- (NSInteger)MNRulerPickerView:(MNRulerPickerView*)MNRulerPickerView titleForRow:(NSInteger)row;
- (void)MNRulerPickerView:(MNRulerPickerView*)MNRulerPickerView didSelectRow:(NSInteger)row;
- (CGFloat)rowHeightForMNRulerPickerView:(MNRulerPickerView*)MNRulerPickerView;
- (void)labelStyleForMNRulerPickerView:(MNRulerPickerView*)MNRulerPickerView forLabel:(UILabel*)label;

@end

@protocol MNRulerPickerViewDataSource

- (NSInteger)numberOfRowsInMNRulerPickerView:(MNRulerPickerView*)MNRulerPickerView;

@end