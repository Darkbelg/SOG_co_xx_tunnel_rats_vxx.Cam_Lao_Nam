// F3 - Briefing - Credits: Please see the F3 online manual http://www.ferstaberinde.com/f3/en/
// <marker name='XXX'>XXX</marker>
// Green #80FF00
// Orange #FF7F00
// Blue #00FFFF

if (isNil "f_param_CasualtiesCap") then { f_param_CasualtiesCap = 100 }; // Set CasCap if author did not.

// The code below creates the administration sub-section of notes.
_adm = player createDiaryRecord ["Diary", ["Administration",[] call f_fnc_fillAdministration]];

// Edit the if statement for different faction briefs.

if (side group player != CIVILIAN) then {
	// The code below creates the execution sub-section of notes.
	_exe = player createDiaryRecord ["Diary", ["Mission",format["
	<br/><font size='18' color='#80FF00'>OBJECTIVES</font>
	<br/>We just got intel of a tunnel in the center of the ao.
	<br/>Go in and go look for intel inside the tunnels.
	<br/>
	<br/>%1 <!--- Casualties Cap --->
	<br/>
	<br/><font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>This mission is a emphasis on air support.
	<br/>There is a jungle between these towns. Who knows what is hidden in there.
	<br/>There is no resupply available so if you are running low on ammo you will have to pick up enemy weapons.
	<br/>
	<br/>All planes and helicopters have the option to change arnements with the aircraft master arm option.
	<br/>
	<br/><font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>Enemy has reinforced the position around the town. They are main VC forces.
	<br/>
	<br/>There are civilians inside the towns. So it is up to the commander if he wants to burn the town down or not.
	<br/>No need to feel bad they are siding with the VC.
	<br/>
	<br/>Tunnels are generaly hidden with the poultry.
	<br/>
	<br/><font size='18' color='#80FF00'>CREDITS</font>
	<br/>Created by <font color='#FF0080'>Darkbelg</font color>
	<br/>
	<br/>A custom-made mission for ArmA 3 and Zeus Community
	<br/>http://zeus-community.net
	<br/>",
	if (f_param_CasualtiesCap > 0 && f_param_CasualtiesCap < 100) then { format["Ensure casualties are kept below %1 and %1&#37; of your force is not incapacitated.<br/>", f_param_CasualtiesCap] } else { "" },
	(((vehicles select { side _x getFriend side group player < 0.6 && !(_x isKindOf "staticWeapon" || _x isKindOf "static") && count crew _x > 0}) apply {  getText (configFile >> "CfgVehicles" >> typeOf _x >> "displayName") }) call BIS_fnc_consolidateArray) apply { format["%2x <font color='#00FFFF'>%1</font><br/>", _x#0, _x#1] } joinString "",
	format["%1x <font color='#00FFFF'>Infantry Groups</font><br/>", { side _x getFriend side group player < 0.6 && count units _x >= 3 && vehicle leader _x == leader _x} count allGroups]
	]]];
};

/*
// Sector Heatmap (PEL Markers)
// <br/>Toggle PEL IDs <font color='#80FF00'><execute expression=""allMapMarkers apply { if (['pel_text_',_x] call BIS_fnc_inString) then { _x setMarkerAlphaLocal 0.3 }; };"">On</execute></font> | <font color='#CF142B'><execute expression=""allMapMarkers apply { if (['pel_text_',_x] call BIS_fnc_inString) then { _x setMarkerAlphaLocal 0 }; };"">Off</execute></font>
{
	_x params ["_pos", "_count"];
	
	private _mkr = createMarkerLocal [format["pel_area_%1",_forEachIndex], _pos];
	_mkr setMarkerShapeLocal "RECTANGLE";
	_mkr setMarkerBrushLocal "SolidBorder";
	_mkr setMarkerAlphaLocal 0.3;
	_mkr setMarkerColorLocal "ColorEast";
	_mkr setMarkerSizeLocal [50,50];
	
	private _mkr = createMarkerLocal [format["pel_text_%1",_forEachIndex], [(_pos#0)-50,(_pos#1)-40]];
	_mkr setMarkerTypeLocal "MIL_DOT";
	_mkr setMarkerTextLocal format["PEL %1", _forEachIndex + 1];
	_mkr setMarkerAlphaLocal 0;
	_mkr setMarkerColorLocal "ColorEast";
	_mkr setMarkerSizeLocal [0.1,0.1];
} forEach ((allGroups select { side _x getFriend side group player < 0.6 && count units _x >= 2 } apply { getPos leader _x select [0,2] apply { _x - _x % 100 + 50 } }) call BIS_fnc_consolidateArray);
*/