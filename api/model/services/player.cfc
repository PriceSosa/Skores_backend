<cfcomponent displayname="PlayerService" output="false">

    <cffunction name="getPlayer" access="public" returntype="Any" output="yes">
        <cfargument name="playerID" type="numeric" required="yes">

<!---         <cfquery name="LOCAL.qGetPlayer" datasource="skoreos_ds">
            SELECT * 
            FROM Player a
            WHERE 
            	1 = 1
            	<cfif ARGUMENTS.playerID GT 0>
            		AND a.PlayerID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.playerID#" />
            	</cfif>
        </cfquery>

        <cfreturn LOCAL.qGetPlayer> --->
        <cfif ARGUMENTS.playerID EQ 0>
            <cfreturn EntityLoad('Player')>        
        <cfelse>
            <cfreturn EntityLoad('Player', ARGUMENTS.playerID)>
        </cfif>
    </cffunction>

    <cffunction name="createPlayer" access="public" returntype="Any" output="yes">
        <cfargument name="firstName" type="string" required="yes">
        <cfargument name="lastName" type="string" required="yes">

        <cfreturn updatePlayer(playerID = 0, firstName = ARGUMENTS.firstName, lastName = ARGUMENTS.lastName)>
    </cffunction>

    <cffunction name="updatePlayer" access="public" returntype="Any" output="yes">
    	<cfargument name="playerID" type="numeric" required="yes">
        <cfargument name="firstName" type="string" required="yes">
        <cfargument name="lastName" type="string" required="yes">

        <cfif ARGUMENTS.playerID EQ 0>
			<cfset local.newPlayer = EntityNew('Player')>
        <cfelse>
			<cfset local.newPlayer = EntityLoad('Player', ARGUMENTS.playerID, true)>
        </cfif>

        <cfset local.newPlayer.setFirstName(ARGUMENTS.firstName)>
        <cfset local.newPlayer.setLastName(ARGUMENTS.lastName)>
        <cfset local.newPlayer.setActive(1)>
        <cfset local.newPlayer.setCreatedOn(Now())>
        <cfset EntitySave(local.newPlayer)>

        <cfset ormFlush()>

 		<cfreturn getPlayer(playerID = local.newPlayer.getPlayerID())>
    </cffunction>

</cfcomponent>