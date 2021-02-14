# Contacts

<img align="right" src="https://github.com/Rillieux/Contacts/blob/main/screens/categories.png" width="30%">


> :warning: THIS IS A WORK IN PROCESS WHICH IS ONLY BEGINNING. Stay tuned??

Contacts is an example of SwiftUI life-cycle application using CoreData and MVVM Architecture.

The goal is to provide a working example of various CoreData-related code to show how entities work in relationship to each other and SWiftUI views.

As it grows, the project will include these CoreData entities: 

- :bust_in_silhouette: Contact

- :camera: ContactImage

- :scroll: Category

Each `contact` will have the following properties: `firstName`, `lastName`, and `birthdate`. These properties will be reflected in compueted properties to show how to avoid handling optionals in SwiftUI view structs. In addition, each contact can be assigned to one category or to none, allowing an example of `.none` employing a `Picker` in a form view, as explained in Standford University's course CS193p, lectures 11 and 12, found here: https://cs193p.sites.stanford.edu/.

A contact may also have one or more contactImages which will make use of the `PhotoSelectAndCrop` project found here: https://github.com/Rillieux/PhotoSelectAndCrop. The ContactImage entity will show how to use CoreData's "external storage" for large BLOB data. 

Each `category` will have a `name`, `color` and `sortOrder`. Color will show how to use the `ColorPicker` and save a color using a `ColorToHex` function. SortORder wil be used to allow the user to rearrange items in a list when in `EditMode` saving them in an order that may not be as straightforward as alphabetically or chronologically.

<img align="left" src="https://github.com/Rillieux/Contacts/blob/main/screens/singleCategory.png" width="30%">
<img  src="https://github.com/Rillieux/Contacts/blob/main/screens/colorPicker.png" width="30%">
