#  Some notes

## Extra Task 

Ran out of time, so I’ll just tell you briefly how I would implement it. 

I would first refactor `PixellateFilter` so that it takes a `filterType` parameter (a `FilterType` enum with associated String value, the name of the filters), so that the correct filter could be instantiated on a case by case basis. 

`PhotoEditorModel`, should be modified to have an additional parameter (of type `FilterType`), and the `storePixellateEdits` and `loadPixellateEdits` (now called `storeFilterEdits` and `loadFilterEdits`) should save the filter type in addition to the `inputScale` parameter (the `loadPixellateEditsFor(_ filename: String)` in `GalleryDataSource` should be also changed to reflect the new behaviour).

`PhotoEditorViewController` should have a “toggle” component either above or below the slider allowing the user to choose between the two filters (maybe two buttons, one for each filter, appropriately skinned with two states, selected/unselected; or maybe a radio box with the two possible filters [this one would scale better with added filters]) . 

`PhotoEditorModelProtocol` would need a new `func editorDidChangeFilterType(to type: FilterType)` that would get called every time the user changes the selected filter, and `PhotoEditorModel` should implement it so that it saves the new `filterType`, and applies the filter to the image.

`GalleryDataSource` should, on load, check the `filterType` associated with the image, and apply it to the thumbnail.


## A small note on the Gallery

Right now when the user goes back to the Gallery from the Editor, the thumbnail associated to the edited image is not immediately filtered with the new `inputScale`. 

One possible solution would be for `PhotoEditorViewController` to pass back to `GalleryViewController` the latest `inputScale` value, so that it could then call a new method in `GalleryDataSource` (let’s call it `rebuildThumbnailFor(item: PhotoItem)`) that would apply the modified filter to the correct item thumbnail. In order to avoid having to reload the whole image and recreate the thumbnail, `PhotoItem` could be modified to have an `originalThumbnail` property with the unfiltered thumbnail. 

