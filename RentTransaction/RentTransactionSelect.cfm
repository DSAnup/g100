
<cfset errorMessage = "">

<!--- Must have a Rent ID: form.RentID --->
<cfif trim(url.RentID) eq "">
    <cfset errorMessage = errorMessage & "Rent ID is Required.<br>">	
</cfif>

<cfif errorMessage gt "">
    <cfset showErrorMessage (Message = errorMessage)>	
    <cfabort>
</cfif>  


<cfquery name="qRentSelect" datasource="#request.dsnameReader#">
    SELECT R.*,
			A.AccountName,
			P.PaymentPartyName
        FROM [dbo].[Rent] AS R
            JOIN Account AS A ON A.AccountID = R.AccountID
            JOIN PaymentParty AS P ON P.PaymentPartyID = R.PaymentPartyID

        WHERE RentID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.RentID#">
</cfquery>


<cfquery name="qTransactionSelect" datasource="#request.dsnameReader#"> 
    SELECT *
        FROM [dbo].[Transaction]
        WHERE RentID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.RentID#">
</cfquery>

<!--- Modal Template --->
<div id="formModal" class="modal bs-example-modal-xl" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true" style="display: none;">
	<div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header d-flex justify-content-between">
                <h5 class="modal-title"></h5>
                <div class="action">
                    <button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal">Close</button>                    
                </div>
            </div>
            <div class="modal-body text-center">
                <div class="spinner-border" style="width: 3rem; height: 3rem;" role="status">
                    <span class="sr-only">Loading...</span>
                </div>
            </div>
            <div class="modal-footer"></div>
        </div>
    </div>

</div>


<div class="row">
	<div class="col-12">
		<div class="page-title-box">
			<h4 class="page-title">Rent Transaction History</h4>
			<div class="page-title-right">
				<ol class="breadcrumb p-0 m-0">
					<li class="breadcrumb-item"><a href="#">Rent Transaction</a></li>
					<li class="breadcrumb-item active">Rent Transaction</li>
				</ol>
			</div>
			<div class="clearfix"></div>
		</div>
	</div>
</div>

