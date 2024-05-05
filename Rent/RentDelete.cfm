
<cfset errorMessage = "">

<!--- Must have a Transaction ID: url.TransactionID --->
<cfif trim(url.RentID) eq "">
    <cfset errorMessage = errorMessage & "Rent ID is Required.<br>">	
</cfif>

<cfif errorMessage gt "">
    <cfset showErrorMessage (Message = errorMessage)>	
    <cfabort>
</cfif>

<cfquery name="qRentSelect" datasource="#request.dsnameReader#">
    SELECT *
        FROM [dbo].[Rent]
        WHERE RentID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.RentID#">
</cfquery>



<cfoutput>
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
        
            <div class="card-body">                

                <div class="clearfix"></div><br>
                <hr>

                <form action="partialindex.cfm?area=Rent&action=RentDeleteAction" class="form-horizontal row-border" method="post" name="formRentTransaction" id="formRentTransaction" target="formpost">

                    <div class="alert alert-warning" role="alert">
                        <h4 class="alert-heading">Warning!</h4>
                        Are you sure, you want to remove the Rent Entry for the room number <strong>#qRentSelect.RoomNumber#</strong>
                        with note "#qRentSelect.RentNote#" including all the related transactions
                    </div>
                    
                    <input type="hidden" name="RentID" value="#url.RentID#">

                    <div class="row">  
                        <div class="col-md-12">
                            <button type="submit" class="btn btn-success waves-effect waves-light btn-standard"> Yes</button>
                            <button type="button" class="btn btn-secondary waves-effect btn-standard" data-dismiss="modal">Cancel</button>
                        </div>                                  
                    </div>
                    
                </form>


            </div>
        </div>
    </div>
</cfoutput> 
