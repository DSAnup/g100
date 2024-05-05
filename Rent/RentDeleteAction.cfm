<cfset errorMessage = "">

<!--- Must have a Transaction ID: form.TransactionID --->
<cfif trim(form.RentID) eq "">
    <cfset errorMessage = errorMessage & "Transaction ID is Required.<br>">	
</cfif>

<cfif errorMessage gt "">
    <cfset showErrorMessage (Message = errorMessage)>	
    <cfabort>
</cfif>


<cfquery datasource="#request.dsnameWriter#" >

    DELETE FROM [dbo].[Rent]
        WHERE RentID = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.RentID#">

    DELETE FROM [dbo].[Transaction]
        WHERE RentID = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.RentID#">

</cfquery>

    
<cfset session.OnLoadMessage = "success('The Rent entry including related transactions has removed Successfully')">
<cfset relocate (area = "Rent", action = "RentSelect")>