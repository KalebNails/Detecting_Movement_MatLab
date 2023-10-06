# Purpose #
The general purpose of this file of object detection in Matlab. A large amount of code will uses the specs of my classes. 

# If you run into errors #
They are most likely because the code calls for files and parameters that are on my laptop. To calibrate your camera use the camera callibration app on matlab. Your camera lense will deform your image, this app will create the parameters to undeform it.

# Glossary: #

## Average_Circle_from_points.m ##
This is a function that is called in grey_pixels_and_circles.m  
In effect it tries to take in the pixels that have changed and attempt to make a circle out of those points. IT does remove outliers from the data set.

## grey_pixels_and_circle.m ##
This is a non-exhastive attempt at detecting circle using Matlab and a camera. This is not the best method, nor do I recommend it. Matlab has a built in object recognition library that I would recommend if one needed a reliable method. What the code does is detect pixel changes, uses Average_Circle_from_points.m to try to create a circle around the change of pixels, and then plots it on the live camera feed. I have seen varied success. It will sometimes make circles out of nothing, if there is too much light it will not work. I have thrown a roll of duct tape across the camera and it created a circle alongs its edge and a dot in its center. 

## greyscalepixelchange.m
This puts a dot in a live feed. This dot is at the average of all of the changed pixel values. If you wave your hand it should roughly be on your hand.


## ard_reciever.py & distance_angle.py
This was part of personal project that I'm taking a small break from. basically I had a TF-luna lidar and a motor above it with a mirror attached spining. This should theoretically give you a plane of distances. I believe ard_reciever is a an earlier step, and ard_reciever eventually gets integrated into distance_angle. The setup to my memory was I had the arduino controlling a motor with an incremental encoder (this was done through an H-bridge), and the arduino sent the "angle" (this was calculated with rough math and estimates) through serial port to a connected tower. Then a raspberry pi would recorded the TF luna data, and that was connected through eithernet to the tower. Then I would just use socket over the local network to send the data to the tower. I determined that the incremental encoder has too much error, so i was gonna switch to a absolute encoder, but I suddenly had a 4 month vacation called summer and haven't taken another wing at it for a moment. In the future I need to switch to an absolute encoder, i want to use a beefier motor, and i actually want to 3d print a mount for all of this stuff. 

## smallmotordcencoder.ino
This is a pretty simple motor controller with an ecoder, im mostly putting it here for convience.
