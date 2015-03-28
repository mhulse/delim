/// custom.rg.Delim.cls
/// See <code>custom.rg.Delim.csr</code> for related code.
///
/// @docs https://github.com/mhulse/delim
/// @copyright Copyright (c) 2013 Micky Hulse.
/// @license Released under the Apache License, Version 2.0.
/// http://www.apache.org/licenses/LICENSE-2.0
/// @version 2.0.1
/// @created Thursday, February 5, 2009
/// @modified Wednesday, June 27, 2013
Class custom.rg.Delim Extends %RegisteredObject
{

/// @param string { %String } String to parse (required).
/// @param parent { %String } Parent delimiter; the default is a `|` (pipe).
/// @param child { %String } Optional child delimiter.
/// @param limit { %Integer } Limit the number of parsed items returned; the default is `0` (no limit).
/// @return { %ArrayOfDataTypes } Parsed string as iterable `%ArrayOfDataTypes` object(s).
ClassMethod parse(
	string As %String = "",
	parent As %String = "|",
	child As %String = "",
	limit As %Integer = 0) As %ArrayOfDataTypes
{
	
	; Declare & initialze return value:
	set return = ##class(%ArrayOfDataTypes).%New()
	
	; Check required arguments:
	if ($length(string)) {
		
		; Convert delimited parent string into a $list:
		set plist = ..lister(string, parent)
		
		; Validate our parent $list:
		if ($listvalid(plist)) {
			
			; Make a whole number integer (or "0" if invalid):
			set limit = (limit \ 1) // https://groups.google.com/d/topic/intersystems-public-cache/gFvXTNjgq7o/discussion
			
			; Limit the number of parents, or get all:
			for i=1:1:$select(limit:limit, 1:$listlength(plist)) { // i=start:increment:end
				
				; Ok, so make sure the list has data:
				if ($listdata(plist, i)) {
					
					; Initialize:
					set data = ##class(%ArrayOfDataTypes).%New()
					
					; Is there a child delimiter?
					if ($length(child)) {
						
						; Convert delimited child string into a $list:
						set clist = ..lister($list(plist, i), child)
						
						; Validate our child $list:
						if ($listvalid(clist)) {
							
							; At least one?
							for x=1:1:$listlength(clist) {
								
								; Ok, so make sure the list has data:
								if ($listdata(clist, x)) {
									
									; Add item to master list:
									do data.SetAt($list(clist, x), x)
									
								}
								
							}
							
						}
						
					} else {
						
						; Add item to master list:
						do data.SetAt($list(plist, i), i)
						
					}
					
					; Add item to master list:
					do return.SetAt(data, i)
					
				}
				
			}
			
		}
		
	}
	
	; Return the %ArrayOfDataTypes:
	quit return
	
}

/// Trims white space and builds a list.
/// 
/// set items = ..lister("foo, bar, baz", ",") // "items" is now a list.
///
/// @see https://groups.google.com/d/topic/intersystems-public-cache/8iJV1p3kwD8/discussion
/// @see https://gist.github.com/4008569
///
/// @param string { %String } String to parse (required).
/// @param delim { %String } Delimiter; the default is a `|` (pipe).
/// @private
ClassMethod lister(
	string As %String = "",
	delim As %String = "|") As %List [ Private ]
{
	
	; Declare & initialze return value:
	set return = ""
	
	; Check required arguments:
	if ($length(string) && $length(delim)) {
		
		; Loop over string using provided delimiter:
		for i=1:1:$length(string, delim) {
			
			; Grab current item and trim the whitespace:
			set temp = $zstrip($piece(string, delim, i), "<>W")
			
			; If there's something left over, add it to the return value:
			set:($length(temp)) return = return _ $listbuild(temp)
			
		}
		
	}
	
	; Return the $list:
	quit return
	
}

}
