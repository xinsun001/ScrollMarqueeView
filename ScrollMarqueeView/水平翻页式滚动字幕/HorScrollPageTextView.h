//
//  HorScrollPageTextView.h
//  ScrollMarqueeView
//
//  Created by admin on 2021/1/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HorScrollPageTextView : UIView<UIScrollViewDelegate>

@property(nonatomic,strong)NSMutableArray *textArr;

//显示到第几个
@property(nonatomic,assign)NSInteger arrNum;


@property(nonatomic,strong)UILabel *txtLabel;
@property(nonatomic,strong)UIScrollView *textScrollview;

@property(nonatomic,assign)CGFloat scrollWidth;

@property(nonatomic,assign)NSInteger scrX;

@property(nonatomic,strong)NSTimer *timer;


- (void)invTimer;


@end

NS_ASSUME_NONNULL_END