<cfoutput>
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header">
                    <!--- Information Row --->
                    <div class="row">
                        <div class="col-md-12 d-flex flex-wrap information-row">
                            <!--- Rent ID --->
                            <div>
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text font-weight-bold">RentID</span>
                                    </div>
                                    <div class="input-group-append">
                                        <span class="input-group-text">#qRentSelect.RentID#</span>
                                    </div>
                                </div>
                            </div>
                            <!--- Account --->
                            <div>
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text font-weight-bold">Account</span>
                                    </div>
                                    <div class="input-group-append">
                                        <span class="input-group-text">#qRentSelect.AccountName#</span>
                                    </div>
                                </div>
                            </div>
                            <!--- Payment Party --->
                            <div>
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text font-weight-bold">Payment Party</span>
                                    </div>
                                    <div class="input-group-append">
                                        <span class="input-group-text" id="orderQuantityStocked">#qRentSelect.PaymentPartyname#</span>
                                    </div>
                                </div>
                            </div>
                            <!--- Room Number --->
                            <div>
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text font-weight-bold">Room Number</span>
                                    </div>
                                    <div class="input-group-append">
                                        <span class="input-group-text" id="orderQuantityNeeded">#qRentSelect.RoomNumber#</span>
                                    </div>
                                </div>
                            </div>
                            <!--- Rent Amount --->
                            <div>
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text font-weight-bold">Rent Amount</span>
                                    </div>
                                    <div class="input-group-append">
                                        <span class="input-group-text" id="orderQuantityNeeded">$#qRentSelect.RentAmount#</span>
                                    </div>
                                </div>
                            </div>
                            <!--- Rent Due Date --->
                            <div>
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text font-weight-bold">Rent Due Date</span>
                                    </div>
                                    <div class="input-group-append">
                                        <span class="input-group-text">#DateFormat(qRentSelect.RentDueDate, 'dd mmm, yyyy')#</span>
                                    </div>
                                </div>
                            </div>
                            <!--- Note --->
                            <div>
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text font-weight-bold">Note</span>
                                    </div>
                                    <div class="input-group-append">
                                        <span class="input-group-text" id="orderQuantityNeeded">#qRentSelect.RentNote#</span>
                                    </div>
                                </div>
                            </div>
                            
                        </div>
                    </div>                    
                    <a class="btn btn-purple waves-effect waves-light btn-standard float-right" href="index.cfm?area=Rent&action=RentSelect"> Back</a>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-12">                       
                            
                            <div class="table-responsive">
                                <table id="Resultdatatable" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                                    <cfset local.TableColumns = [
                                        "Transaction ID",
                                        "Paid Amount",
                                        "Transaction Date",
                                        "Action"
                                        ]>
                                    <cfloop list="thead" item="item">
                                        <#item#>
                                            <tr>
                                                <cfloop array="#local.TableColumns#" item="item">
                                                    <th>#item#</th>
                                                </cfloop>
                                            </tr>
                                        </#item#>
                                    </cfloop>
                                    <tbody>
                                        <cfset local.TotalPaid = 0>
                                        <cfif qTransactionSelect.recordCount eq 0>
                                            <tr>
                                                <td colspan="#ArrayLen(local.TableColumns)#">
                                                    <div class="alert alert-warning" role="alert">                                    
                                                        No Transaction has made yet!
                                                    </div>                                                    
                                                </td>
                                            </tr>
                                        <cfelse>
                                            <cfloop query="qTransactionSelect">
                                                <cfset local.TotalPaid = local.TotalPaid + qTransactionSelect.Amount>
                                                <tr>
                                                    <td>
                                                        <a href="index.cfm?area=transaction&action=transactionUpdate&TransactionID=#qTransactionSelect.TransactionID#">#qTransactionSelect.TransactionID#</a>
                                                    </td>
                                                    <td>$ #qTransactionSelect.Amount#</td>
                                                    <td>#DateFormat(qTransactionSelect.TransactionDate , 'mm/dd/yyyy')#</td>
                                                    <td>
                                                        <a href="" class="btn btn-primary" 
                                                            onclick="loadModal('partialindex.cfm?area=RentTransaction&action=RentTransactionUpdate&TransactionID=#qTransactionSelect.TransactionID#&RentID=#url.RentID#', $('##formModal'));"
                                                            data-toggle="modal" data-target="##formModal">
                                                            <i class="mdi mdi-pencil"></i>
                                                                Edit
                                                        </a>
                                                        <a href="" class="btn btn-danger text-white btn-delete"
                                                            onclick="loadModal('partialindex.cfm?area=RentTransaction&action=RentTransactionDelete&TransactionID=#qTransactionSelect.TransactionID#&RentID=#url.RentID#', $('##formModal'));"
                                                            data-toggle="modal" data-target="##formModal">
                                                            <i class="fa fa-trash"></i> Delete
                                                        </a>
                                                    </td>
                                                </tr>
                                            </cfloop>                                                            
                                        </cfif>
                                        <tr>
                                            <td><b>Total Paid</b></td>
                                            <td>$ #local.TotalPaid#</td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <cfset local.RemainingAmount = qRentSelect.RentAmount - local.TotalPaid >
                                            <td><b>Remaining Amount</b></td>
                                            <td>$ #local.RemainingAmount#</td>
                                            <td></td>
                                            <td>
                                                <cfif local.RemainingAmount gt 0>
                                                    <a href="" class="btn btn-success"  style="min-width: 150px;"
                                                        onclick="loadModal('partialindex.cfm?area=RentTransaction&action=RentTransactionInsert&RentID=#url.RentID#', $('##formModal'));"
                                                        data-toggle="modal" data-target="##formModal">
                                                        <i class="mdi mdi-plus-circle"></i>
                                                            Add Transaction
                                                    </a>
                                                </cfif>
                                            </td>
                                        </tr>

                                    </tbody>
                                </table>
                            </div>                    
                        </div>
                    </div>            
                </div>            
            </div>
        </div>
    </div>
</cfoutput>
