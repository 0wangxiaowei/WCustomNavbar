//
//  MKTChannelVC.h
//  marketing
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 xiaowei. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol chaniTitleScrDelegate <NSObject>

-(void)chaniTitleScr:(NSArray *)array1;

@end
@interface MKTChannelVC : UIViewController
@property (assign, nonatomic) id<chaniTitleScrDelegate> delegate;
@property (nonatomic,strong)NSArray *acontArr;
@end
