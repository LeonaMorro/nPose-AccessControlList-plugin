# nPose AccessControlList plugin
This example shows you how to register and use an User Defined Permission in combination with the NC Reader.

If you put this script into your nPose build, you will be able to use the permission `ACL`. That allows you to make a list with Avatar UUIDs which are allowed to use certain buttons.

Example:  
`SET:Poses:Friends{ACL}`  
`SET:Poses:Visitors{!ACL}`

In addition to the two notecards above, you have to add a custom notecard:

notecard name: `accessControlList`  
notecard content (Avatar UUIDs, change them to whatever you want):  
`469c9c40-d5fd-4040-a182-d48d68d77d72`  
`6934889c-67c7-4b1d-9bbe-9cf84f1d12ad`  
`...`

Have fun  
Leona (slmember1 Resident)
