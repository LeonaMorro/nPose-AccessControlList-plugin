# nPose-AccessControlList-plugin
This example shows you how to register and use an user defined permission in combination with the NC Reader.

If you put this script into your nPose build, you will be able to use the permission {myFriends}. That allows you to make a list with Avatar UUIDs which are allowed to use a certain buttons.

Example:<br />
SET:Poses:Visitors{!myFriends}<br />
SET:Poses:Friends{myFriends}<br />

In addtion to the two notecards above, you have to add a custom notecard:

notecard name: myFriendsList<br />
notecard content (Avatar UUIDs, change them to whatever you want):<br />
469c9c40-d5fd-4040-a182-d48d68d77d72<br />
6934889c-67c7-4b1d-9bbe-9cf84f1d12ad<br />
...

Have fun
Leona (slmember1 Resident)
