/********************************************//*!
* @file ValidationClass.h
* @brief Contains constants and global parameters
* Sankhadeep! Inc. ("COMPANY") CONFIDENTIAL
* Unpublished Copyright (c) 2015-2016 Sankhadeep! Inc., All Rights Reserved.
***********************************************/

#import <Foundation/Foundation.h>

@interface ValidationClass : NSObject
+(NSString*)NullCheckString:(NSString*)string;
+(void)bubbleSortArray:(NSMutableArray*)unsortedArray;
+(CGFloat)getLabelHeight:(NSString*)str font:(UIFont*)font label:(UILabel*)label;
+ (BOOL)validatemailid: (NSString *) candidate;
+(BOOL)isValidPassword:(NSString*)password;
+ (BOOL)isNullString:(NSString *)textString;
@end
