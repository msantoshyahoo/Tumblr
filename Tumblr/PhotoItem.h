//
//  PhotoItem.h
//  Tumblr
//
//  Created by  Santosh Sharanappa Mandi on 1/25/17.
//  Copyright © 2017  Santosh Sharanappa Mandi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoItem : NSObject
@property NSString *postid;
@property NSURL *url;
- (instancetype) initWithDictionary: (NSDictionary *) jsonDictionary;
@end
