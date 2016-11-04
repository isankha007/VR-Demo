//
//  ValidationClass.m
/********************************************//*!
* @file ValidationClass.m
* @brief Contains constants and global parameters
* Skoop! Inc. ("COMPANY") CONFIDENTIAL
* Unpublished Copyright (c) 2015-2016 Skoop! Inc., All Rights Reserved.
***********************************************/


#import "ValidationClass.h"

@implementation ValidationClass
+(NSString*)NullCheckString:(NSString*)string{
    if ([string isEqual:[NSNull null]]) {
        return @"";
    }
    else if ([string isEqualToString:@"<null> <null>"]) {
        return @"";
    }    
    else if ([string isEqualToString:@"<null>"]) {
        return @"";
    }
    else if ([string isEqualToString:@"<Null>"]){
        return @"";
    }
    else if ([string isEqualToString:@"<NULL>"]){
        return @"";
    }
    else if ([string isEqualToString:@"(null)"]){
        return @"";
    }
    else if ([string isEqualToString:@"(Null)"]){
        return @"";
    }
    else if ([string isEqualToString:@"null"]){
        return @"";
    }
    else if ([string isEqualToString:@"(NULL)"]){
        return @"";
    }
    else if (string.length==0){
        return @"";
    }
    else {
        return string;
    }
}
+(void)bubbleSortArray:(NSMutableArray*)unsortedArray{
    while (TRUE) {
        BOOL hasSwapped = NO;
        for (int i=0; i<unsortedArray.count; i++){
            /** out of bounds check */
            if (i < unsortedArray.count-1){
                NSUInteger currentIndexValue = [unsortedArray[i] intValue];
                NSUInteger nextIndexValue = [unsortedArray[i+1] intValue];
                if (currentIndexValue > nextIndexValue){
                    hasSwapped = YES;
                    [self swapFirstIndex:i withSecondIndex:i+1 inMutableArray:unsortedArray];
                }
            }
        }
        /** already sorted, break out of the while loop */
        if (!hasSwapped){
            break;
        }
    }
}

+(void)swapFirstIndex:(NSUInteger)firstIndex withSecondIndex:(NSUInteger)secondIndex inMutableArray:(NSMutableArray*)array{
    NSNumber* valueAtFirstIndex = array[firstIndex];
    NSNumber* valueAtSecondIndex = array[secondIndex];
    [array replaceObjectAtIndex:firstIndex withObject:valueAtSecondIndex];
    [array replaceObjectAtIndex:secondIndex withObject:valueAtFirstIndex];
}

+(CGFloat)getLabelHeight:(NSString*)str font:(UIFont*)font label:(UILabel*)label
{
    CGRect rect1=[str boundingRectWithSize:CGSizeMake(label.frame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin
                                 attributes:@{NSFontAttributeName:font}
                                    context:nil];
    
    return rect1.size.height;
}
/********************************************//*!
* @brief This method is used to check valid email address.
* @param[in] candidate as NSString.
* @param[out] BOOL [return YES if Success else NO].
***********************************************/

+ (BOOL)validatemailid: (NSString *) candidate
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}

/********************************************//*!
 * @brief This method is used to check password validation with Minimum 8 character,atleast one english capital letter,one english small letter,One digit and one special character.
 * @param[in] password as NSString.
 * @param[out] BOOL [return YES if Success else NO].
 ***********************************************/

+(BOOL)isValidPassword:(NSString*)password
{
    /*Minimum 8 character
     Atleast one english capital letter
     One english small letter
     One digit
     One special character (#?!@$%^&*-)*/
    
    NSString *numericRegex = @"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[?!$%*]).{8,}$";//@"^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-zA-Z0-9]).{8,100}$";
    NSPredicate *numericTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numericRegex];
    return [numericTest evaluateWithObject:password];
}

/********************************************//*!
* @brief This method is used to check Null string.
* @param[in] textString as NSString.
* @param[out] BOOL [return YES if Success else NO].
***********************************************/

+ (BOOL)isNullString:(NSString *)textString
{
    if (textString == nil || textString == (id)[NSNull null] || [[NSString stringWithFormat:@"%@",textString] length] == 0 || [[[NSString stringWithFormat:@"%@",textString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
@end
