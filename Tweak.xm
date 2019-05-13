/*
	DoubleTweetLength version 1.0
	(C) 2019 InvoxiPlayGames
*/

%hook TwitterText
+(int)remainingCharacterCount:(id)arg1 httpURLLength:(int)arg2 httpsURLLength:(int)arg3
{
	/* I don't have to explain this one. Adds an extra 140 characters to the remaining character count. */
	return %orig + 140;
}
%end

%hook TFNTwitterComposition
-(int)_maximumCharacterCount
{
	/* I don't have to explain this one. Adds an extra 140 characters to the maximum character count for newer versions of Twitter.
	   Also has a check to make sure 280 characters isn't already enabled in some form because I know somebody out there will try it. */
	int original = %orig;
	if (original == 280) {
		return original;
	} else {
		return original + 140;
	}
}
%end

%hook TFNTwitterAPI
+(id)baseRequestWithPartialURL:(id)arg1 parameters:(id)arg2 multiPartFormData:(id)arg3 apiRoot:(id)arg4
{
	/* Add the tweet_mode=extended GET parameter to tell Twitter's API we want 280 characters. */
	id parametercopy = [arg2 mutableCopy];
	[parametercopy setValue:@"extended" forKey:@"tweet_mode"];
	return %orig(arg1, parametercopy, arg3, arg4);
}
%end

%group 280_Below627
%hook TFNTwitterStatus
-(id)initWithJSONDictionary:(id)arg1 users:(id)arg2 ignoreUsers:(char)arg3 statusID:(long long)arg4
{
	/* For some unholy reason, Twitter's API returns the 280 character version in a tag called full_text, and the app expects text.
	   Rather than change where it gets the text from, why not put the text where it expects? Nothing can go wrong with that, surely... */
	id jsoncopy = [arg1 mutableCopy];
	[jsoncopy setValue:[jsoncopy valueForKey:@"full_text"] forKey:@"text"];
	return %orig(jsoncopy, arg2, arg3, arg4);
}
%end
%end

%group 280_Above627
%hook TFNTwitterStatus
-(id)initWithJSONDictionary:(id)jsondictionary users:(id)users statusID:(long long)anId
{
	/* On version 6.27 and higher, a different function is used for preparing tweets. Gotta merge them*/
	id jsoncopy = [jsondictionary mutableCopy];
	[jsoncopy setValue:[jsoncopy valueForKey:@"full_text"] forKey:@"text"];
	return %orig(jsoncopy, users, anId);
}
%end
%end

%ctor {
	NSString *TwitterVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
	if ([TwitterVersion compare:@"6.27" options:NSNumericSearch] == NSOrderedAscending) {
        %init(280_Below627);
    } else {
		%init(280_Above627);
	}
	%init(_ungrouped);
}