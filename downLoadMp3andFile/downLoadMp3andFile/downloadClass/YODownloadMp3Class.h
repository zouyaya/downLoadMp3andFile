//
//  YODownloadMp3Class.h
//  downLoadMp3andFile
//
//  Created by izaodao on 17/3/16.
//  Copyright © 2017年 izaodao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface YODownloadMp3Class : NSObject

//播放器
@property (nonatomic,strong)AVAudioPlayer *player;



/**
 实例化单利对象
 */

+(YODownloadMp3Class *)defaultYODownloadMp3Class;


/**
 *bookWordID  单词本单词的ID既 bw_uID
 *
 *tagert   谁调动，一般是self
 *
 *kind  播放的类型 默认是0 既下载就播放
 */
-(void)downloadSoundMp3WithBookWordID:(int)bookWordID andtarget:(id)tagert andPlayKind:(int)kind;

@end
