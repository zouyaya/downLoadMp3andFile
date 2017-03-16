//
//  DataManager.m
//  downLoadMp3andFile
//
//  Created by izaodao on 17/3/16.
//  Copyright © 2017年 izaodao. All rights reserved.
//

#import "DataManager.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "FMDatabaseAdditions.h"
#import "YOWordModel.h"


@interface DataManager ()
@property (nonatomic,assign)BOOL isRelease;
@property (nonatomic,strong)NSString *dbPath;
@property(nonatomic, strong)FMDatabaseQueue *queue;

@end

@implementation DataManager
{
    FMDatabase *_fmdb;

}

@synthesize isRelease = _isRelease;
@synthesize dbPath    = _dbPath;



+(DataManager *)shareManager{
    static DataManager *manager = nil;
    if (manager == nil) {
        manager = [[DataManager alloc]init];
    }else{
        if (manager.isRelease) {
            manager = nil;
            manager = [[DataManager alloc]init];
        }
        
    }
    return manager;
}

-(instancetype)init{
    self = [super init];
    if (self) {
     
        _isRelease = NO;
        NSString *kFilename = @"Word.db";
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docDir = [paths objectAtIndex:0];
        NSLog(@"----------------------%@",docDir);
        NSString *strPaths = [docDir stringByAppendingFormat:@"/%@",kFilename];
        NSLog(@"%@",strPaths);
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:strPaths]) {
            
            NSString *pathDb = [[NSBundle mainBundle] pathForResource:@"Word" ofType:@"db"];
            BOOL result =  [fileManager copyItemAtPath:pathDb toPath:strPaths error:nil];
            if (result) {
                NSLog(@"数据库拷贝成功");
                
            } else {
                
                NSLog(@"数据库拷贝失败");
            }
            
        } else {
            
            NSLog(@"数据库存在");
        }
        _fmdb = [[FMDatabase alloc]initWithPath:strPaths];
        _queue = [FMDatabaseQueue databaseQueueWithPath: strPaths];
        BOOL isOpen = [_fmdb open];
        if (isOpen) {
            NSLog(@"数据库打开成功");
        }else{
            
            NSLog(@"数据库打开失败 %@",_fmdb.lastErrorMessage);
        }
        self.dbPath = strPaths;
        
        NSLog(@"%@",self.dbPath);
        
        
        
        
    }
    return self;




}

#warning 改动处
-(NSString *)getTheWordPronunceSyllaleValueAccordingToTheWordID:(int)wordID
{

        NSString *prounceValue = @"";
        NSString *sql = [NSString stringWithFormat:@"select w_sPronunce \
                                                     from lib_word\
                                                     where w_uId = %d",wordID];
        prounceValue = [_fmdb stringForQuery:sql];
        return prounceValue;
    
}

#warning 改动处
-(YOWordModel *)getWordAndWordIDAccrodingToBookWordID:(int)bookWordID{
    
    __block YOWordModel *model;
    
    [self.queue inDatabase:^(FMDatabase *db) {
        
        model = [[YOWordModel alloc]init];
        NSString *sql = [NSString stringWithFormat:@"select w_uId,w_sWord \
                         from lib_word ,lib_book_word \
                         where lib_word.w_uId = lib_book_word.f_w_uId and bw_uId = %d",bookWordID];
        FMResultSet *restult = [db executeQuery:sql];
        while (restult.next) {
            model.wordID = [restult intForColumn:@"w_uId"];
            model.word   = [restult stringForColumn:@"w_sWord"];
        }
        
    }];
    return model;
 
}

-(int)selectBookWordIDAccordingTOtheDataBaseRandom{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    NSString *sql = @"select bw_uId from lib_book_word where f_b_uId = 3";
    FMResultSet *result = [_fmdb executeQuery:sql];
    while (result.next) {
        NSString *bookWord = [result stringForColumn:@"bw_uId"];
        [array addObject:bookWord];
    }
    int index = arc4random()%(array.count);
    int bookWordId = [array[index] intValue];
   
    

    
    
    return bookWordId;


}
@end
