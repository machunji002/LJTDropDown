//
//  LJTDropDown.m
//  LJTDropDown
//
//  Created by 李俊涛 on 16/3/17.
//  Copyright © 2016年 myhexin. All rights reserved.
//

#import "LJTDropDown.h"

@interface LJTDropDown ()

@property (strong, nonatomic) UIButton *button;
@property (assign, nonatomic) CGFloat tableViewHeight;
@property (strong, nonatomic) NSArray *array;

@property (strong, nonatomic) UITableView *tableView;



@end

@implementation LJTDropDown


- (id) initWithButton:(UIButton *)btn withHeight:(CGFloat)height withArray:(NSArray *) arr{
    
    if (self == [super init]) {
        [self initProperty:btn withHeight:height withArray:arr];
        [self addTableView];
        
    }
    return self;
}

- (void)dealloc{
    [self unregisterFromKVO];
}

#pragma mark - tools

//add TableView
- (void)removeSubviews{
    for(UIView *view in [self subviews])
    {
        [view removeFromSuperview];
    }
}
- (void)addTableView{
    [self removeSubviews];
    [self removeFromSuperview];
    CGRect rect = _button.frame;
    CGFloat x = rect.origin.x + (rect.size.width - _widthDropDown) / 2.0;
    CGFloat y = rect.origin.y + rect.size.height;
    CGFloat width = _widthDropDown == 0 ? rect.size.width : _widthDropDown;
    CGFloat height = _tableViewHeight;
    self.frame = CGRectMake(x, y, width, 0);
//    self.layer.cornerRadius = 1;
//    self.layer.masksToBounds = NO;
    
    //设置阴影
    self.layer.shadowOffset = CGSizeMake(-5, 5);
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.5;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.layer.cornerRadius = 10;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.separatorColor = [UIColor blackColor];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.frame = CGRectMake(x, y, width, height);
    _tableView.frame = CGRectMake(0, 0, width, height);
    [UIView commitAnimations];
    
    [self addSubview:_tableView];
    [self.superview addSubview:self];
}

//初始化下拉框属性
- (void)initProperty:(UIButton *)btn withHeight:(CGFloat)height withArray:(NSArray *)arr{
    _button = btn;
    _tableViewHeight = height;
    _array = [NSArray arrayWithArray:arr];
    _colorDropDown = [UIColor whiteColor];
    _heightCellDropDown = 30.0;
    _widthDropDown = btn.frame.size.width;
    [self registerForKVO];
}

-(void)hideDropDown:(UIButton *)btn{
    CGRect rect = btn.frame;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.frame = CGRectMake(rect.origin.x + (rect.size.width - _widthDropDown) / 2.0, rect.origin.y + rect.size.height, _widthDropDown, 0);
    _tableView.frame = CGRectMake(0, 0, _widthDropDown, 0);
    [UIView commitAnimations];
}
#pragma mark - KVO

- (void)registerForKVO {
    for (NSString *keyPath in [self observableKeypaths]) {
        [self addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:NULL];
    }
}

- (void)unregisterFromKVO {
    for (NSString *keyPath in [self observableKeypaths]) {
        [self removeObserver:self forKeyPath:keyPath];
    }
}

- (NSArray *)observableKeypaths {
    return [NSArray arrayWithObjects:@"colorDropDown", @"heightCellDropDown", @"widthDropDown",nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(updateUIForKeypath:) withObject:keyPath waitUntilDone:NO];
    } else {
        [self updateUIForKeypath:keyPath];
    }
}

- (void)updateUIForKeypath:(NSString *)keyPath {
    if ([keyPath isEqualToString:@"widthDropDown"]) {
        [self addTableView];
    } else {
        return;
    }
//    [self setNeedsLayout];
//    [self setNeedsDisplay];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = _array[indexPath.row];
    cell.textAlignment = NSTextAlignmentCenter;
    cell.backgroundColor = _colorDropDown;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _heightCellDropDown;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self hideDropDown:_button];
    UITableViewCell *tempCell = [tableView cellForRowAtIndexPath:indexPath];
    [_button setTitle:tempCell.textLabel.text forState:UIControlStateNormal];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
