

<cfquery name="qRentSelect" datasource="#request.dsnameReader#"> 
    SELECT R.*,
			A.AccountName,
			P.PaymentPartyName,
            TPaidAmount.TotalPaid,
            CASE 
                WHEN R.RentAmount <= TPaidAmount.TotalPaid 
                    THEN 0
                WHEN ( R.RentAmount > TPaidAmount.TotalPaid OR TPaidAmount.TotalPaid IS NULL) AND DATEDIFF(day, GETDATE(), R.RentDueDate) BETWEEN 0 AND 7
                    THEN 2
                WHEN (R.RentAmount > TPaidAmount.TotalPaid OR TPaidAmount.TotalPaid IS NULL) AND DATEDIFF(day, GETDATE(), R.RentDueDate) < 0
                    THEN 3
                ELSE 1
            END PaymentStatus
    FROM [dbo].[Rent] AS R
        LEFT JOIN Account AS A ON A.AccountID = R.AccountID
        LEFT JOIN PaymentParty AS P ON P.PaymentPartyID = R.PaymentPartyID
        LEFT JOIN (
            SELECT [Rent].RentID, SUM([Transaction].Amount) AS TotalPaid
                FROM [Rent]
                    LEFT JOIN [Transaction] ON [Transaction].RentID = [Rent].RentID
                WHERE [Rent].RentID > 0
                GROUP BY [Rent].RentID
        ) AS TPaidAmount ON TPaidAmount.RentID = R.RentID
    WHERE 1=1

        <cfif trim(form.AccountID) neq "">
            AND R.AccountID = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.AccountID#">
        </cfif>

        <cfif trim(form.PaymentPartyID) neq "">
            AND R.PaymentPartyID = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.PaymentPartyID#">
        </cfif>

        <cfif trim(form.PaymentStatus) neq "">
            -- Paid
            <cfif form.PaymentStatus eq 0>
                AND R.RentAmount <= TPaidAmount.TotalPaid
            -- Due in 7 Days
            <cfelseif form.PaymentStatus eq 1>
                AND ( R.RentAmount > TPaidAmount.TotalPaid OR TPaidAmount.TotalPaid IS NULL)
                AND DATEDIFF(day, GETDATE(), R.RentDueDate) BETWEEN 0 AND 7
            -- Already Due
            <cfelseif form.PaymentStatus eq 2>
                AND ( R.RentAmount > TPaidAmount.TotalPaid OR TPaidAmount.TotalPaid IS NULL)
                AND DATEDIFF(day, GETDATE(), R.RentDueDate) < 0
            </cfif>
        </cfif>

        <cfif trim(form.dueDateFrom) neq "" and trim(form.dueDateTo) neq "">
            AND R.RentDueDate BETWEEN 
                    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#form.dueDateFrom# 00:00:00">
                AND <cfqueryparam cfsqltype="cf_sql_timestamp" value="#form.dueDateTo# 23:59:59">
        </cfif>

        ORDER BY PaymentStatus DESC, R.RentDueDate DESC
        
</cfquery>

<!--- <cfdump var="#qRentSelect#"> --->


<cfset local.rentPaidAmount = {}>
<cfquery name="qRentPaidSelect" datasource="#request.dsnameReader#">
    SELECT RentID, SUM(Amount) AS TotalPaid
        FROM [Transaction]
        WHERE RentID IS NOT NULL
            AND RentID > 0
        GROUP BY RentID
</cfquery>


<cfloop query="qRentPaidSelect">
    <cfset local.rentPaidAmount[qRentPaidSelect.RentID] = { TotalPaid : qRentPaidSelect.TotalPaid}>
</cfloop>


<cfoutput>
	<div id="searchResult">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <!--- <div class="card-header">
                        <h3 class="card-title">Rents</h3>                        
                    </div> --->
                    <div class="card-body">

                        <div class="row">
                            <div class="col-12">
                                <cfoutput>
                                    <div class="table-responsive">
                                        <table id="Resultdatatable" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                                                        
                                            <cfloop list="thead" item="item">
                                                <#item#>
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Account</th>
                                                        <th>Payment Party</th>                                                    
                                                        <th>Room Number</th>                                                    
                                                        <th>Rent Amount</th>
                                                        <th>Rent Paid</th>
                                                        <th>Rent Due Date</th>
                                                        <th>Action</th>
                                                    </tr>
                                                </#item#>
                                            </cfloop>                                            
                                            <tbody>            
                                                <cfloop query="qRentSelect">
                                                    <tr>
                                                        <td>#qRentSelect.RentID#</td>
                                                        <td>#qRentSelect.AccountName#</td>
                                                        <td>#qRentSelect.PaymentPartyName#</td>
                                                        <td>#qRentSelect.RoomNumber#</td>
                                                        <td>#qRentSelect.RentAmount#</td>
                                                        <td>
                                                            #qRentSelect.TotalPaid#                                                            
                                                            <cfif qRentSelect.PaymentStatus eq 0>
                                                                <span class="badge badge-success">PAID</span>
                                                            </cfif>                                                            
                                                        </td>
                                                        <td>
                                                            <cfif qRentSelect.PaymentStatus eq 3>
                                                                <h5><span class="badge badge-danger">#DateFormat(qRentSelect.RentDueDate , 'mm/dd/yyyy')#</span></h5>
                                                            <cfelseif qRentSelect.PaymentStatus eq 2>
                                                                <h5><span class="badge badge-warning text-dark">#DateFormat(qRentSelect.RentDueDate , 'mm/dd/yyyy')#</span></h5>
                                                            <cfelse>
                                                                #DateFormat(qRentSelect.RentDueDate , 'mm/dd/yyyy')#
                                                            </cfif>
                                                        </td>
                                                        <td>
                                                            <a class="btn btn-primary" href="index.cfm?area=Rent&action=RentUpdate&RentID=#qRentSelect.RentID#" title="edit">
                                                                <i class="fa fa-edit"></i> Edit
                                                            </a>
                                                            <a class="btn btn-primary" href="index.cfm?area=RentTransaction&action=RentTransactionSelect&RentID=#qRentSelect.RentID#" title="RentPayment">
                                                                <i class="mdi mdi-cash-multiple"></i> Payments
                                                            </a>
                                                            <a href="" class="btn btn-danger text-white btn-delete"
                                                                onclick="loadModal('partialindex.cfm?area=Rent&action=RentDelete&RentID=#qRentSelect.RentID#', $('##formModal'));"
                                                                data-toggle="modal" data-target="##formModal">
                                                                <i class="fa fa-trash"></i> Delete
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </cfloop>

                                            </tbody>
                                        </table>
                                    </div>		
                                </cfoutput>
                            </div>
                        </div>


                        <!-- End wizard-vertical -->
                    </div>
                    <!-- End card-body -->
                </div>
                <!-- End card -->
            </div>
            <!-- end col -->
        </div>	
    </div>
</cfoutput>

<script lang="javascript">  
    window.parent.document.getElementById('alert').innerHTML  = '' ;
    window.parent.document.getElementById('searchResultContainer').innerHTML  = document.getElementById('searchResult').innerHTML ;  	
    window.parent.loadTable();  
    document.getElementById('searchResult').innerHTML  = '';  	
</script>