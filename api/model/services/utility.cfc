<cfcomponent>

    <cffunction name="init" access="public" output="no">
        <cfreturn this>
    </cffunction>

	<cffunction name="removeListDuplicates" access="public" returntype="string" output="yes">
    	<cfargument name="theList" type="string" required="yes">

		<cfset VAR removeDupList = StructNew()>
        <cfset VAR returnList = "">
        <cfset VAR thisItem = "">
                
        <cfloop index="thisItem" list="#ARGUMENTS.theList#">
        	<cfset removeDupList[thisItem] = "">
        </cfloop>
		<cfset returnList = StructKeyList(removeDupList) />

        <cfreturn returnList>
    </cffunction>

	<cffunction name="selectCommonListItems" access="public" returntype="string" output="yes">
    	<cfargument name="aList" type="string" required="yes">
    	<cfargument name="bList" type="string" required="yes">

		<cfset commonList = "">
        <cfloop index="aItem" list="#ARGUMENTS.aList#">
			<cfif ListContains(bList, aItem)>
				<cfset commonList = ListAppend(commonList, aItem)>
            </cfif>
        </cfloop>

        <cfreturn removeListDuplicates(commonList)>
    </cffunction>
        

    <!--- Ben Nadel --->
    <cffunction name="QueryToArray" access="public" returntype="array" output="false"
        hint="This turns a query into an array of structures.">

        <!--- Define arguments. --->
        <cfargument name="Data" type="query" required="yes" />

        <cfscript>

            // Define the local scope.
            var LOCAL = StructNew();

            // Get the column names as an array.
            LOCAL.Columns = ListToArray( arguments.Data.ColumnList );

            // Create an array that will hold the query equivalent.
            LOCAL.QueryArray = ArrayNew( 1 );

            // Loop over the query.
            for (LOCAL.RowIndex = 1 ; LOCAL.RowIndex LTE arguments.Data.RecordCount ; LOCAL.RowIndex = (LOCAL.RowIndex + 1)){

                // Create a row structure.
                LOCAL.Row = StructNew();

                // Loop over the columns in this row.
                for (LOCAL.ColumnIndex = 1 ; LOCAL.ColumnIndex LTE ArrayLen( LOCAL.Columns ) ; LOCAL.ColumnIndex = (LOCAL.ColumnIndex + 1)){

                    // Get a reference to the query column.
                    LOCAL.ColumnName = LOCAL.Columns[ LOCAL.ColumnIndex ];

                    // Store the query cell value into the struct by key.
                    LOCAL.Row[ LOCAL.ColumnName ] = arguments.Data[ LOCAL.ColumnName ][ LOCAL.RowIndex ];

                }

                // Add the structure to the query array.
                ArrayAppend( LOCAL.QueryArray, LOCAL.Row );

            }

            // Return the array equivalent.
            return( LOCAL.QueryArray );

        </cfscript>
    </cffunction>
            

    <cffunction name="ReplaceEOL" access="public" output="false" returntype="string" hint="Replaces EOL codes with other characters">
        <cfargument name="String" required="true" type="string">
        <cfargument name="ReplaceWith" required="true" type="string">

        <cfreturn REReplace(Arguments.String, "\r\n|\n\r|\n|\r", Arguments.ReplaceWith, "all")>
    </cffunction>


    <!--- WHY IS THIS IN HERE --->
    <cffunction name="convertDateToLocal" access="public" output="no" returntype="date">
        <cfargument name="serverDateTime" type="date" required="yes">
        
        <cfset LOCAL.newDateTime = DateAdd("h", SESSION.TimeOffset, arguments.serverDateTime)>
        
        <cfreturn LOCAL.newDateTime>
    </cffunction>

</cfcomponent>