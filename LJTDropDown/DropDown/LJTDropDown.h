//
//  LJTDropDown.h
//  LJTDropDown
//
//  Created by 李俊涛 on 16/3/17.
//  Copyright © 2016年 myhexin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJTDropDown : UIView<UITableViewDataSource,UITableViewDelegate>

//下拉框属性
//下拉框cell背景颜色
@property (strong, nonatomic) UIColor *colorDropDown;
//下拉框cell高度
@property (assign, nonatomic) CGFloat heightCellDropDown;
//下拉框的宽度
@property (assign, nonatomic) CGFloat widthDropDown;

- (id) initWithButton:(UIButton *)btn withHeight:(CGFloat)height withArray:(NSArray *) arr;

@end
