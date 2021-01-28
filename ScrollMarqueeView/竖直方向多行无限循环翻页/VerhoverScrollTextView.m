//
//  VerhoverScrollview.m
//  ScrollMarqueeView
//
//  Created by admin on 2021/1/28.
//

#import "VerhoverScrollTextView.h"
#import "VerHoverTableViewCell.h"
#import <Masonry/Masonry.h>

#define cellHeight 40

@implementation VerhoverScrollTextView

-(UIView *)bgView{
    if (!_bgView) {
        _bgView=[UIView new];
        _bgView.backgroundColor=[UIColor cyanColor];
        _bgView.layer.masksToBounds=YES;
    }
    return _bgView;
}

- (UITableView *)fightTableView{
    if (_fightTableView == nil) {
        _fightTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _fightTableView.delegate = self;
        _fightTableView.dataSource = self;
        _fightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _fightTableView.showsVerticalScrollIndicator=NO;
        _fightTableView.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:0];
        _fightTableView.scrollEnabled=NO;

    }
    return _fightTableView;
}


-(instancetype)init{
    self=[super init];
    
    if (self) {
        
        [self setUI];
    }
        return self;
}


-(void)setUI{
    
    __weak typeof(self)  weakSelf=self;
    
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(10);
        make.leading.equalTo(weakSelf.mas_leading).offset(10);
        make.trailing.equalTo(weakSelf.mas_trailing).offset(-10);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-10);
    }];
    
    self.fightTableView.estimatedRowHeight = 0;
    self.fightTableView.estimatedSectionHeaderHeight = 0;
    self.fightTableView.estimatedSectionFooterHeight = 0;

    [self.bgView addSubview:self.fightTableView];
    [self.fightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.bgView);
    }];
    
    
    [self addTimer];
    
}


/**
 *  添加定时器
 */
- (void)addTimer
{
    if (self.timer) {
        [self.timer invalidate];
    }
    
  
    
    self.timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(timerClick) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}

/**
 *  定时器数数
 */
- (void)timerClick
{
  
    
   [self scrollTableveiwcell];

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


-(void)scrollTableveiwcell{
    
    __weak typeof(self)  weakSelf=self;
    
    if (self.scrollSection==self.sxArry.count/2) {

        self.scrollSection=0;
        [self.fightTableView setContentOffset:CGPointMake(0, 0) animated:NO];

    }else{
        
    }

    [UIView transitionWithView: self.fightTableView duration:0.3 options: UIViewAnimationOptionTransitionNone animations: ^{

        [weakSelf.fightTableView setContentOffset:CGPointMake(0, weakSelf.fightTableView.contentOffset.y+cellHeight) animated:YES];
        
    } completion: ^(BOOL finished) {

        weakSelf.scrollSection=weakSelf.scrollSection+1;

    }];

}


-(void)setSxArry:(NSMutableArray *)sxArry{
    
    _sxArry=sxArry;
    
    //将要显示的文本数量翻倍
    [_sxArry addObjectsFromArray:[NSArray arrayWithArray:sxArry]];
    
        
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sxArry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", indexPath.section, indexPath.row];//以indexPath来唯一确定cell
    VerHoverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier]; //出列可重用的cell
    if (cell == nil) {
        cell = [[VerHoverTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text=self.sxArry[indexPath.row];
    
    cell.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:0];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return cellHeight;
}



-(void)removeFromSuperview{
    
    [super removeFromSuperview];
    
    
    [self invTimer];
    
    
}



-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    self.oldcoffentY=self.fightTableView.contentOffset.y;
    
}



@end
