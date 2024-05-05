	
<cfdump var="#form#">

<cfset errorMessage = "">

<!--- make sure all required inputs are provided --->
<cfif trim(form.AccountID) eq "">
    <cfset errorMessage = errorMessage & "Account is Required.<br>">	
</cfif>

<cfif trim(form.PaymentPartyID) eq "">
    <cfset errorMessage = errorMessage & "Payment party is Required.<br>">	
</cfif>

<cfif trim(form.RoomNumber) eq "">
    <cfset errorMessage = errorMessage & "Room Number is Required.<br>">	
</cfif>

<cfif trim(form.RentAmount) eq "">
    <cfset errorMessage = errorMessage & "Rent Amount is required.<br>">	
</cfif>
 <cfif trim(form.RentDueDate) eq ""> 
    <cfset errorMessage = errorMessage & "Rent Due date is Required.<br>">	
</cfif>

<cfif errorMessage gt "">
    <cfset showErrorMessage (Message = errorMessage)>	
    <cfabort>
</cfif>  


<cfquery datasource="#request.dsnameWriter#" >

    INSERT INTO [dbo].[Rent]
        (
            [AccountID]
           ,[PaymentPartyID]

           ,[RoomNumber]           
           ,[RentAmount]
           ,[RentDueDate]
           ,[RentNote]

           ,[CreatedBy]
           ,[UpdatedBy]
           ,[DateCreated]
           ,[DateLastUpdated]
        )
    VALUES 
    (
        <cfqueryparam cfsqltype="cf_sql_integer" value="#form.AccountID#">
        ,<cfqueryparam cfsqltype="cf_sql_integer" value="#form.PaymentPartyID#">

        ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.RoomNumber#">
        ,<cfqueryparam cfsqltype="cf_sql_float" value="#form.RentAmount#">
        ,<cfqueryparam cfsqltype="cf_sql_date" value="#form.RentDueDate#">
        ,<cfqueryparam cfsqltype="cf_sql_varchar" value="#Left(form.RentNote, 1000)#">

        ,<cfqueryparam cfsqltype="cf_sql_integer" value="#val(session.profile.AppuserID)#">
        ,<cfqueryparam cfsqltype="cf_sql_integer" value="#val(session.profile.AppuserID)#">
        ,GETDATE()
        ,GETDATE()
    )	

</cfquery>

    
<cfset session.OnLoadMessage = "success('New entry for rent has added Successfully')">
<cfset relocate (area = "Rent", action = "RentSelect")>