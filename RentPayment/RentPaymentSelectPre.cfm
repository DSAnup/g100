<cfquery datasource="#request.dsnameReader#" name="qRentPaymentSelect"> 
	SELECT RP.*, T.TenantName, R.RoomName, P.PropertyName,
		A.FirstName, A.LastName
    FROM  RentPayment  AS RP  
		LEFT JOIN Tenant AS T ON RP.TenantID = T.TenantID
		LEFT JOIN Room AS R ON RP.RoomID = R.RoomID   
		left join Property as P on  P.PropertyID = R.PropertyID
		left join Appuser A on A.appuserID = RP.createdBy
</cfquery>


<cfquery datasource="#request.dsnameReader#" name="qPropertySelect"> 
    SELECT P.PropertyName, P.PropertyID
    FROM  Property AS P
</cfquery>

<div class="row">
	<div class="col-12">
		<div class="page-title-box">
			<h4 class="page-title">Show All RentPayment </h4>
			<div class="page-title-right">
				<ol class="breadcrumb p-0 m-0">
					<li class="breadcrumb-item"><a href="index.cfm?area=dashboard&action=index">Home</a></li>
					<li class="breadcrumb-item active">Show All RentPayment </li>
				</ol>
			</div>
			<div class="clearfix"></div>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-md-12">
		<div class="card">
			<div class="card-header">
				<h3 class="card-title floatleft">Show All RentPayment </h3>
				<a href="index.cfm?area=RentPayment&action=RentPaymentInsert" style="width: auto;" class="btn btn-success custom-btn floatright">Add RentPayment</a>
			</div>
			<div class="card-body">

				<div class="row">
					<div class="col-12">
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
								</table>
							</div>		
						</cfoutput>

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
