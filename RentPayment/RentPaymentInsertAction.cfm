
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
	
    <!--- if a fail attempt, log the attempt, increment longin attempt and lock out if reached max try --->
    <cfquery datasource="#request.dsnameWriter#" >
		INSERT INTO [dbo].[RentPayment]
			([TenantID]
			,[RoomID]
			,[PaymentDate]
			,[PaymentAmount]
			,[StartDate]
			,[EndDate]
			,[DateCreated]
			,[CreatedBy]
			,[DateLastUpdated]
			,[UpdatedBy])
		VALUES
			(<cfqueryparam cfsqltype="cf_sql_integer" value="#form.TenantID#">
			,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.RoomID#">
			,<cfqueryparam cfsqltype="cf_sql_timestamp" value="#form.PaymentDate#">
			,<cfqueryparam cfsqltype="cf_sql_float" value="#form.PaymentAmount#">
			,<cfqueryparam cfsqltype="cf_sql_date" value="#form.StartDate#">
			,<cfqueryparam cfsqltype="cf_sql_date" value="#form.EndDate#">
			,getDate()
			,<cfqueryparam cfsqltype="cf_sql_integer" value="#application.SystemUserID#">
			,getDate()
			,<cfqueryparam cfsqltype="cf_sql_integer" value="#application.SystemUserID#">)	    
    </cfquery>
    
        
<cfset session.OnLoadMessage = "success('Rent Payment  Added Successfully')">
<cfset relocate (area = "RentPayment", action = "RentPaymentSelect")>