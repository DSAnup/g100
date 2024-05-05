	
<!--- <cfdump var="#form#"> --->

<cfset errorMessage = "">

<!--- make sure all required inputs are provided --->
<cfif trim(form.RentID) eq "">
    <cfset errorMessage = errorMessage & "Rent ID is Required.<br>">	
</cfif>

<cfif trim(form.PaymentAmount) eq "" or form.PaymentAmount lt 0>
    <cfset errorMessage = errorMessage & "Payment amount is Required and must be a positive number.<br>">	
</cfif>

 <cfif trim(form.PaymentDate) eq ""> 
    <cfset errorMessage = errorMessage & "Payment date is Required.<br>">	
</cfif>


<cfset Today = DateFormat(now(), 'yyyy-mm-dd')>

<cfquery datasource="#request.dsnameWriter#" >


    INSERT INTO [dbo].[Transaction]
        (
            [AccountID]
           ,[PaymentPartyID]
           ,[TransactionCatetoryID]
           ,[RentID]

           ,[Amount]
           ,[TransactionDate]
           ,[TransactionType]

           ,[CreatedBy]
           ,[DateCreated]
        )
     SELECT AccountID
            , PaymentPartyID
            , 6
            , <cfqueryparam cfsqltype="cf_sql_integer" value="#form.RentID#">

            , <cfqueryparam cfsqltype="cf_sql_float" value="#form.PaymentAmount#">
            , <cfqueryparam cfsqltype="cf_sql_timestamp" value="#form.PaymentDate#">
            , 2

            , <cfqueryparam cfsqltype="cf_sql_integer" value="#val(session.profile.AppuserID)#">
            , GETDATE()
        FROM Rent
        WHERE RentID = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.RentID#">;

</cfquery>

    
<cfset session.OnLoadMessage = "success('New Payment for the Rent has added Successfully')">
<cfset relocate (area = "RentTransaction", action = "RentTransactionSelect&RentID=#form.RentID#")>