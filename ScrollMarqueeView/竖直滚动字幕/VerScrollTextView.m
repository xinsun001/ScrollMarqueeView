//
//  VerScrollTextView.m
//  ScrollMarqueeView
//
//  Created by admin on 2021/1/28.
//

#import "VerScrollTextView.h"
#import <Masonry/Masonry.h>

@implementation VerScrollTextView

-(UIView *)verBgView{
    if (!_verBgView) {
        _verBgView=[UIView new];
        _verBgView.backgroundColor=[UIColor cyanColor];
        _verBgView.layer.masksToBounds=YES;
    }
    return _verBgView;
}


-(UILabel *)txtLabel{
    if (!_txtLabel) {
        _txtLabel=[UILabel new];
        _txtLabel.font=[UIFont systemFontOfSize:15];
        _txtLabel.numberOfLines=0;
        _txtLabel.textColor=[UIColor blackColor];
    }
    return _txtLabel;
}

-(instancetype)init{
    self=[super init];
    
    if (self) {
        
        __weak typeof(self)  weakSelf=self;
        
        [self addSubview:self.verBgView];
        [self.verBgView addSubview:self.txtLabel];
        
        [self.verBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_top).offset(10);
            make.leading.equalTo(weakSelf.mas_leading).offset(10);
            make.trailing.equalTo(weakSelf.mas_trailing).offset(-10);
            make.bottom.equalTo(weakSelf.mas_bottom).offset(-10);
        }];
        
        [self.txtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.equalTo(weakSelf.verBgView);
            make.bottom.equalTo(weakSelf.verBgView.mas_bottom);
        }];
        
        
        self.arrNum=0;
        
                
    }
    return self;
}


-(void)setSxArry:(NSMutableArray *)sxArry{
    _sxArry=sxArry;
    
    [self scrollTxtAction];

}


-(void)checkDataIndex{
    
    if (self.arrNum==self.sxArry.count-1) {
        self.arrNum=0;
    }else{
        self.arrNum=self.arrNum+1;
    }
    
}

- (void)scrollTxtAction {
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        CATransition *transition = [CATransition animation];
//        transition.duration = 0.3;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromTop;
        transition.delegate = self;
        [self.txtLabel.layer addAnimation:transition forKey:nil];
        
        [self checkDataIndex];
        
    } completion:^(BOOL finished) {
       
        self.txtLabel.text=self.sxArry[self.arrNum];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self scrollTxtAction];
            
        });
        
    }];
}



@end
