//
//  HorScrollPageTextView.m
//  ScrollMarqueeView
//
//  Created by admin on 2021/1/28.
//

#import "HorScrollPageTextView.h"
#import <Masonry/Masonry.h>


#define  ViewAllWidth [UIScreen mainScreen].bounds.size.width

@implementation HorScrollPageTextView


-(UILabel *)txtLabel{
    if (!_txtLabel) {
        _txtLabel=[UILabel new];
        _txtLabel.textColor=[UIColor blackColor];
        _txtLabel.font=[UIFont systemFontOfSize:13];
        _txtLabel.backgroundColor=[UIColor greenColor];
    }
    return _txtLabel;
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
        
        [self.textScrollview addSubview:self.txtLabel];
        [self.txtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.textScrollview);
            make.leading.equalTo(weakSelf.textScrollview.mas_leading).offset(ViewAllWidth);
        }];

        
        self.scrX=ViewAllWidth;

                
    }
    return self;
}

-(CGFloat )getTxtWidth:(NSString *)str{
    
    CGRect rect = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil];
    CGFloat btnWidth = rect.size.width;
    
    return btnWidth;
}



-(void)setTextArr:(NSMutableArray *)textArr{
    _textArr=textArr;
    
    self.txtLabel.text=textArr[0];
    
    self.scrollWidth=[self getTxtWidth:textArr[0]];
    
    [self.textScrollview setContentOffset:CGPointMake(ViewAllWidth, 0) animated:NO];

    self.arrNum=0;
    
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

    if (self.textScrollview.contentOffset.x>=self.textScrollview.contentSize.width-ViewAllWidth) {

        [self refreshTxt];

    }else{

    }
   
}

-(void)refreshTxt{
    
    if (self.arrNum==self.textArr.count-1) {
        self.arrNum=0;
    }else{
        self.arrNum=self.arrNum+1;

    }
    self.txtLabel.text=self.textArr[self.arrNum];
    self.scrollWidth=[self getTxtWidth:self.textArr[self.arrNum]];
    
    self.scrX=0;
    [self.textScrollview setContentOffset:CGPointMake(self.scrX, 0) animated:NO];
    
}

-(void)setScrollWidth:(CGFloat)scrollWidth{
    _scrollWidth=scrollWidth;
    
    self.textScrollview.contentSize=CGSizeMake(scrollWidth+ViewAllWidth*2, 0);

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
