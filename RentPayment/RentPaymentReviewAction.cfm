<cfparam name="form.rentMonth" default="">
<script>
    window.parent.document.getElementById('rentMonth').disabled = true;
</script>

<cfset session.rent.selectedMonthYear = form.rentMonth>

<cfset errorMessage = "">

<cfif trim(form.rentMonth) eq "">
	<cfset errorMessage = errorMessage & "Must select a month!<br>">	
</cfif>

<cfif errorMessage gt "">
	<cfset showErrorMessage (Message = errorMessage)>
    <script>
        window.parent.document.getElementById('rentMonth').disabled = false;
    </script>
	<cfabort>
</cfif> 

<cfset session.searchValue.rentMonth = form.rentMonth>


<cfset selectedDateParts = ListToArray(Replace(form.rentMonth, " ", "", "all"), ",") >
<cfset selectedMonth = selectedDateParts[1] >
<cfset selectedYear = selectedDateParts[2] >

<cfset selectedMonthStartDate = ParseDateTime("01 #selectedMonth# #selectedYear#", "dd MMM yyy")>
<cfset selectedMonthEndDate = ParseDateTime("#DaysInMonth(selectedMonthStartDate)# #selectedMonth# #selectedYear#", "dd MMM yyy")>

<cfif selectedMonthEndDate gt now()>
	<cfset selectedMonthEndDate = now()>
</cfif>

<cfquery datasource="#request.dsnameReader#" name="qRentPaymentSelect"> 


	declare @summaryTable table (
		roomID int,
		PaymentAmount float
	)

	insert into @summaryTable (roomID, PaymentAmount)
	select roomid, paymentAmount
		from RentPayment 
		where month(StartDate) = month (#selectedMonthStartDate#) 
			and  year(StartDate) = year (#selectedMonthStartDate#) 


	select r.roomName, p.propertyName, r.MonthlyTarget
			, sum(rp.PaymentAmount) PaymentAmount

			from room r
				join property p on P.PropertyID = R.PropertyID

				
				left join @summaryTable rp on RP.RoomID = R.RoomID 
				
			group by PropertyName, roomName, MonthlyTarget
			order by PropertyName, 
			case IsNumeric(r.RoomName) 
				when 1 then Replicate('0', 100 - Len(r.RoomName)) + r.RoomName
				else r.RoomName
			end
			
			
	
</cfquery>

<cfquery dbtype="query" name="sum"> 
	select sum(PaymentAmount) as total,
			sum(MonthlyTarget) targetTotal
		from qRentPaymentSelect
</cfquery>


<!--- <cfdump var="#Sum#"> --->

<div id="searchResult">

<div class="row">
	<div class="col-md-12">
		<div class="card">
			<div class="card-header">
				<div class="row">
            		<div class="col-md-8 col-sm-8 col-4"><h3 class="card-title">Rent Analysis for <cfoutput>#dateFormat(selectedMonthStartDate, 'mmmm yy')#</cfoutput></h3></div>
            		<div class="col-md-4 col-sm-4 col-8 text-right"> <h3 class="card-title">
						<cfoutput>#dollarFormat(val(sum.total))# out of target #dollarFormat(val(sum.targetTotal))#
								&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
								<span style="color:red;">#int(val(sum.total) / val(sum.targetTotal) * 100)#% Collected</span>

						</cfoutput></h3> </div>
            	</div>
			</div>
			<div class="card-body">

				<div class="row">
					<div class="col-12">
						
							<div class="container table-responsive">
								<table id="datatable" class="table table-striped table-bordered" cellspacing="0" width="100%">
									
									<tbody>
										<cfoutput query="qRentPaymentSelect" group="PropertyName">
											<thead class="thead-dark">
											<tr >
												<th colspan="5">#qRentPaymentSelect.PropertyName#</th>
											</tr>
											</thead>
											<tr>											
												<th> Room Name</th>											
												
												<th> Payment Amount</th>											
												<th> Target</th>
											</tr>
											<cfoutput>
												<tr <cfif qRentPaymentSelect.PaymentAmount lt qRentPaymentSelect.MonthlyTarget>class="text-danger"<cfelse>class="text-success"</cfif>>
													<td>Room No. #qRentPaymentSelect.RoomName#</td>
													
													
													<td>
														#qRentPaymentSelect.PaymentAmount#
													</td>
													<td  >
														#qRentPaymentSelect.MonthlyTarget#
													</td>
												</tr>
											</cfoutput>											
										</cfoutput>
									
									</tbody>
								</table>
							</div>		
						

                   </div>
				</div>

				<!-- End #wizard-vertical -->
			</div>
			<!-- End card-body -->
		</div>
		<!-- End card -->
	</div>
	<!-- end col -->
</div>									

</div>

<script lang="javascript">  
    window.parent.document.getElementById('rentMonth').disabled = false;
	window.parent.document.getElementById('alert').innerHTML  = '' ;
	window.parent.document.getElementById('searchResultContainer').innerHTML  = document.getElementById('searchResult').innerHTML ;  	
	window.parent.loadTable();
	document.getElementById('searchResult').innerHTML  = '';  	
</script>