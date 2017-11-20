//
//  MiguDowmloadBaseManager.h
//  MiguMusic
//
//  Created by 刘殿阁 on 2017/9/24.
//  Copyright © 2017年 刘殿阁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MiguDownloadItem.h"


#define  MAXTASK_COUNT  3

@interface MiguDowmloadBaseManager : NSObject

+ (instancetype)shareManager;
#pragma mark - 重写相关的属性
// 存放需要下载的数组
@property (nonatomic, strong) NSMutableArray *downloadArray;
/**
 *
 *    开始下载
 */
- (void)downloadWithUrl:(NSString *)downloadUrl;
/**
 *
 *    暂停某一首歌曲
 */
- (void)suspendWithUrl:(NSString *)url;
/**
 *
 *   暂停所有的歌曲
 */
- (void)suspendAllRequest;
/**
 *
 *   恢复下载一首歌曲
 */
- (void)resumeWithUrl:(NSString *)url;
/**
 *
 *   恢复所有暂停的歌曲
 */
- (void)resumeAllRequest;
/**
 *
 *   取消一首歌曲
 */
- (void)cancelWithUrl:(NSString *)url;
/**
 *
 *   取消所有歌曲
 */
- (void)cancelAllRequest;











@end
