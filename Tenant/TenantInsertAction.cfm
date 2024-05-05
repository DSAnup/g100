
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
		INSERT INTO [dbo].[Tenant]
			([TenantName]
			,[Phone]
			,[Email]
			,[Sex]
			,[IsActive]
			,[DateCreated]
			,[CreatedBy]
			,[DateLastUpdated]
			,[UpdatedBy])
		VALUES
			(<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.TenantName#">
			,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Phone#">
			,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Email#">
			,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Sex#">
			,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.IsActive#">
			,getDate()
			,<cfqueryparam cfsqltype="cf_sql_integer" value="#application.SystemUserID#">
			,getDate()
			,<cfqueryparam cfsqltype="cf_sql_integer" value="#application.SystemUserID#">)	    
    </cfquery>
    
        
<cfset session.OnLoadMessage = "success('Tenant  Added Successfully')">
<cfset relocate (area = "Tenant", action = "TenantSelect")>