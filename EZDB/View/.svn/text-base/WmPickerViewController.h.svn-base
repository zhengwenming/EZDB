//
//  WmPickerViewController.h
//  自定义ImagePicker
//
//  Created by wenming.zheng on 14-10-27.
//  Copyright (c) 2014年 Pactera. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WmPickerViewController;
@protocol WmImagePickerDelegate <NSObject>

- (void)imagePicker:(WmPickerViewController *)pickerViewController didFinished:(UIImage *)editedImage;
- (void)imagePickerDidCancel:(WmPickerViewController *)pickerViewController;

@end

@interface WmPickerViewController : STViewController
@property (nonatomic, assign) NSInteger tag;

@property (nonatomic, assign) id<WmImagePickerDelegate> imagePickerDelegate;

@property (nonatomic, assign) CGRect cropFrame;

- (id)initWithImage:(UIImage *)originalImage withFrame:(CGRect)frame limitScaleRatio:(NSInteger)limitRatio;

@end
