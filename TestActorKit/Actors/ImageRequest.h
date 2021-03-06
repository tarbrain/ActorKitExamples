//
//  ImageRequest.h
//  TestActorKit
//
//  Created by Julian Krumow on 21.08.15.
//  Copyright (c) 2015 Julian Krumow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ActorKit/Supervision.h>

@interface ImageRequest : NSObject
- (void)fetchImageAtUrl:(NSURL *)url;
@end
