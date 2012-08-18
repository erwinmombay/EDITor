//
//  EDINode.m
//  Docz
//
//  Created by Erwin Mombay on 8/16/12.
//  Copyright (c) 2012 win. All rights reserved.
//

#import "EDINode.h" 

@implementation EDINode

- (id)initWithLabel:(NSString *)label
            ediName:(NSString *)ediName
           nodeType:(NSString *)nodeType
         collection:(id)collection {
    self = [super init];
    if (self) {
        _label = label;
        _ediName = ediName;
        _nodeType = nodeType;
        _collection = collection;
    }
    return self;
}

+ (NSArray *)createEDINodesFromDictionary:(NSDictionary *)dict {
    NSMutableArray *models = [[NSMutableArray alloc] init];
    [[dict objectForKey:@"collection"] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [models addObject:[[EDINode alloc] initWithLabel:[obj objectForKey:@"name"]
                                                 ediName:[obj objectForKey:@"fullName"]
                                                nodeType:@"s"
                                              collection:[obj objectForKey:@"collection"]]];
    }];
    return [models sortedArrayUsingComparator:^(id obj1, id obj2) {
        static NSString *sep = @"_";
        NSString *name1 = [[((EDINode *)obj1).ediName componentsSeparatedByString:sep] lastObject];
        NSString *name2 = [[((EDINode *)obj2).ediName componentsSeparatedByString:sep] lastObject];
        return [name1 caseInsensitiveCompare:name2];
    }];

}

@end