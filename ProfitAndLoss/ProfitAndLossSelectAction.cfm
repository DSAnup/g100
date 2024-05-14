
<!--- <cfset session.PropertyID = form.PropertyID> --->


<cfquery datasource="#request.dsnameReader#" name="qProfitAndLossSelect"> 
    SELECT C.PropertyName,
        SUM(CASE 
                WHEN transaction_type = 'Revenue' THEN amount 
                ELSE 0 
            END) AS total_revenue,
            SUM(CASE 
                WHEN transaction_type = 'Expense' THEN amount 
                ELSE 0 
            END) AS total_expense,
            SUM(CASE 
                WHEN transaction_type = 'Revenue' THEN amount 
                ELSE -amount 
            END) AS profit
    FROM (
        SELECT P.PropertyName, SUM(RP.PaymentAmount) AS amount, 'Revenue' AS transaction_type
        FROM Property AS P
        LEFT JOIN Room AS R ON P.PropertyID = R.PropertyID
        LEFT JOIN RentPayment AS RP ON RP.RoomID = R.RoomID
        WHERE 1=1
        <cfif trim(form.PropertyID) neq "">
            AND P.PropertyID = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.PropertyID#">
        </cfif>

        <cfif trim(form.dateFrom) neq "" and trim(form.dateTo) neq "">
            AND RP.PaymentDate BETWEEN 
                    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#form.dateFrom# 00:00:00">
                AND <cfqueryparam cfsqltype="cf_sql_timestamp" value="#form.dateTo# 23:59:59">
        </cfif>
            AND RP.PaymentAmount IS NOT NULL
        GROUP BY P.PropertyName
        UNION ALL
        SELECT  P.PropertyName,  SUM(TD.Amount) AS amount, 'Expense' AS transaction_type
        FROM Property AS P
        LEFT JOIN TransactionDetails AS TD ON TD.PropertyID = P.PropertyID
        WHERE 1=1
        <cfif trim(form.PropertyID) neq "">
            AND P.PropertyID = <cfqueryparam cfsqltype="cf_sql_integer" value="#form.PropertyID#">
        </cfif>

        <cfif trim(form.dateFrom) neq "" and trim(form.dateTo) neq "">
            AND TD.TransactionDate BETWEEN 
                    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#form.dateFrom# 00:00:00">
                AND <cfqueryparam cfsqltype="cf_sql_timestamp" value="#form.dateTo# 23:59:59">
        </cfif> 
            AND TD.Amount IS NOT NULL
        GROUP BY P.PropertyName) AS C
    GROUP BY C.PropertyName
</cfquery>



<cfoutput>
	<div id="searchResult">
        <div class="row">
            <div class="col-12">
                <cfoutput>
                    <div class="container table-responsive">
                        <table id="datatable" class="table table-striped table-bordered" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th> Property</th>
                                    <th> Revenue</th>
                                    <th> Expense</th>
                                    <th> Profit</th>     
                                </tr>
                            </thead>
                
                            <tbody>
                            <cfset index = 0>
                            <cfset grandRevenue = 0>
                            <cfset grandExpense = 0>
                            <cfset grandProfit = 0>
                            <cfloop query="qProfitAndLossSelect">
                                <cfset index = index + 1>
                                <tr>
                                    <td>
                                        #index#
                                    </td>
                                    
                                    <td>
                                        #qProfitAndLossSelect.PropertyName#
                                    </td>
                                    <td>
                                        #dollarFormat(qProfitAndLossSelect.total_revenue)#
                                        <cfset grandRevenue = grandRevenue + qProfitAndLossSelect.total_revenue>
                                    </td>
                                    <td>
                                        #dollarFormat(qProfitAndLossSelect.total_expense)#
                                        <cfset grandExpense = grandExpense + qProfitAndLossSelect.total_expense>
                                    </td>
                                    <td>
                                        #dollarFormat(qProfitAndLossSelect.profit)#
                                        <cfset grandProfit = grandProfit + qProfitAndLossSelect.profit>
                                    </td>
                                </tr>
                            </cfloop>
                            </tbody>
                            <tfoot>
                                <td></td>
                                <td>Total</td>
                                <td>#dollarFormat(grandRevenue)#</td>
                                <td>#dollarFormat(grandExpense)#</td>
                                <td>#dollarFormat(grandProfit)#</td>

                            </tfoot>
                        </table>
                    </div>		
                </cfoutput>

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


