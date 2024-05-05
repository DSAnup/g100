	
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

    UPDATE [dbo].[Rent]
    SET 
        [AccountID] = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.AccountID#">
        ,[PaymentPartyID] =<cfqueryparam cfsqltype="cf_sql_integer" value="#form.PaymentPartyID#">

        ,[RoomNumber] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.RoomNumber#">     
        ,[RentAmount] = <cfqueryparam cfsqltype="cf_sql_float" value="#form.RentAmount#">
        ,[RentDueDate] = <cfqueryparam cfsqltype="cf_sql_date" value="#form.RentDueDate#">
        ,[RentNote] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Left(form.RentNote, 1000)#">

        
        ,[UpdatedBy] = <cfqueryparam cfsqltype="cf_sql_integer" value="#val(session.profile.AppuserID)#">        
        ,[DateLastUpdated] = GETDATE()
    WHERE 
        RentID = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.RentID#">

</cfquery>

    
<cfset session.OnLoadMessage = "success('The Rent has updated Successfully')">
<cfset relocate (area = "Rent", action = "RentSelect")>