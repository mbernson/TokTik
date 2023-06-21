# TokTik

This is a re-creation of the TikTok user interface in SwiftUI. It was written for practicing SwiftUI development.

This app was created as a user interface speedrun in which I recreate a popular app's UI using SwiftUI in a couple of hours. The focus for this app was on the TikTok video feed, in which the user scrolls through videos.

https://github.com/mbernson/TokTik/assets/477710/9d3ac331-896f-4c74-aefe-db3b2f820bcf

The most interesting part of this app is the infinitely scrolling video feed that TikTok is known for. I've created the video feed using [UIPageViewController](https://developer.apple.com/documentation/uikit/uipageviewcontroller). This allows you to scroll through a truly infinite list of things, and it gets the snapping scroll gesture just right.

The TikTok tab bar requires things that the SwiftUI TabView doesn't support. So I've wrapped [UITabBarController](https://developer.apple.com/documentation/uikit/uitabbarcontroller) to achieve that. As a bonus, that makes it possible implement a pop-to-rootview when you tap on a tab bar item. That's something SwiftUI's TabView just doesn't support.
