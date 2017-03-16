//
//  VoiceDownloadPath.h
//  downLoadMp3andFile
//
//  Created by izaodao on 17/3/16.
//  Copyright © 2017年 izaodao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "AFNetworking.h"
#import "DataManager.h"
#import "AFHTTPSessionManager.h"

@interface VoiceDownloadPath : NSObject
@property (nonatomic,strong)AVAudioPlayer *player;
@property (nonatomic,strong)AFURLSessionManager *sessionManager;


+(VoiceDownloadPath *)shareVoiceDownloadPath;

/**
 根据单词本单词ID 生成下载路径
 */
- (NSString *)makeWordDownloadWayAccrodingToWordID:(int)wordID andWord:(NSString *)wordStr;

/**
 根据单词的ID生成存储存储的相应名字
 */
- (NSString *)makeBackLockedWayToSaveLoadAccrodingToWordID:(int)wordID;

@end
