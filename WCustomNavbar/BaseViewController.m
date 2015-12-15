//
//  BaseViewController.m
//  WXWCustomnavbar
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 xiaowei. All rights reserved.
//

#import "BaseViewController.h"
#import "WXWitemsView.h"
#import "MKTChannelVC.h"

@interface BaseViewController ()<UITableViewDelegate,UITableViewDataSource,WJItemsControlView,chaniTitleScrDelegate>
{
      WXWitemsView *_itemControlView;
}
@property(nonatomic,strong)NSArray *titeArr;
@property(nonatomic,strong)UITableView *mainTabelView;
@end

@implementation BaseViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        _titeArr = [NSArray array];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
     [self creatTopView];
    // Do any additional setup after loading the view.
}

-(void)creatTopView
{
    
    _titeArr= [[NSUserDefaults standardUserDefaults]objectForKey:@"showTilte"];
    if (_titeArr.count==0) {
        _titeArr =  @[@"励志",@"美食",@"科技",@"娱乐"];
        NSMutableArray *tapArr = [NSMutableArray array];
        [tapArr addObject:@"热门"];
        for (int i  = 0; i<_titeArr.count; i++) {
            [tapArr addObject:_titeArr[i]];
        }
        
        _titeArr  = (NSArray *)tapArr;
    }
    
    
    WJItemsConfig *config = [[WJItemsConfig alloc]init];
    config.itemWidth = kScreenWidth/4.0;
    
    _itemControlView = [[WXWitemsView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-50, 80)];
    //    _itemControlView
    _itemControlView.tapAnimation = YES;
    _itemControlView.config = config;
    _itemControlView.titleArray = _titeArr;
    
    _itemControlView.delegate1 = self;

    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setImage:[UIImage imageNamed:@"addh"] forState:UIControlStateNormal];
    [self.view addSubview:addBtn];
    addBtn.frame = CGRectMake(kScreenWidth-50, 20, 35, 35);
    [addBtn addTarget:self action:@selector(addBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:_itemControlView];
    
    
//    [self creatHeardView];
    [self creatmainTabelView];
    
    
    
}
-(void)creatmainTabelView
{
    _mainTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, kScreenWidth, kScreenHeight-83) style:UITableViewStyleGrouped];
    _mainTabelView.delegate = self;
    _mainTabelView.dataSource = self;
//    [_mainTabelView registerNib:[UINib nibWithNibName:@"MKTHometabelCell"bundle:nil] forCellReuseIdentifier:@"MKTHometabelCell"];
    

    [self.view addSubview:_mainTabelView];
    
}
#pragma mark - tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arc4random_uniform(3)+1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_itemControlView.currentIndex>0) {
        return 1;
    }else{
        return _titeArr.count;
    }
    
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    if (_itemControlView.currentIndex>0) {
        return _titeArr[_itemControlView.currentIndex];
    }else{
        return _titeArr[section];
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKTCell"];
    if (!cell) {
        cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKTCell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"test-%ld ,%ld",indexPath.section,indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
-(void)addBtn
{
    for (UIView *vie in _itemControlView.subviews) {
        [vie removeFromSuperview];
    }
    MKTChannelVC *vc = [[MKTChannelVC alloc] init];
    
    vc.delegate  = self;
    vc.acontArr = _titeArr;
    [self.navigationController pushViewController:vc animated:YES];

}
-(void)setTapItemWithIndex:(NSInteger)index{
     [self.mainTabelView reloadData];
}

-(void)chaniTitleScr:(NSArray *)array1
{
    
    NSMutableArray *tapArr = [NSMutableArray array];
    [tapArr addObject:@"热门"];
    for (int i  = 0; i<array1.count; i++) {
        [tapArr addObject:array1[i]];
    }
    
    _titeArr  = (NSArray *)tapArr;
    
    _itemControlView.currentIndex =0;
    _itemControlView.titleArray = _titeArr;
    [self.mainTabelView reloadData];
}
-(void)viewWillAppear:(BOOL)animated
{
     self.navigationController.navigationBarHidden = YES;
}
@end
