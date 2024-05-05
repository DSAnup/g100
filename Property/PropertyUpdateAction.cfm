	<cfset errorMessage = "">
	
	<!--- make sure all required inputs are provided --->
	<cfif trim(form.PropertyName) eq "">
		<cfset errorMessage = errorMessage & "Property must be provided.<br>">	
	</cfif>
		
	<cfif errorMessage gt "">
		<cfset showErrorMessage (Message = errorMessage)>	
		<cfabort>
	</cfif>  
    
        
    <!--- if a fail attempt, log the attempt, increment longin attempt and lock out if reached max try --->
    <cfquery datasource="#request.dsnameWriter#" >

        UPDATE [dbo].[Property]
                SET [PropertyName] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.PropertyName#">                
                    ,[UpdatedBy] = <cfqueryparam cfsqltype="cf_sql_integer" value="#val(session.profile.AppuserID)#">
                    ,[DateLastUpdated] = getDate()

        WHERE 
            PropertyID = <cfqueryparam cfsqltype="cf_sql_integer" value="#val(form.PropertyID)#">	
	
    </cfquery>
    
        
<cfset session.OnLoadMessage = "success('Property Updated Successfully')">
<cfset relocate (area = "Property", action = "PropertySelect")>