# Images-with-CoreData

> A simple iOS app that demonstrates how to store images in CoreData.

## Summary

This app allows users to save and retrieve images from CoreData. Users can take a photo with the camera or select an existing image from their photo library. The app will save the image as a `Binary Data` attribute in CoreData.

## Requirements

* iOS 15.0 or later
* Xcode 14.0 or later

## How to use

1. Open the project in Xcode.
2. Run the project in the simulator or on a physical device.

To save an image:

1. Tap the "Take Photo" or "Select Photo" button.
2. Select the image you want to save.
3. Tap the "Save" button.

To retrieve an image:

1. Tap the "Load Image" button.
2. Select the image you want to load.
3. Tap the "Load" button.

## Explanation

The app uses CoreData to store images as `Binary Data` attributes. This is the most efficient way to store images in CoreData, as it allows the app to store and retrieve images without having to convert them to a different format.

The app uses the `UIImagePickerController` class to allow users to take photos or select photos from their photo library. The `UIImagePickerController` class provides a user interface for taking and selecting photos.

## Code

The code for the app is located in the `Sources` directory.

## More information

* CoreData: https://developer.apple.com/documentation/coredata

## Date created

2023-09-27

## Author

Obde Willy

## Conclusion

This app is a good starting point for anyone who wants to learn how to store images in CoreData. It shows how to use CoreData to store images as `Binary Data` attributes and how to use the `UIImagePickerController` class to allow users to take and select photos.
