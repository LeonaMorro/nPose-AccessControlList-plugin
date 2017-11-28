// This example shows you how to register and use an User Defined Permission
// and how to use the NC Reader to read a custom NC
// If you put this script into your nPose build, you will be able to use
// the User Defined Permission {ACL}.
// This allows you to make a list with Avatar UUIDs which are allowed to use certain buttons
//
// example:
// SET:Poses:Friends{ACL}
// SET:Poses:Visitors{!ACL}
//
// in addition to the two notecards above, you have to create a custom notecard:
// notecard name: accessControlList
// notecard content (Avatar UUIDs, change them to whatever you want):
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


string MY_NC_NAME="accessControlList";
string MY_PERMISSION_NAME="ACL";


integer UDPLIST=-805;
integer NC_READER_REQUEST=224;
integer NC_READER_RESPONSE=225;
string NC_READER_CONTENT_SEPARATOR="%&§";

key scriptId;

updatePermissionList(string permissionName, string theListAsAString) {
	// the string consists of:
	// the unique permission name you want to use
	// the string with Avatar UUIDs (do NOT use "," inside the string)
	
	//sanitize, remove any "," or "|" or "="
	theListAsAString=llDumpList2String(llParseStringKeepNulls(theListAsAString, [","], []), "");
	theListAsAString=llDumpList2String(llParseStringKeepNulls(theListAsAString, ["|"], []), "");
	theListAsAString=llDumpList2String(llParseStringKeepNulls(theListAsAString, ["="], []), "");
	//send the message
	llMessageLinked(LINK_SET, UDPLIST, permissionName + "=" + theListAsAString, NULL_KEY);
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
				string content=llDumpList2String(llDeleteSubList(llParseStringKeepNulls(str, [NC_READER_CONTENT_SEPARATOR], []), 0, 2), NC_READER_CONTENT_SEPARATOR);
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
