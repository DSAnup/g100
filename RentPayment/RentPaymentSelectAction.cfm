<cfquery datasource="#request.dsnameReader#" name="qRentPaymentSelect"> 
	SELECT RP.*, T.TenantName, R.RoomName, P.PropertyName,
		A.FirstName, A.LastName
    FROM  RentPayment  AS RP  
		LEFT JOIN Tenant AS T ON RP.TenantID = T.TenantID
		LEFT JOIN Room AS R ON RP.RoomID = R.RoomID   
		left join Property as P on  P.PropertyID = R.PropertyID
		left join Appuser A on A.appuserID = RP.createdBy
    WHERE 1=1
        <cfif trim(form.PropertyID) neq "">
            AND P.PropertyID = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.PropertyID#">
        </cfif>

        <cfif trim(form.dateFrom) neq "" and trim(form.dateTo) neq "">
            AND RP.PaymentDate BETWEEN 
                    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#form.dateFrom# 00:00:00">
                AND <cfqueryparam cfsqltype="cf_sql_timestamp" value="#form.dateTo# 23:59:59">
        </cfif> 
</cfquery>

<cfquery dbtype="query" name="sum"> 
	select sum(PaymentAmount) as total
		from qRentPaymentSelect
</cfquery>

<cfoutput>
	<div id="searchResult">
        <div class="row">
            <div class="col-12">
                <div class="card-header">
                    <div class="row">
                        <div class="col-md-8 col-sm-8 col-4"><h3 class="card-title">Payment For <cfoutput>#DateFormat(form.dateFrom, "yyyy-mm-dd")#</cfoutput> To <cfoutput>#DateFormat(form.dateTo, "yyyy-mm-dd")#</cfoutput></h3></div>
                        <div class="col-md-4 col-sm-4 col-8 text-right "><h3 class="card-title" id="balance">Total : #dollarFormat(sum.total)#</h3>
                        </div>
                            
                    </div>
                </div>
                <div class="card-body">
                    <cfoutput>
                        <div class="container table-responsive">
                            <table id="datatable" class="table table-striped table-bordered" cellspacing="0" width="100%">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th> Tenant Name</th>
                                        <th> Room Name</th>
                                        <th> Payment Date</th>
                                        <th> Payment Amount</th>
                                        <th> Added by </th>
                                        <th> Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <cfset grandTotal = 0>
                                    <cfloop query="qRentPaymentSelect">
                                        <tr>
                                            <td>
                                                #currentRow#
                                            </td>
                                            <td>
                                                #qRentPaymentSelect.TenantName#
                                            </td>
                                            <td>
                                                #qRentPaymentSelect.PropertyName#,
                                                Room No. #qRentPaymentSelect.RoomName#
                                            </td>
                                            <td>
                                                #DateFormat(qRentPaymentSelect.PaymentDate, "yyyy-mm-dd")#
                                            </td>
                                            <td>
                                                #qRentPaymentSelect.PaymentAmount#
                                                <cfset grandTotal = grandTotal + qRentPaymentSelect.PaymentAmount>
                                            </td>
                                            <td title="Added on #dateformat(qRentPaymentSelect.DateCreated, 'mmm-dd-yyyy')# @ #timeformat(qRentPaymentSelect.DateCreated, 'HH-mm-nn')#">
                                                #qRentPaymentSelect.FirstName# 
                                                #qRentPaymentSelect.LastName#

                                                <cfif qRentPaymentSelect.dateCreated neq qRentPaymentSelect.dateLastUpdated>
                                                    <i style="color:red;" class="fa fa-info-circle" aria-hidden="true"
                                                    title="Updated on #dateformat(qRentPaymentSelect.DateLastUpdated, 'mmm-dd-yyyy')# @ #timeformat(qRentPaymentSelect.DateLastUpdated, 'HH-mm-nn')#"></i>
                                                </cfif>
                                                                                                
                                            </td>
                                            <td>
                                                <a href="#cgi.script_name#?area=#url.area#&action=RentPaymentUpdate&RentPaymentID=#RentPaymentID#">Edit</a>
                                            </td>
                                        </tr>
                                    </cfloop>
                                
                                </tbody>
                                <tfoot>
                                    <td></td>
                                    <td>Total</td>
                                    <td></td>
                                    <td></td>
                                    <td>#dollarFormat(grandTotal)#</td>

                                </tfoot>
                            </table>
                        </div>		
                    </cfoutput>
                </div>
           </div>
        </div>
    </div>
</cfoutput>

<script lang="javascript">  
    window.parent.document.getElementById('alert').innerHTML  = '' ;
    window.parent.document.getElementById('searchResultContainer').innerHTML  = document.getElementById('searchResult').innerHTML ;  	
    window.parent.loadTable();  
    document.getElementById('searchResult').innerHTML  = ''; 
</script>