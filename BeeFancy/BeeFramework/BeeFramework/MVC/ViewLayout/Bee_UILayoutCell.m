//
//	 ______    ______    ______    
//	/\  __ \  /\  ___\  /\  ___\   
//	\ \  __<  \ \  __\_ \ \  __\_ 
//	 \ \_____\ \ \_____\ \ \_____\ 
//	  \/_____/  \/_____/  \/_____/ 
//
//	Copyright (c) 2012 BEE creators
//	http://www.whatsbug.com
//
//	Permission is hereby granted, free of charge, to any person obtaining a
//	copy of this software and associated documentation files (the "Software"),
//	to deal in the Software without restriction, including without limitation
//	the rights to use, copy, modify, merge, publish, distribute, sublicense,
//	and/or sell copies of the Software, and to permit persons to whom the
//	Software is furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//	IN THE SOFTWARE.
//
//
//  Bee_UIQuery.m
//

#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

#import "Bee_Precompile.h"
#import "Bee_UIStyle.h"
#import "Bee_UIQuery.h"
#import "Bee_UILayoutCell.h"
#import "UIView+BeeExtension.h"
#import "UIView+BeeUILayout.h"
#import "NSArray+BeeExtension.h"

#import "JSONKit.h"
#import <objc/runtime.h>

#pragma mark -

@implementation BeeUILayoutCell

+ (NSString *)resourceName
{
	return [NSString stringWithFormat:@"%@.xml", [[self class] description]];
}

+ (CGSize)sizeInBound:(CGSize)bound forData:(NSObject *)data
{
	return bound;
}

- (void)layoutInBound:(CGSize)bound forCell:(BeeUIGridCell *)cell
{
    [super layoutInBound:bound forCell:cell];

    self.RELAYOUT();
}

- (void)load
{
    [super load];

	NSString * resName = [[self class] resourceName];
	if ( resName )
	{
		self.FROM_RESOURCE( resName );
	}
	
#if defined(__BEE_WIREFRAME__) && __BEE_WIREFRAME__
    $(@"*").EACH( ^( UIView * view ) {
        view.hintString = view.tagString;
    });
#endif	// #if defined(__BEE_WIREFRAME__) && __BEE_WIREFRAME__
}

- (void)unload
{
    [super unload];
}

@end

#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)
