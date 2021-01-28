//
//  ViewController.m
//  ScrollMarqueeView
//
//  Created by admin on 2021/1/28.
//

#import "ViewController.h"

#import "HorScrollTextView.h"
#import "HorScrollPageTextView.h"

#import "VerhoverScrollTextView.h"
#import "VerScrollTextView.h"

#define  ViewAllWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *txtonearr=[NSArray array];
    txtonearr=@[@"这是第一组内容",
            @"这是第二组内容",
            @"这是第三组内容",
            @"这是第四组内容",
            @"这是第五组内容"];
    
    HorScrollTextView *topView=[HorScrollTextView new];
    topView.backgroundColor=[UIColor orangeColor];
    topView.textArr=[NSMutableArray arrayWithArray:txtonearr];
    
    topView.frame=CGRectMake(0, 100, ViewAllWidth, 40);
    [self.view addSubview:topView];
    
    
    NSArray *txttwoarr=[NSArray array];
    txttwoarr=@[@"这是第一组内容",
            @"这是超长内容这是超长内容这是超长内容这是超长内容这是超长内容这是容这是",
            @"这是第三组内容"
            ];
    HorScrollPageTextView *middleView=[HorScrollPageTextView new];
    middleView.backgroundColor=[UIColor orangeColor];
    middleView.textArr=[NSMutableArray arrayWithArray:txttwoarr];
    
    middleView.frame=CGRectMake(0, 180, ViewAllWidth, 40);
    [self.view addSubview:middleView];
    
    
    
    VerhoverScrollTextView *verHoverView=[VerhoverScrollTextView new];
    verHoverView.backgroundColor=[UIColor purpleColor];
    verHoverView.sxArry=[NSMutableArray arrayWithArray:txtonearr];
    
    verHoverView.frame=CGRectMake(30, 260, ViewAllWidth-60, 100);
    [self.view addSubview:verHoverView];
    
    
    VerScrollTextView *verView=[VerScrollTextView new];
    verView.backgroundColor=[UIColor purpleColor];
    verView.sxArry=[NSMutableArray arrayWithArray:txttwoarr];
    
    verView.frame=CGRectMake(30, 400, ViewAllWidth-60, 80);
    [self.view addSubview:verView];
    
}


@end
