//
//  VoiceDownloadPath.m
//  downLoadMp3andFile
//
//  Created by izaodao on 17/3/16.
//  Copyright © 2017年 izaodao. All rights reserved.
//

#import "VoiceDownloadPath.h"
#import "MyMD5.h"

@implementation VoiceDownloadPath

+(VoiceDownloadPath *)shareVoiceDownloadPath{
    static VoiceDownloadPath *voicepath = nil;
    if (voicepath == nil) {
        voicepath = [[VoiceDownloadPath alloc]init];
    }
    return voicepath;

}

-(NSString *)makeWordDownloadWayAccrodingToWordID:(int)wordID andWord:(NSString *)wordStr{
    NSString *info = [[DataManager shareManager]getTheWordPronunceSyllaleValueAccordingToTheWordID:wordID];
    NSString *preDownLoadStr = [NSString stringWithFormat:@"%@%@",k_downLoadSoundsFileDomain,info];
    NSMutableString *lastStr = [[NSMutableString alloc]initWithString:preDownLoadStr];
    return lastStr;
    
}
-(NSString *)makeBackLockedWayToSaveLoadAccrodingToWordID:(int)wordID
{
    NSString *info = [[DataManager shareManager]getTheWordPronunceSyllaleValueAccordingToTheWordID:wordID];
    NSString *infostr = [[info componentsSeparatedByString:@"."] firstObject];
    NSString *lastInfo = [MyMD5 md5:infostr];
    return lastInfo;
    
}


@end
