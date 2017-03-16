//
//  DataManager.h
//  downLoadMp3andFile
//
//  Created by izaodao on 17/3/16.
//  Copyright © 2017年 izaodao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YOWordModel.h"

@interface DataManager : NSObject
+(DataManager *)shareManager;

-(NSString *)getTheWordPronunceSyllaleValueAccordingToTheWordID:(int)wordID;

-(YOWordModel *)getWordAndWordIDAccrodingToBookWordID:(int)bookWordID;


-(int)selectBookWordIDAccordingTOtheDataBaseRandom;

@end
