<cfset errorMessage = "">

<!--- Must have a Transaction ID: form.TransactionID --->
<cfif trim(form.TransactionID) eq "">
    <cfset errorMessage = errorMessage & "Transaction ID is Required.<br>">	
</cfif>

<cfif errorMessage gt "">
    <cfset showErrorMessage (Message = errorMessage)>	
    <cfabort>
</cfif>


<cfquery datasource="#request.dsnameWriter#" >

    DELETE FROM [dbo].[Transaction]
        WHERE TransactionID = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.TransactionID#">
            AND RentID = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.RentID#">

</cfquery>

    
<cfset session.OnLoadMessage = "success('Payment for the Rent has removed Successfully')">
<cfset relocate (area = "RentTransaction", action = "RentTransactionSelect&RentID=#form.RentID#")>