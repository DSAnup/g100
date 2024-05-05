	<cfset errorMessage = "">
	
	<!--- make sure all required inputs are provided --->
	<cfif trim(form.AccountName) eq "">
		<cfset errorMessage = errorMessage & "Account Name must be provided.<br>">	
	</cfif>
	
	<cfif errorMessage gt "">
		<cfset showErrorMessage (Message = errorMessage)>	
		<cfabort>
	</cfif>  
    
        
    <!--- if a fail attempt, log the attempt, increment longin attempt and lock out if reached max try --->
    <cfquery datasource="#request.dsnameWriter#" >
	

        UPDATE [dbo].[Account]
                SET [AccountName] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.AccountName#">
                    ,[UpdatedBy] = <cfqueryparam cfsqltype="cf_sql_integer" value="#val(session.profile.AppuserID)#">
                    ,[DateLastUpdated] = getDate()

        WHERE 
            AccountID = <cfqueryparam cfsqltype="cf_sql_integer" value="#val(form.AccountID)#">	
	

    </cfquery>
    
        
<cfset session.OnLoadMessage = "success('Account Updated Successfully')">
<cfset relocate (area = "Account", action = "AccountSelect")>