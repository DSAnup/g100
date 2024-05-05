

	<cfset errorMessage = "">

	<!--- make sure all required inputs are provided --->
	<cfif trim(form.TenantID) eq "">
		<cfset errorMessage = errorMessage & "Tenant  must be provided.<br>">	
	</cfif>
	<cfif trim(form.RoomID) eq "">
		<cfset errorMessage = errorMessage & "Room  must be provided.<br>">	
	</cfif>
	<cfif trim(form.PaymentDate) eq "">
		<cfset errorMessage = errorMessage & "Payment Date  must be provided.<br>">	
	</cfif>
	<cfif trim(form.PaymentAmount) eq "">
		<cfset errorMessage = errorMessage & "Payment Amount  must be provided.<br>">	
	</cfif>
	<cfif trim(form.StartDate) eq "">
		<cfset errorMessage = errorMessage & "Start Date  must be provided.<br>">	
	</cfif>
	<cfif trim(form.EndDate) eq "">
		<cfset errorMessage = errorMessage & "End Date  must be provided.<br>">	
	</cfif>

    <cfif errorMessage gt "">
		<cfset showErrorMessage (Message = errorMessage)>	
		<cfabort>
	</cfif> 

    <cfif errorMessage gt "">
		<cfset showErrorMessage (Message = errorMessage)>	
		<cfabort>
	</cfif>  
    
        
        
    <!--- if a fail attempt, log the attempt, increment longin attempt and lock out if reached max try --->
    <cfquery datasource="#request.dsnameWriter#" >
		UPDATE [dbo].[RentPayment]
		SET [TenantID] = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.TenantID#">
			,[RoomID] = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.RoomID#">
			,[PaymentDate] = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#form.PaymentDate#">
			,[PaymentAmount] = <cfqueryparam cfsqltype="cf_sql_float" value="#form.PaymentAmount#">
			,[StartDate] = <cfqueryparam cfsqltype="cf_sql_date" value="#form.StartDate#">
			,[EndDate] = <cfqueryparam cfsqltype="cf_sql_date" value="#form.EndDate#">
			,[DateLastUpdated] = getDate()
			,[UpdatedBy]  = <cfqueryparam cfsqltype="cf_sql_integer" value="#application.SystemUserID#">
		WHERE 
			RentPaymentID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.RentPaymentID#">	
    </cfquery>
    
        
<cfset session.OnLoadMessage = "success('Rent Payment Updated Successfully')">
<cfset relocate (area = "RentPayment", action = "RentPaymentSelect")>