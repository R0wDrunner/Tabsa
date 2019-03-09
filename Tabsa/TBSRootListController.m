#include "TBSRootListController.h"
#import <CepheiPrefs/HBRootListController.h>
#import <CepheiPrefs/HBAppearanceSettings.h>
#import <Cephei/HBPreferences.h>
#define xTitleIconPath	@"/Library/PreferenceBundles/Tabsa.bundle/icon2@2x.png"


@implementation TBSRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}

- (void)setTitle:(id)title {
	[super setTitle:title];

	UIImage *icon = [[UIImage alloc] initWithContentsOfFile:xTitleIconPath];
	if (icon) {
		UIImageView *iconView = [[UIImageView alloc] initWithImage:icon];
		self.navigationItem.titleView = iconView;
	}
}

-(void)respring {
	UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Respring"
                           message:@"Are you sure you want to respring?"
                           preferredStyle:UIAlertControllerStyleAlert];

UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
}];

UIAlertAction* defaultAction2 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
																 system("killall -9 SpringBoard");
}];

[alert addAction:defaultAction];
[alert addAction:defaultAction2];
[self presentViewController:alert animated:YES completion:nil];
}

@end
