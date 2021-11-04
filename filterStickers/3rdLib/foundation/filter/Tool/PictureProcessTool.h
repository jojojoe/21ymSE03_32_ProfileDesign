//
//  PictureProcessTool.h
//  filterStickers
//
//  Created by mac on 2021/10/8.
//

#import <Foundation/Foundation.h>

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <UIKit/UIKit.h>


@interface PictureProcessTool : NSObject

+ (UIImage *)imageWithImage:(UIImage*)inImage withColorMatrix:(const float*)f;

@end
