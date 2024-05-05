
<cfset errorMessage = "">

<!--- Must have a Transaction ID: url.TransactionID --->
<cfif trim(url.TransactionID) eq "">
    <cfset errorMessage = errorMessage & "Transaction ID is Required.<br>">	
</cfif>

<cfif errorMessage gt "">
    <cfset showErrorMessage (Message = errorMessage)>	
    <cfabort>
</cfif>

<cfquery name="qTransactionSelect" datasource="#request.dsnameReader#">
    SELECT *
        FROM [dbo].[Transaction]
        WHERE TransactionID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.TransactionID#">
</cfquery>



<cfoutput>
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
        
            <div class="card-body">                

                <div class="clearfix"></div><br>
                <hr>

                <form action="partialindex.cfm?area=RentTransaction&action=RentTransactionUpdateAction" class="form-horizontal row-border" method="post" name="formRentTransaction" id="formRentTransaction" target="formpost">

                    <div class="row">

                        <!--- Rent Payment Amount: Amount --->
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="PaymentAmount">Payment Amount ($)*</label>
                                <input required type="number" name="PaymentAmount" id="PaymentAmount" class="form-control required" value="#qTransactionSelect.Amount#">                                
                            </div>
                        </div>

                        <!--- Payment Date: Payment Date --->
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="PaymentDate">Payment Date *</label>
                                <input required class="form-control" id="PaymentDate" name="PaymentDate" type="text" value="#DateFormat(qTransactionSelect.TransactionDate, 'mm/dd/yyyy')#">
                            </div>
                        </div>
                        
                    </div>
                    
                    <input type="hidden" name="RentID" value="#url.RentID#">
                    <input type="hidden" name="TransactionID" value="#url.TransactionID#">

                    <div class="row">  
                        <div class="col-md-12">
                            <button type="submit" class="btn btn-success waves-effect waves-light btn-standard"> Submit</button>
                            <button type="button" class="btn btn-secondary waves-effect btn-standard" data-dismiss="modal">Close</button>
                        </div>                                  
                    </div>
                    
                </form>


            </div>
        </div>
    </div>
</cfoutput> 

<script>

    $('#PaymentDate')
        .datepicker({
            format: 'mm/dd/yyyy',
            autoclose: true,
            orientation: 'bottom',
            immediateUpdates: true,
            todayHighlight: true, 
            todayBtn: true,
        });

</script>