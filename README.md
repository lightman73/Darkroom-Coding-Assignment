# PixelRoom

![AppIcon-1bit@2x](https://user-images.githubusercontent.com/3727687/109584315-93d00780-7b01-11eb-959d-1cecd5e79c5f.png)

Welcome to the PixelRoom repository. We'd like to thank you for doing this assignment. If you need help, or you have any questions, please don't hesitate to [contact us](mailto:igor@darkroom.co).

## Description

Meet the PixelRoom iOS app! It's small and focused on one task, and one task only - to make beautiful photos look pixellated! We take this task seriously, so we want this app to be stable and simple, to run smooth as possible and create amazing pixellated images.

PixelRoom has only 2 screens: `Gallery` and `Photo Editor`. 

`Gallery` shows the photo library, which currently comes bundled with the app. It consists of 3 sections. The first 2 show differently-sized thumbnails of featured photos picked at random, while the third section contains the thumbnails of all other photos.

When you select a photo from the `Gallery`, it will open the `Photo Editor` screen for the photo you picked. `Photo Editor` is also very simple, it consists of a preview of the image and the main editing slider which controls the strength of the pixellate effect. 

Currently we do not support exporting the pixellated photo. That sounds pretty complicated, so we thought maybe we would only consider it for PixelRoom 2, but maybe you can prove us wrong? ;)

We've already built most of the app, but suddenly some nasty bugs started showing up and now we need help to hunt them down and finish some other important parts of the app. 

## Task

**1. While testing and debugging the app, we've noticed some issues that should be addressed:**
- `Gallery` is acting kinda slow, plus it takes a long time to load the photos. We tried to fix it but now... 
- The app crashes on startup :(
- Also, `Photo Editor` is not always showing the results we expect.
- _Hint: If you notice some weird behaviour, make sure to check CoreImage documentation. And of course, [CIFilter.io](https://cifilter.io) might come in handy if you encounter some undocumented problems._

Can we prevent some of these or similar issues with unit tests? Feel free to suggest and write some. Pay attention to this when implementing other parts of this task as well. 

We know that we're loading a whole library full of big photos at once, which is never gonna be as fast as we'd like it to be, but we can live with some delay for the PixelRoom v1, so don't obsess over optimizing it too much, unless you still have time at the end. 

Same goes for adding tests. Focus only on few things that you think should be tested so we can see how to approach testing in general, and we'll work on our test coverage for the next version of the app.

**2. We really like how Photos and App Store app show their featured content. We're also aware that we're not using the cool new APIs, so we'd love to:**
- Refactor the `Gallery` screen and use the new compositional layout APIs for `UICollectionView`.
- Make the `Featured` sections horizontally scrollable.
- You should still be able to scroll vertically through the rest of the photos in the default section.

**3. PixelRoom persists only the latest edits user applied, and it applies the same edits to any photo we open next. Rebuild the way we store edits.**
- Persist edits for each photo we apply the pixellate effect to. 
- After we restart the app, user should be able to see the different edits he previously made on each photo.
- Show pixellated thumbnails in the `Gallery`, based on the edits we store for each photo.
- _Hint: Every photo in our bundled library is guaranteed to have a unique name, so it can be safely used as an identifier._
- _Hint: Don't store edited image data at full size. Check how we use `PixellateFilter` class._

### Extra task
First 3 tasks are important, work on this one only if you still have time at the end.

**4. We're using `CIPixellate` filter, which is part of `CoreImage` framework, to pixellate our photos. We'd really like to add another cool pixellate effect.**
- Add another similar effect using some `CoreImage` built-in filter. Perhaps `CIHexagonalPixellate` and `CIPointillize` could do the trick? 
- User should be able to choose between implemented filters, but should be able to apply only 1 per photo.
- We advise you to use the `PixellateFilter` class as an example and check `CoreImage` documentation to learn about the `CIFilter` you will pick, and its parameters.
- _Hint: [CIFilter.io](https://cifilter.io) might be helpful here as well!_ 

## Notes
- Please don't spend more than 4-5 hours on this assignment. This is not an estimate of how long should it take you to finish, we just feel that by that time you'd have written more than enough code.
- Some parts of the task require more work than that? Or you're not sure how to solve a certain problem? Perhaps implementing your ideal solution would take longer? Feel free to just stop and write down your ideas in a comment or as a note. We highly value good thought process! 
- When it comes to building UI components, attention to detail is very much appreciated, but we don't expect you to focus only on rebuilding the app UI, cool transitions and animations etc. Focus on the tasks!
- We really love to see focused commits that come with meaningful messages :)

## How to submit the solution

- Fork this repository.
- Create a new branch, push the work to your repository and open a PR with your solution.
- Add [Igor](https://github.com/IgorLipovac) and/or [Jarod](https://github.com/jarodl) as collaborators so we can review your PR.

Alternatively, send us a .zip file with all the code, containing the git history.

## The Review Process
- We'll make sure to review the code and add feedback to your PR, or send the feedback via email. 
- After that, we will arrange a call to go through the feedback together and perhaps talk bit more about certain parts of your solution, if needed.

## Finally...

<img width="421" alt="Screenshot 2021-03-02 at 02 44 55" src="https://user-images.githubusercontent.com/3727687/109584147-523f5c80-7b01-11eb-8df2-150ec1937fb0.png">

