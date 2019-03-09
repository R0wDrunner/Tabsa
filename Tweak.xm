#import <UIKit/UIKit.h>
#import <UIKit/UIDevice.h>
#import <Preferences/PSViewController.h>
#import <UIKit/UIAppearance.h>

#define TweakEnabled PreferencesBool(@"tweakEnabled", YES)
#define FlatBar PreferencesBool(@"flatBar", YES)


#define SETTINGS_PLIST_PATH @"/var/mobile/Library/Preferences/com.r0wdrunner.tabsa.plist"

static NSDictionary *preferences;
static BOOL PreferencesBool(NSString* key, BOOL fallback)
  {
      return [preferences objectForKey:key] ? [[preferences objectForKey:key] boolValue] : fallback;
  }

static void PreferencesChangedCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    [preferences release];
    CFStringRef appID = CFSTR("com.r0wdrunner.tabsa");
    CFArrayRef keyList = CFPreferencesCopyKeyList(appID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
    preferences = (NSDictionary *)CFPreferencesCopyMultiple(keyList, appID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
    CFRelease(keyList);
  }

%ctor
  {
        preferences = [[NSDictionary alloc] initWithContentsOfFile:SETTINGS_PLIST_PATH];

        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)PreferencesChangedCallback, CFSTR("com.r0wdrunner.tabsa-prefsreload"), NULL, CFNotificationSuspensionBehaviorCoalesce);
  }

@interface BrowserController
-(void) _initSubviews;
-(bool) _isScreenSizeBigEnoughForTabBar;
-(void) setShowingTabBar:(bool)arg1;
-(void) _setShowingTabBar:(bool)arg1 animated:(bool)arg2;
@end

@interface _SFNavigationBarURLButtonBackgroundView : UIView
@end

%hook _SFNavigationBarURLButtonBackgroundView //SAFARI FLAT URL
  -(void) didMoveToWindow {
    if(TweakEnabled && FlatBar) {
      %orig();
      self.hidden = FlatBar;
    } else {
      %orig();
  }
}
%end

%hook BrowserController
-(id)loadView {
  self = %orig;
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"WrongPasscode" message:[NSString stringWithFormat:@"You entered:"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; [alert release];
  UIDevice *device = [UIDevice currentDevice];
  [device beginGeneratingDeviceOrientationNotifications];
  NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
  [nc addObserver:self selector:@selector(orientationChanged:)        name:UIDeviceOrientationDidChangeNotification
           object:device];

  return self;
}
  -(void) _setShowingTabBar:(bool)arg1 animated:(bool)arg2 {
      if(TweakEnabled) {
        %orig(YES,YES);
      } else {
        %orig;
      }
    }
    -(bool) _isScreenSizeBigEnoughForTabBar:(CGSize) arg1 {
      if(TweakEnabled) {
        return YES;
      } else {
        return %orig;
      }
    }
    %new
        - (void)orientationChanged:(NSNotification *)note
        {
          [self setShowingTabBar:YES];
        }

%end
