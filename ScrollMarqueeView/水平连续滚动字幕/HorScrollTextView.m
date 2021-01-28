//
//  HorScrollTextView.m
//  FREEGOU
//
//  Created by admin on 2021/1/8.
//  Copyright © 2021 xin sun. All rights reserved.
//

#import "HorScrollTextView.h"
#import <Masonry/Masonry.h>


@implementation HorScrollTextView

-(void)dealloc{
    [self invTimer];
}


-(UIScrollView *)textScrollview{
    if (!_textScrollview) {
        _textScrollview=[UIScrollView new];
        _textScrollview.delegate=self;
        _textScrollview.showsHorizontalScrollIndicator=NO;
        _textScrollview.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:0];
    }
    return _textScrollview;
}


-(instancetype)init{
    self=[super init];
    
    if (self) {
        
        __weak typeof(self)  weakSelf=self;

        [self addSubview:self.textScrollview];
        [self.textScrollview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf);
        }];
        
        self.scrX=0;

        
                
    }
    return self;
}


-(void)setTextArr:(NSMutableArray *)textArr{
    _textArr=textArr;
    
//    刷新的时候可以添加这句代码，先清空再添加，避免重复添加
    //[self.textScrollview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    [self addCatryButton:textArr];
}


-(void)addCatryButton:(NSMutableArray *)theArr{
    
//    将要显示的内容数量翻倍，5个变成10个，7个变成14个
    [theArr addObjectsFromArray:[NSArray arrayWithArray:theArr]];

    NSMutableArray *tmp=[NSMutableArray array];
    CGFloat pointX = 5; //button X坐标
    CGFloat pointY = 5; //button Y坐标
    CGFloat padding = 10.0; //button 间距
    CGFloat btnHeight = 30; //button高度

    for (int i = 0; i < theArr.count; i++) {

        CGRect rect = [theArr[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, btnHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil];
        CGFloat btnWidth = rect.size.width + 15+25;

        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.backgroundColor=[UIColor whiteColor];
        
        UIImageView *headimg=[UIImageView new];
        headimg.backgroundColor=[UIColor redColor];
        headimg.frame=CGRectMake(5, 5, 20, 20);
        [but addSubview:headimg];

        [but setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [but setTitle:[NSString stringWithFormat:@"     %@",theArr[i]] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        but.titleLabel.font = [UIFont systemFontOfSize:13];
        but.layer.cornerRadius=15;
        but.layer.masksToBounds=YES;
        

        but.frame = CGRectMake(pointX, pointY, btnWidth, btnHeight);
        pointX += (btnWidth + padding);//每次X都加上button宽和间距5
        [tmp addObject:but];
        
        
        [self.textScrollview addSubview:but];
        
        if (i==theArr.count-1) {
            self.scrMaxW=pointX;//获得X轴最大值，即整个scrollview的宽度
        }
        
    }
    
}


-(void)setScrMaxW:(NSInteger)scrMaxW{
    _scrMaxW=scrMaxW;
    
    self.textScrollview.contentSize=CGSizeMake(scrMaxW, 0);
    
    [self addTimer];


}



-(NSTimer *)timer{
    if (!_timer) {
        _timer=[NSTimer new];
        _timer = [NSTimer timerWithTimeInterval:0.01 target:self selector:@selector(timerClick) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];

    }
    
    return _timer;
}


/**
 *  添加定时器
 */
- (void)addTimer
{

    [self.timer fire];


}



/**
 *  定时器数数
 */
- (void)timerClick
{
    self.scrX=self.scrX+1;
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [self.textScrollview setContentOffset:CGPointMake(self.scrX, 0) animated:NO];
    } completion:nil];
    
    if (self.textScrollview.contentOffset.x+1>=self.textScrollview.contentSize.width/2) {
        self.scrX=0;
        [self.textScrollview setContentOffset:CGPointMake(self.scrX, 0) animated:NO];

    }else{
        
    }
   
}


/**
 *  销毁定时器
 */
- (void)invTimer
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark--------------view的生命周期
- (void)removeFromSuperview
{
//    NSLog(@"我被移除了");
    [self invTimer];
}


@end
