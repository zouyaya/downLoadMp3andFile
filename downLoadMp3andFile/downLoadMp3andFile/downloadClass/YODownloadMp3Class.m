//
//  YODownloadMp3Class.m
//  downLoadMp3andFile
//
//  Created by izaodao on 17/3/16.
//  Copyright © 2017年 izaodao. All rights reserved.
//

#import "YODownloadMp3Class.h"
#import "DataManager.h"
#import "VoiceDownloadPath.h"
#import "YOWordModel.h"
#import "MyMD5.h"

@implementation YODownloadMp3Class
@synthesize player   = _player;

+(YODownloadMp3Class *)defaultYODownloadMp3Class{
    static YODownloadMp3Class *MP3DownloadManager = nil;
    if (MP3DownloadManager == nil) {
        MP3DownloadManager = [[YODownloadMp3Class alloc]init];
    }
    return MP3DownloadManager;
}


-(void)downloadSoundMp3WithBookWordID:(int)bookWordID andtarget:(id)tagert andPlayKind:(int)kind
{
    NSArray *firstPathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *firthPath = [firstPathArray firstObject];
    NSString *allFilePath = [firthPath stringByAppendingPathComponent:@"MP3File"];
    YOWordModel *wordModel = [[DataManager shareManager] getWordAndWordIDAccrodingToBookWordID:bookWordID];
    NSString *nameFile = [[VoiceDownloadPath shareVoiceDownloadPath]makeBackLockedWayToSaveLoadAccrodingToWordID:wordModel.wordID];
    NSString *downloadPath = [[VoiceDownloadPath shareVoiceDownloadPath]makeWordDownloadWayAccrodingToWordID:wordModel.wordID andWord:wordModel.word];
    NSString *destinationFile = [nameFile stringByAppendingString:@".mp3"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *mp3FielPath = [NSString stringWithFormat:@"%@/MP3File",firthPath];
    BOOL isDir = NO;
    BOOL isExisted = [fileManager fileExistsAtPath:mp3FielPath isDirectory:&isExisted];
    if (!(isDir == YES && isExisted == YES)) {
        [fileManager createDirectoryAtPath:mp3FielPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
    
    
        [fileManager createDirectoryAtPath:allFilePath withIntermediateDirectories:YES attributes:nil error:nil];
        NSString *lastPath = [allFilePath stringByAppendingPathComponent:destinationFile];
        BOOL isExistTheMp3File = [fileManager fileExistsAtPath:lastPath];
    
    
        if (isExistTheMp3File) {
            //mp3文件已存在
            [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
            _player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:lastPath] error:nil];
            _player.delegate = tagert;
            [_player play];
          
            
        
         }else{
        
        [self reDownloadWithPath:downloadPath andKind:kind andTarget:tagert andIsON:0 andWordID:wordModel.wordID];
        
          }
    
}
-(void)reDownloadWithPath:(NSString *)downloadPath andKind:(int)kind andTarget:(id)target andIsON:(int)isOn andWordID:(int)wordID{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *sessionManager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
    NSString *lastString = @"";
    if ([downloadPath containsString:@" "]) {
        NSMutableString *string = [[NSMutableString alloc]initWithString:downloadPath];
        NSArray *newArray = [string componentsSeparatedByString:@" "];
        NSString *newString = [newArray componentsJoinedByString:@"%20"];
        lastString = newString;
    }else{
        lastString = downloadPath;
    }
    NSURLRequest *requestSound = [NSURLRequest requestWithURL:[NSURL URLWithString:lastString]];
    NSURLSessionDownloadTask *downloadTask = [sessionManager downloadTaskWithRequest:requestSound progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSURL *downloadURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        NSString *tempString = [[[response suggestedFilename]componentsSeparatedByString:@"."]firstObject];
        NSString *secString =[[[response suggestedFilename]componentsSeparatedByString:@"."]lastObject];
        NSString *lastName = [[MyMD5 md5:tempString]stringByAppendingString:[NSString stringWithFormat:@".%@",secString]];
        return [downloadURL URLByAppendingPathComponent:[NSString stringWithFormat:@"MP3File/%@",lastName]];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSData *data = [NSData dataWithContentsOfURL:filePath];
        [data writeToURL:filePath atomically:YES];
        _player = [[AVAudioPlayer alloc]initWithContentsOfURL:filePath error:nil];
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
        _player.delegate = target;
        [_player play];
        
    }];
    
    [downloadTask resume];
    
    
}


@end
