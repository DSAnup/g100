	<cfset errorMessage = "">
	
	<!--- make sure all required inputs are provided --->
	<cfif trim(form.PaymentPartyName) eq "">
		<cfset errorMessage = errorMessage & "Payment Party Name must be provided.<br>">	
	</cfif>
	<cfif trim(form.Address) eq "">
		<cfset errorMessage = errorMessage & "Address must be provided.<br>">	
	</cfif>
	<cfif trim(form.Phone) eq "">
		<cfset errorMessage = errorMessage & "Phone must be provided.<br>">	
	</cfif>
	<cfif trim(form.Email) eq "">
		<cfset errorMessage = errorMessage & "Email must be provided.<br>">	
	</cfif>
	<cfif errorMessage gt "">
		<cfset showErrorMessage (Message = errorMessage)>	
		<cfabort>
	</cfif>  
    
	
        
    <!--- if a fail attempt, log the attempt, increment longin attempt and lock out if reached max try --->
    <cfquery datasource="#request.dsnameWriter#" >

        INSERT INTO [dbo].[PaymentParty]
                ([PaymentPartyName]
                ,[Address]
                ,[Phone]
                ,[Email]
                ,[CreatedBy]
                ,[UpdatedBy]
                ,[DateCreated]
                ,[DateLastUpdated])

        VALUES (
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.PaymentPartyName#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Address#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Phone#">
                ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Email#">
                ,<cfqueryparam cfsqltype="cf_sql_integer" value="#val(session.profile.AppuserID)#">
                ,<cfqueryparam cfsqltype="cf_sql_integer" value="#val(session.profile.AppuserID)#">
                ,getDate()
                ,getDate()
            )
	
    </cfquery>
    
        
<cfset session.OnLoadMessage = "success('Payment Party Inserted Successfully')">
<cfset relocate (area = "PaymentParty", action = "PaymentPartySelect")>