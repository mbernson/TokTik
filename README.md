# TokTik

This is a re-creation of the TikTok user interface in SwiftUI. It was written for practicing SwiftUI development.

The most interesting part of this app is the infinitely scrolling video feed that TikTok is known for. I've created the video feed using [UIPageViewController](https://developer.apple.com/documentation/uikit/uipageviewcontroller). This allows you to scroll through a truly infinite list of things, and it gets the snapping scroll gesture just right.

The TikTok tab bar requires things that the SwiftUI TabView doesn't support. So I've wrapped [UITabBarController](https://developer.apple.com/documentation/uikit/uitabbarcontroller) to achieve that. As a bonus, that makes it possible implement a pop-to-rootview when you tap on a tab bar item. That's something SwiftUI's TabView just doesn't support.
