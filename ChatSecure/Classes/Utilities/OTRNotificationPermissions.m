//
//  OTRNotificationPermissions.m
//  ChatSecure
//
//  Created by David Chiles on 10/1/14.
//  Copyright (c) 2014 Chris Ballinger. All rights reserved.
//

#import "OTRNotificationPermissions.h"
#import "OTRUtilities.h"
#import "ZeroPush.h"

static const UIUserNotificationType USER_NOTIFICATION_TYPES_REQUIRED = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
static const UIRemoteNotificationType REMOTE_NOTIFICATION_TYPES_REQUIRED = UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;

@implementation OTRNotificationPermissions

+ (void)iOS7AndBelowPermissions
{
    [[ZeroPush shared] registerForRemoteNotifications];
}

+ (void)iOS8AndAbovePermissions;
{
    if (![self canSendNotifications]) {
        [[ZeroPush shared] registerForRemoteNotifications];
    }
}

+ (void)checkPermissions
{
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        [self iOS8AndAbovePermissions];
    }
    else {
        [self iOS7AndBelowPermissions];
    }
}

+ (bool)canSendNotifications
{
    if (SYSTEM_VERSION_LESS_THAN(@"8.0")) {
        return YES;
    }
    
    UIUserNotificationSettings* notificationSettings = [[UIApplication sharedApplication] currentUserNotificationSettings];
    bool canSendNotifications = notificationSettings.types == USER_NOTIFICATION_TYPES_REQUIRED;
    
    return canSendNotifications;
}


@end
