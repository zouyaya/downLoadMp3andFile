//
//  ViewController.m
//  downLoadMp3andFile
//
//  Created by izaodao on 17/3/16.
//  Copyright © 2017年 izaodao. All rights reserved.
//

#import "ViewController.h"
#import "DataManager.h"
#import "YODownloadMp3Class.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    UIButton *clikckButton = [UIButton buttonWithType:UIButtonTypeCustom];
    clikckButton.backgroundColor = [UIColor blueColor];
    [clikckButton setTitle:@"点击播放音频" forState:UIControlStateNormal];
    clikckButton.frame = CGRectMake(50, 100, 275, 50);
    [clikckButton addTarget:self action:@selector(pressToDownloadToPlay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clikckButton];
    
    
    
}


-(void)pressToDownloadToPlay{
  int bookWordID = [[DataManager shareManager]selectBookWordIDAccordingTOtheDataBaseRandom];
    [[YODownloadMp3Class defaultYODownloadMp3Class]downloadSoundMp3WithBookWordID:bookWordID andtarget:self andPlayKind:0];


}

@end
