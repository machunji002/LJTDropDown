//
//  ViewController.m
//  LJTDropDown
//
//  Created by 李俊涛 on 16/3/17.
//  Copyright © 2016年 myhexin. All rights reserved.
//

#import "ViewController.h"
#import "LJTDropDown.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *dropDownBtn;
@property (strong, nonatomic) NSArray *array;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _array = [[NSArray alloc] initWithObjects:@"123",@"456",@"789",@"ljt",@"hdu",@"ths", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dropDownAction:(id)sender {
    LJTDropDown *view = [[LJTDropDown alloc] initWithButton:_dropDownBtn withHeight:100 withArray:_array];
    view.colorDropDown = [UIColor grayColor];
    view.heightCellDropDown = 30.0;
//    view.widthDropDown = 200.0;
    [self.view addSubview:view];
}

@end
