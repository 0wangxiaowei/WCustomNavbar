//
//  MKTChannelVC.m
//  marketing
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 xiaowei. All rights reserved.
//

#import "MKTChannelVC.h"
#import "TLDragButton.h"

static NSUInteger kLineCount = 4;

@interface MKTChannelVC () <TLDragButtonDelegate>
{
    CGFloat hig;
}
@property (nonatomic, strong) NSArray *tags;

@property (nonatomic, strong)  NSMutableArray *array;
@property (nonatomic, strong) NSMutableArray *morearray;
@property (nonatomic, strong) NSMutableArray *mutArr1 ;
@property (nonatomic, strong) NSMutableArray *mutArr2;

@property (nonatomic, strong) NSMutableArray *allMutArr;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIScrollView *morescrollView;

@property (nonatomic, strong)UIView *twoView;

@end

@implementation MKTChannelVC
- (instancetype)init
{
    self = [super init];
    if (self) {
            _acontArr = [[NSArray alloc] init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
   self.view.backgroundColor = RGB(236, 239, 244);
    hig=  ([UIScreen mainScreen].bounds.size.width - 1*(kLineCount + 1))/kLineCount+20;
    
    _array = [NSMutableArray array];
    _morearray = [NSMutableArray array];
    
    _allMutArr= [NSMutableArray array];
    
    _mutArr1 = [NSMutableArray array];
    _mutArr2 = [NSMutableArray array];
    
    NSArray *title = @[@"励志",@"美食",@"科技",@"娱乐",@"财经",@"动态",@"感情",@"社会"];
    
    for (int i = 0; i<title.count; i++) {
        //        chanelModel *model = [[chanelModel alloc] init];
        TLDragButton *model = [TLDragButton buttonWithType:UIButtonTypeCustom];
        
        model.imageStr = title[i];
        model.titleStr =title[i];
        model.tagStr = [NSString stringWithFormat:@"%d",10+i];
        
        model.isShow = [_acontArr containsObject:title[i]]?YES:NO;
        [_allMutArr addObject:model];
        
    }
    
    for (int i = 0; i<_allMutArr.count; i++) {
        TLDragButton *but = _allMutArr[i];
        if (but.isShow) {
            [_mutArr1 addObject:but];
        }
        else{
            [_mutArr2 addObject:but];
        }
        
    }
    
    [self creatSrc];
    
    [self changScr];
    
    
    
    
}
-(void)creatSrc{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 70, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 264)];
//        self.scrollView.backgroundColor = [UIColor lightGrayColor];
    self.scrollView.contentSize = CGSizeMake(0, 5*131);
    [self.view addSubview:self.scrollView];
    UILabel *tisLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, kScreenWidth, 40)];
    [ self.view addSubview:tisLab];
    tisLab.text = @"  拖动或点击调动频道位置";
    
    

    _twoView = [[UIView alloc] initWithFrame:CGRectMake(0, hig+(_mutArr1.count/4+1)*hig+33, kScreenWidth, 300)];
    [self.view addSubview:_twoView];
//        _twoView.backgroundColor = [UIColor blueColor];
    UILabel *tisLab2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, 30)];
    [_twoView addSubview:tisLab2];
    tisLab2.text = @"  更多频道";
    
    self.morescrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 264)];

    self.morescrollView.contentSize = CGSizeMake(0, 5*131);

    [_twoView addSubview:self.morescrollView];
    
    self.scrollView.bounces = NO;
    self.morescrollView.bounces = NO;
    self.scrollView.scrollEnabled = NO;
    self.morescrollView.scrollEnabled = NO;
    //
}
-(void)changScr
{
    for (UIView *view in self.scrollView.subviews) {
        
        [view removeFromSuperview];
    }
    for (UIView *view in self.morescrollView.subviews) {
        [view removeFromSuperview];
    }
    [_array removeAllObjects];
    [_morearray removeAllObjects];
    
    //    CGFloat kMargin = 1;
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - (kLineCount + 1))/kLineCount;
    
    CGFloat height =  ([UIScreen mainScreen].bounds.size.width - (kLineCount + 1))/kLineCount+10;
    hig = height;
    
    for (NSInteger index = 0; index < _mutArr1.count; index ++) {
        TLDragButton *btn= _mutArr1[index];
        NSUInteger X = index % kLineCount;
        NSUInteger Y = index / kLineCount;
        
        btn.backgroundColor = [UIColor whiteColor];

        btn.tag = btn.tagStr.integerValue;
        btn.lineCount = kLineCount;
        btn.dragColor = [UIColor blueColor];
        btn.delegate = self;
        [btn setTitle:btn.titleStr forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:btn.imageStr] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(X * (width + 1) + 1, Y * (hig + 1), width, hig);
        [self.scrollView addSubview:btn];
        
        [_array addObject:btn];
        btn.btnArray = _array;
    }
    
    for (NSInteger index = 0; index < _mutArr2.count; index ++) {
        TLDragButton *btn= _mutArr2[index];
        NSUInteger X = index % kLineCount;
        NSUInteger Y = index / kLineCount;
        
        //        TLDragButton *btn = [TLDragButton buttonWithType:UIButtonTypeCustom];
        
        btn.backgroundColor = [UIColor whiteColor];
        
        btn.tag = btn.tagStr.integerValue;
        btn.lineCount = kLineCount;
        btn.dragColor = [UIColor blueColor];
        btn.delegate = self;
        [btn setTitle:btn.titleStr forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:btn.imageStr] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(X * (width + 1) + 1, Y * (hig + 1), width, hig);
        [self.morescrollView addSubview:btn];
        
        [_morearray addObject:btn];
        btn.btnArray = _morearray;
    }
    
    
}

