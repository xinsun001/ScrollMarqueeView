//
//  VerScrollTextView.h
//  ScrollMarqueeView
//
//  Created by admin on 2021/1/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VerScrollTextView : UIView<CAAnimationDelegate>

@property(nonatomic,strong)UIView *verBgView;

@property(nonatomic,strong)UILabel *txtLabel;

@property(nonatomic,strong)NSMutableArray *sxArry;

//显示到第几个
@property(nonatomic,assign)NSInteger arrNum;

@end

NS_ASSUME_NONNULL_END
