// This example shows you how to register and use an User Defined Permission
// in combination with the NC Reader
// If you put this script into your nPose build, you will be able to use
// the permission {myFriends}.That allows you to make a list with Avatar UUIDs
// which are allowed to use certain buttons
//
// example:
// SET:Poses:Friends{myFriends}
// SET:Poses:Visitors{!myFriends}
//
// in addtion to the two notecards above, you have to create a custom notecard:
// notecard name: myFriendsList
// notecard content (Avatar UUIDs, change them to whatever you want)(do NOT use "," inside the nc):
// 469c9c40-d5fd-4040-a182-d48d68d77d72
// 6934889c-67c7-4b1d-9bbe-9cf84f1d12ad
// ...
//
// Have fun
// Leona (slmember1 Resident)
//
// Source Code:
// https://github.com/LeonaMorro/nPose-AccessControlList-plugin
//
// Report Bugs to:
// https://github.com/LeonaMorro/nPose-AccessControlList-plugin/issues
// or IM slmember1 Resident (Leona)


string MY_NC_NAME="myFriendsList";
string MY_PERMISSION_NAME="myFriends";


integer USER_PERMISSION_UPDATE=-806;
integer NC_READER_REQUEST=224;
integer NC_READER_RESPONSE=225;
string NC_READER_CONTENT_SEPARATOR="%&§";

key scriptId;

updatePermissionList(string permissionName, string theListAsAString) {
	string str=llList2CSV([permissionName, "list", theListAsAString]);
	// the string consists of:
	// the unique permission name you want to use
	// the type: in this case "list"
	// the string with Avatar UUIDs (do NOT use "," inside the string)
	llMessageLinked(LINK_SET, USER_PERMISSION_UPDATE, str, NULL_KEY);
}

default {
	state_entry() {
		//wait to be sure that the NC Reader is ready
		llSleep(1.0);
		//to make things easy, we fetch the ID of this script
		scriptId = llGetInventoryKey(llGetScriptName());
		//request the notecard Content
		llMessageLinked(LINK_SET, NC_READER_REQUEST, MY_NC_NAME, scriptId);
	}
	link_message(integer sender_num, integer num, string str, key id) {
		if(num==NC_READER_RESPONSE) {
			if(id==scriptId) {
				//str: (separated by the NC_READER_CONTENT_SEPARATOR): ncName, notUsed, notUsed, contentLine1, contentLine2, ...
				//strip the first 3 values
				string content=llDumpList2String(llList2List(llParseStringKeepNulls(str, [NC_READER_CONTENT_SEPARATOR], []), 3,-1), NC_READER_CONTENT_SEPARATOR);
				//update the permission
				updatePermissionList(MY_PERMISSION_NAME, content);
			}
		}
	}
	changed(integer change) {
		if(change & CHANGED_INVENTORY) {
			llResetScript();
		}
	}
}
