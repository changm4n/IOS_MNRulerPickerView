//
//  ViewController.h
//  MNRulerPickerView
//
//  Created by 이창민 on 2015. 2. 13..
//  Copyright (c) 2015년 MongTong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MNRulerPickerViewDelegate;

@interface MNRulerPickerView : UIView

- (void)selectRow:(NSInteger)row;
- (void)min:(NSInteger)min max:(NSInteger)min;

@property (nonatomic, strong) UIView *overlayCell;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic) NSInteger maxValue;
@property (nonatomic) NSInteger minValue;

@property (nonatomic, weak) id <MNRulerPickerViewDelegate> delegate;

@end

@protocol MNRulerPickerViewDelegate
- (NSInteger)MNRulerPickerView:(MNRulerPickerView*)MNRulerPickerView titleForRow:(NSInteger)row;
- (void)MNRulerPickerView:(MNRulerPickerView*)MNRulerPickerView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)rowHeightForMNRulerPickerView:(MNRulerPickerView*)MNRulerPickerView;

@end
