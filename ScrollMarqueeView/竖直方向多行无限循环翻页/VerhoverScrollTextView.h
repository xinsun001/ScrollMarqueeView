//
//  VerhoverScrollview.h
//  ScrollMarqueeView
//
//  Created by admin on 2021/1/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VerhoverScrollTextView : UIView<UITableViewDelegate,UITableViewDataSource,CAAnimationDelegate>


@property(nonatomic,strong)UIView *bgView;

/**  定时器 */
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) CGFloat currentTime;

@property(nonatomic,strong)UITableView *fightTableView;

@property(nonatomic,strong)NSMutableArray *sxArry;

//轮播到第几组
@property(nonatomic,assign)NSInteger scrollSection;

@property (assign, nonatomic) CGFloat oldcoffentY;

- (void)invTimer;


@end

NS_ASSUME_NONNULL_END