/**
 *  BOOL类型告诉是否重新排序，移动到不同分组直接加在后面要保持排序不变，
 *
 *  否则要重新排序
 *  @param remove BOOL类型告诉是否重新排序，移动到不同分组直接加在后面要保持排序不变
 */
-(void)changTwoScrView:(BOOL)remove
{
    if (remove) {
        [_mutArr1 removeAllObjects];
        [_mutArr2 removeAllObjects];
        for (int i = 0; i<_allMutArr.count; i++) {
            TLDragButton *but = _allMutArr[i];
            if (but.isShow) {
                [_mutArr1 addObject:but];
            }
            else{
                [_mutArr2 addObject:but];
            }
            
        }
    }
    else{
        
        [self chanArr];
    }
    

    [self changScr];

    

    if (_mutArr1.count>4&&_mutArr1.count<=8) {
        _twoView.frame =CGRectMake(0, hig+2*hig+33, kScreenWidth, 300);
    }
    else if(_mutArr1.count>8){
        _twoView.frame =CGRectMake(0, hig+3*hig+33, kScreenWidth, 300);
    }else{
        _twoView.frame =CGRectMake(0, hig+1*hig+33, kScreenWidth, 300);
        
    }
    
    
}
- (void)clickAction:(TLDragButton *)sender {
    
    
    NSLog(@"你点中了：%@--isShow%d ", sender.currentTitle,sender.isShow);
    
    
    sender.isShow = !sender.isShow;
    [self changTwoScrView:YES];
    /**
     *  重新调整位置
     */
    
    [self chanArr];
    
    
}
-(void)chanArr
{
    [_allMutArr removeAllObjects];
    
    for (int i = 0; i<_mutArr1.count; i++) {
        [_allMutArr addObject:_mutArr1[i]];
    }
    for (int i = 0; i<_mutArr2.count; i++) {
        [_allMutArr addObject:_mutArr2[i]];
    }
}
- (void)dragButton:(TLDragButton *)dragButton dragButtons:(NSArray *)dragButtons {
    
    
    if(dragButton.isShow)
    {
        
        
        [_mutArr1 removeAllObjects];
        for (int i = 0; i<dragButtons.count; i++) {
            TLDragButton *bu = dragButtons[i];
            [_mutArr1 addObject:bu];
        }
        
    }else{
        [_mutArr2 removeAllObjects];
        for (int i = 0; i<dragButtons.count; i++) {
            TLDragButton *bu = dragButtons[i];
            [_mutArr2 addObject:bu];
        }
        
    }
    
    [self changTwoScrView:NO];
    NSString *currentTitle = dragButton.currentTitle;
    
        NSLog(@"%@位置发生了改变", currentTitle);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSMutableArray *lastArr = [NSMutableArray array];
    
    for (int i = 0;i<_allMutArr.count; i++) {
        TLDragButton *b = _allMutArr[i];

        
        NSLog(@"%@",b.titleLab.text);
    }
    
    for (int i = 0;i<_mutArr1.count; i++) {
        TLDragButton *b = _mutArr1[i];
        
        [lastArr addObject:b.titleLab.text];
        NSLog(@"_mutArr1 = %@",b.titleLab.text);
    }
    
    if([_delegate respondsToSelector:@selector(chaniTitleScr:)])
    {
        //send the delegate function with the amount entered by the user
        [_delegate chaniTitleScr:(NSArray *)lastArr];
    }

}

@end
