//
//  DataTool.h
//  filterStickers
//
//  Created by mac on 2021/10/8.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DataTool : NSObject

+(NSMutableArray *)pictureProcessData:(UIImage *)image;
+(UIImage *)pictureProcessData:(UIImage *)image matrixName: (NSString *)name ;
@end
