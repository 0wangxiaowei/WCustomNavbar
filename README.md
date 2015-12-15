# WCustomNavbar
自定义导航标签，可添加或者改变标签顺序
```
   WJItemsConfig *config = [[WJItemsConfig alloc]init];
    config.itemWidth = kScreenWidth/4.0;
    
    _itemControlView = [[WXWitemsView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-50, 80)];
   
    _itemControlView.tapAnimation = YES;
    _itemControlView.config = config;
    _itemControlView.titleArray = _titeArr;
    
    _itemControlView.delegate1 = self;
   [self.view addSubview:_itemControlView];
```
##效果图
![效果](https://github.com/0wangxiaowei/WCustomNavbar/blob/master/WCustomNavbar/iron/effect.gif)  
