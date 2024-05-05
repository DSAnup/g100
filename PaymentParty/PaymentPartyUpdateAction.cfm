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
	

        UPDATE [dbo].[PaymentParty]
                SET [PaymentPartyName] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.PaymentPartyName#">
                    ,[Address] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Address#">
                    ,[Phone] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Phone#">
                    ,[Email] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.Email#">
                    ,[UpdatedBy] = <cfqueryparam cfsqltype="cf_sql_integer" value="#val(session.profile.AppuserID)#">
                    ,[DateLastUpdated] = getDate()

        WHERE 
            PaymentPartyID = <cfqueryparam cfsqltype="cf_sql_integer" value="#val(form.PaymentPartyID)#">	
	

    </cfquery>
    
        
<cfset session.OnLoadMessage = "success('Payment Party Updated Successfully')">
<cfset relocate (area = "PaymentParty", action = "PaymentPartySelect")>