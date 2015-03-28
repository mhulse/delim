# Delim

**The `<custom:rg:delim>` RULE (a.k.a tag) parses a delimited string and returns an iterable [`%ArrayOfDataTypes`](http://docs.intersystems.com/cache20091/csp/documatic/%25CSP.Documatic.cls?APP=1&CLASSNAME=%25Library.ArrayOfDataTypes) object.**

Each object has been assigned to the attribute `item` which you can access in each iteration of the tag's loop.

---

#### USAGE

### RULE/tag

**`<custom:rg:get:pics>` attributes:**

1. `string`: String to parse (required).
1. `parent`: Parent delimiter; the default is a `|` (pipe).
1. `child`: Optional child delimiter.
1. `limit`: Limit the number of parsed items returned; the default is `0` (no limit).
1. `reverse`: Use to reverse the direction of the loop; this attribute does not require a value.
1. `key`: The loop key variable name; the default name is `key`.
1. `count`: Local loop counter variable name; the default name is `count`.
1. `item`: Local item object variable name; the default name is `item`.
1. `total`: Local variable name for total number of parent items; the default name is `total`.
1. `obj`: Local `%ArrayOfDataTypes` object variable name; the default name is `obj`.

### API access

**`##class(custom.rg.Delim).parse()` parameters:**

1. `string`: String to parse (required).
1. `parent`: Parent delimiter; the default is a `|` (pipe).
1. `child`: Optional child delimiter.
1. `limit`: Limit the number of parsed items returned; the default is `0` (no limit).

**Returns:** Parsed string as iterable `%ArrayOfDataTypes` object(s).

---

#### DEMO & EXAMPLES

Check out [`delim.csp`](https://github.com/mhulse/delim/blob/master/delim/delim.csp) (and here's the [HTML output](http://mhulse.github.io/delim/)).

---

#### INSTALLATION

Of course, this goes without saying, but never install "stranger" code on your production system. **Always use your test server to play**!

With that said, there's a couple ways (that I can think of) to install this code:

### Class copy/paste:

1. "File" >> "New..." and choose "Caché Class Definition" from the "General" tab.
1. Type "custom.rg" as the "package name".
1. Type "Delim" as the "class name".
1. Copy/paste the **RAW** contents of `custom.rg.Delim.cls` into this new file.
1. Save and compile.

### RULE copy/paste:

1. "File" >> "New..." and choose "Caché Server Page" from the "CSP File" tab.
1. Copy/paste the **RAW** contents of `custom.rg.DelimRule.csr` into this new file.
1. Save this file as `custom.rg.DelimRule.csr` to the "CSP Files" >> `/csp/cms/customrules` package/folder/location.
1. Compile.

### RULE/class import local:

1. Download and unzip this repo to your local machine.
1. Open Studio.
1. Change to the `CMS` namespace.
1. "Tools" >> "Import Local...".
1. Import `custom.rg.DelimRule.csr` and `custom.rg.Delim.xml` and check the compile box.

---

#### NOTES

Non-[DTI](http://www.dtint.com/) customers should remove these lines from `custom.rg.DelimRule.csr`:

1. Remove `dt.common.page.Rule, ` from:
	```
	<csr:class super="dt.common.page.Rule, %CSP.RuleBlock" />
	```

1. 
	```
	<script language="cache" runat="compiler">
		do ##this.RenderDTStartTag()
	</script>
	```

1. 
	```
	<script language="cache" runat="compiler">
		do ##this.RenderDTEndTag()
	</script>
	```

---

#### DISCUSSION(S)

* [Trim whitespace around items in a delimited string](https://groups.google.com/d/topic/intersystems-public-cache/8iJV1p3kwD8/discussion)
* [Multi-line string variable?](https://groups.google.com/d/topic/intersystems-public-cache/iG3YnU11igA/discussion)
* [Trucate and `$number`?](https://groups.google.com/d/topic/intersystems-public-cache/gFvXTNjgq7o/discussion)
* [[2009.1] $list questions: Best/optimal ways to remove empty list items and how to reverse?](https://groups.google.com/d/topic/intersystems-public-cache/_c00b_zItqE/discussion)

---

#### CHANGELOG

* v2.0.1
	* 2013/06/27
		* Updated/normalized docblocks.
		* Changed a few argument names.
		* Cleaned up code.
		* Added a `limit` attribute/argument.
		* Fixed a few logic errors.
		* Explored my options for limiting/reversing/forwarding items and loops; not enough time to finalize code and will have to revisit.
* v2.0.0:
	* 2013/06/27
		* Renamed `custom.rg.Delim.csr` to `custom.rg.DelimRule.csr` and updated all references to the old name.
	* 2013/06/26
		* Second push to GitHub.
		* Changed a bunch of stuff. :)
* Pre-v2.0.0
	* It's the first commit.

---

#### LEGAL

Copyright &copy; 2013 [Micky Hulse](http://mky.io)

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this work except in compliance with the License. You may obtain a copy of the License in the LICENSE file, or at:

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
