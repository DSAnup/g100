<cfset errorMessage = "">

<!--- Must have a Transaction ID: form.TransactionID --->
<cfif trim(form.TransactionID) eq "">
    <cfset errorMessage = errorMessage & "Transaction ID is Required.<br>">	
</cfif>
<cfif trim(form.PaymentAmount) eq "" or form.PaymentAmount lt 0>
    <cfset errorMessage = errorMessage & "Payment Amount is Required and must be a positive number.<br>">	
</cfif>

<cfif errorMessage gt "">
    <cfset showErrorMessage (Message = errorMessage)>	
    <cfabort>
</cfif>


<cfquery datasource="#request.dsnameWriter#" >

    UPDATE [dbo].[Transaction]
        SET [Amount] = <cfqueryparam cfsqltype="cf_sql_float" value="#form.PaymentAmount#">
           ,[TransactionDate] = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#form.PaymentDate#">
           ,[UpdatedBy] = <cfqueryparam cfsqltype="cf_sql_integer" value="#val(session.profile.AppuserID)#">
           ,[DateLastUpdated] = GETDATE()

        WHERE TransactionID = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.TransactionID#">

</cfquery>


    
<cfset session.OnLoadMessage = "success('Payment for the Rent has updated Successfully')">
<cfset relocate (area = "RentTransaction", action = "RentTransactionSelect&RentID=#form.RentID#")>