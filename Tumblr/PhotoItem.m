//
//  PhotoItem.m
//  Tumblr
//
//  Created by  Santosh Sharanappa Mandi on 1/25/17.
//  Copyright © 2017  Santosh Sharanappa Mandi. All rights reserved.
//

#import "PhotoItem.h"

@implementation PhotoItem

- (instancetype) initWithDictionary: (NSDictionary *) jsonDictionary{
    self = [super init];
    if(self){
        self.postid = jsonDictionary[@"id"];
        NSArray *photos = jsonDictionary[@"photos"];
        NSDictionary *singlePhoto = photos[0];
        NSDictionary *originalSize = singlePhoto[@"original_size"];
        NSString *urlString = originalSize[@"url"];
        self.url = [NSURL URLWithString:urlString];
    }
    return self;
}
@end
