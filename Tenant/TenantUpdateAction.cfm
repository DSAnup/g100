

	<cfset errorMessage = "">

	<!--- make sure all required inputs are provided --->
	<cfif trim(form.TenantName) eq "">
		<cfset errorMessage = errorMessage & "Address Line 1  must be provided.<br>">	
	</cfif>

    <cfif errorMessage gt "">
		<cfset showErrorMessage (Message = errorMessage)>	
		<cfabort>
	</cfif>  
    
        
        
    <!--- if a fail attempt, log the attempt, increment longin attempt and lock out if reached max try --->
    <cfquery datasource="#request.dsnameWriter#" >
		UPDATE [dbo].[Tenant]
		SET [TenantName] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.TenantName#">
			,[Phone] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Phone#">
			,[Email] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Email#">
			,[Sex] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Sex#">
			,[isActive] = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.isActive#">
			,[DateLastUpdated] = getDate()
			,[UpdatedBy]  = <cfqueryparam cfsqltype="cf_sql_integer" value="#application.SystemUserID#">
		WHERE 
			TenantID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.TenantID#">	
    </cfquery>
    
        
<cfset session.OnLoadMessage = "success('Tenant Updated Successfully')">
<cfset relocate (area = "Tenant", action = "TenantSelect")>