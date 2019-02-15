# Bout-time

## iOS Techdegree Project 3

The game involves having a list of Tv series and the user needs to put them in the correct chronological order. A single round of play consists of ordering four/five/six random TV series (depending on the level of difficulty choosen), and there are six rounds in each full game.

![bout-time img](https://github.com/elenamene/bout-time/blob/master/iphone_aboutTime.png)

### Required Tasks

1. Build the user interface of the app per the provided mockups. Be sure to integrate the app icons provided.

2. The app should display correctly on iPhones with screen sizes of 4.7 inches and 5.5. Inches.

3. Create a list of at least 25 historical events (for my game I decided to use TV Series) to be used as the content for the game.

4. Create custom types (structs or classes) to model the objects, as well as any other entities you think should be modeled using custom types.

5. Create functions to randomly populate the events for each round of play, making sure no event appears twice in the same round of play.
6. Create UI logic to allow users to re-order the events using the up and down buttons.

7. Create a method to determine whether or not the events were ordered correctly. Points should only be awarded for fully correct solutions.

8. Create a countdown timer to give users 60 seconds to correctly order the events. When the timer expires, the events orders are checked for correctness.

9. If a user completes the ordering in less than 60 secsonds, they should be able to shake the device in order to get the order checked immediately.

10. Create logic such that after 6 rounds of play the game concludes and a total score is displayed.

### Extra Credit

1. Add a feature such that at the end of each round, the users can tap on an event and be presented with a WebView or SafariViewController which will show a web page (such as Wikipedia) with related information. Users can close the webview and resume game play.

### Personal Enhancements

* Created my own landing screen to allow for different difficulty levels.

* Added logic to populate the list with different a number of series depending on the level of difficulty chosen.

* Added end screen with points, rounds won and play again button.

* Improved layout with the use of stack views.

* Created a .plist to store the TV series.
