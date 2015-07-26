// LSL script generated - patched Render.hs (0.1.6.2): LSLScripts.nPose AccessControlList.lslp Sun Jul 26 16:19:06 Mitteleuropäische Sommerzeit 2015
// This example shows you how to register and use an user defined permission
// in combination with the NC Reader
// If you put this script into your nPose build, you will be able to use
// the permission {myFriends}.That allows you to make a list with Avatar UUIDs
// which are allowed to use a certain buttons
//
// example:
// SET:Poses:Visitors{!myFriends}
// SET:Poses:Friends{myFriends}
//
// in addtion to the two notecards above, you have to make a custom notecard:
// notecard name: myFriendsList
// notecard content (Avatar UUIDs, change them to whatever you want):
// 469c9c40-d5fd-4040-a182-d48d68d77d72
// 6934889c-67c7-4b1d-9bbe-9cf84f1d12ad
// ...
//
// Have fun
// Leona (slmember1 Resident)


string MY_NC_NAME = "myFriendsList";
string MY_PERMISSION_NAME = "myFriends";
string NC_READER_CONTENT_SEPARATOR = "℥";

key scriptId;

updatePermissionList(string permissionName,string theListAsAString){
    string str = llList2CSV([permissionName,"list",theListAsAString]);
    llMessageLinked(-1,-806,str,NULL_KEY);
}

default {

	state_entry() {
        llSleep(1.0);
        scriptId = llGetInventoryKey(llGetScriptName());
        llMessageLinked(-1,224,MY_NC_NAME,scriptId);
    }

	link_message(integer sender_num,integer num,string str,key id) {
        if (num == 225) {
            if (id == scriptId) {
                string content = llDumpList2String(llList2List(llParseStringKeepNulls(str,[NC_READER_CONTENT_SEPARATOR],[]),3,-1),NC_READER_CONTENT_SEPARATOR);
                updatePermissionList(MY_PERMISSION_NAME,content);
            }
        }
    }

	changed(integer change) {
        if (change & 1) {
            llResetScript();
        }
    }
}
