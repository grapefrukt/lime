#import <AppKit/NSWorkspace.h>
#import <Cocoa/Cocoa.h>
#include <string>
#include <vector>
#include <sys/types.h>
#include <sys/sysctl.h>


namespace lime {

	bool LaunchBrowser(const char *inUtf8URL) {

		#ifndef OBJC_ARC
			NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		#endif

		NSString *str = [[NSString alloc] initWithUTF8String:inUtf8URL];
		[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString: str]];
		
		#ifndef OBJC_ARC
			[str release];
			[pool drain];
		#endif

		return true;

	}

	std::string CapabilitiesGetLanguage() {

		#ifndef OBJC_ARC
			NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		#endif

		NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
		std::string result = (language?[language UTF8String]:"");
		
		#ifndef OBJC_ARC
			[pool drain];
		#endif

		return result;

	}

	double CapabilitiesGetScreenDPI() {

		#ifndef OBJC_ARC
			NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		#endif
		
		NSScreen *screen = [NSScreen mainScreen];
		NSDictionary *description = [screen deviceDescription];

		float displayScale = 1;
		if ([screen respondsToSelector:@selector(backingScaleFactor)]) {
			displayScale = [screen backingScaleFactor];
		}

		NSSize displayPixelSize = [[description objectForKey:NSDeviceSize] sizeValue];

		displayPixelSize.width *= displayScale;
		displayPixelSize.height *= displayScale;

		CGSize displayPhysicalSize = 
				CGDisplayScreenSize( [[description objectForKey:@"NSScreenNumber"] unsignedIntValue] );
		double diagonalRes = sqrt(displayPixelSize.width * displayPixelSize.width + displayPixelSize.height * displayPixelSize.height);
		// size is reported in millimeters, mutliply with magic number to get inches
		double diagonalSize = sqrt(displayPhysicalSize.width * displayPhysicalSize.width + displayPhysicalSize.height * displayPhysicalSize.height) * 0.0393701;		
		
		#ifndef OBJC_ARC
			[pool drain];
		#endif

		return diagonalRes / diagonalSize;
	}

	double CapabilitiesGetPixelAspectRatio() {

		#ifndef OBJC_ARC
			NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		#endif
		
		NSScreen *screen = [NSScreen mainScreen];
		NSDictionary *description = [screen deviceDescription];
		NSSize displayPixelSize = [[description objectForKey:NSDeviceSize] sizeValue];
		CGSize displayPhysicalSize = 
				CGDisplayScreenSize( [[description objectForKey:@"NSScreenNumber"] unsignedIntValue] );

		double result = (displayPixelSize.width / displayPhysicalSize.width) / (displayPixelSize.height / displayPhysicalSize.height);
		
		#ifndef OBJC_ARC
			[pool drain];
		#endif

		return result;

	}

	std::string FileDialogOpen( const std::string &title, const std::string &text, const std::vector<std::string> &fileTypes ) {
	    
	    // NSArray *fileTypes = [NSArray arrayWithObjects:@"jpg",@"jpeg",nil];
	    
	    NSOpenPanel * panel = [NSOpenPanel openPanel];

		    [panel setAllowsMultipleSelection:NO];
		    [panel setCanChooseDirectories:NO];
		    [panel setCanChooseFiles:YES];
		    [panel setFloatingPanel:YES];
		    [panel setTitle: [NSString stringWithCString:title.c_str() encoding:[NSString defaultCStringEncoding]] ]; 

	    NSInteger result = [ panel runModalForDirectory:NSHomeDirectory() file:nil types:nil ];

	    if(result == NSOKButton) {
	         NSString *pathfile = [[panel URL] path];

	    		std::string _path = std::string( [pathfile UTF8String] );
	    		[pathfile release];
	    		
	    	return _path;
	    }

		return std::string();

	} //FileDialogOpen
	

	std::string FileDialogSave( const std::string &title, const std::string &text, const std::vector<std::string> &fileTypes ) {

		NSSavePanel *panel = [NSSavePanel savePanel];

			[panel setAllowsOtherFileTypes:YES];
		    [panel setExtensionHidden:YES];
		    [panel setCanCreateDirectories:YES];
		    // [panel setNameFieldStringValue:filename];
		    [panel setTitle: [NSString stringWithCString:title.c_str() encoding:[NSString defaultCStringEncoding]] ]; 

	    NSInteger result = [panel runModal];
	    NSError *error = nil;

	    if (result == NSOKButton) {
	    	NSString *pathfile = [[panel URL] path];

	    		std::string _path = std::string( [pathfile UTF8String] );
	    		[pathfile release];

	    	return _path;
	    }

	    return std::string();

	} //FileDialogSave
	
	std::string FileDialogFolder( const std::string &title, const std::string &text ) {

		NSOpenPanel * panel = [NSOpenPanel openPanel];

		    [panel setAllowsMultipleSelection:NO];
		    [panel setCanChooseDirectories:YES];
		    [panel setCanChooseFiles:NO];
		    [panel setFloatingPanel:YES];
		    [panel setTitle: [NSString stringWithCString:title.c_str() encoding:[NSString defaultCStringEncoding]] ]; 

	    NSInteger result = [ panel runModalForDirectory:NSHomeDirectory() file:nil types:nil ];

	    if(result == NSOKButton) {
	        NSString *pathfile = [[panel URL] path];

	    		std::string _path = std::string( [pathfile UTF8String] );
	    		[pathfile release];
	    		
	    	return _path;
	    } //result

		return std::string();

	} //FileDialogFolder

}