<cfquery datasource="#request.dsnameReader#" name="qPaymentPartySelect"> 
	SELECT *
	FROM PaymentParty 


</cfquery>
				
<div class="row">
	<div class="col-12">
		<div class="page-title-box">
			<h4 class="page-title">Payment Party</h4>
			<div class="page-title-right">
				<ol class="breadcrumb p-0 m-0">
					<li class="breadcrumb-item"><a href="#">Payment Party</a></li>
					<li class="breadcrumb-item active">Payment Party</li>
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
				<h3 class="card-title">Payment Party List</h3>
                <a href="index.cfm?area=PaymentParty&action=PaymentPartyInsert" style="width: auto;" class="btn btn-success custom-btn floatright">Add Payment Party</a>
			</div>
			<div class="card-body">

				<div class="row">
					<div class="col-12">
						<cfoutput>
							<div class="table-responsive">
								<table id="datatable" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                                                
									<thead>
										<tr>
											<th>ID</th>
											<th>Payment Party Name</th>
											<th>Address</th>
											<th>Phone</th>
											<th>Email</th>
											<th>Action</th>
										</tr>
									</thead>

									<tfoot>
										<tr>
											<th>ID</th>
											<th>Payment Party Name</th>
											<th>Address</th>
											<th>Phone</th>
											<th>Email</th>
											<th>Action</th>
										</tr>
									</tfoot>
									<tbody>

									<cfloop query="qPaymentPartySelect">
									<tr>
										<td>#qPaymentPartySelect.CurrentRow#</td>
										<td>#qPaymentPartySelect.PaymentPartyName#</td>
										<td>#qPaymentPartySelect.Address#</td>
										<td>#qPaymentPartySelect.Phone#</td>
										<td>#qPaymentPartySelect.Email#</td>
										<td>
											
										<a href="#cgi.script_name#?area=#url.area#&action=PaymentPartyUpdate&PaymentPartyID=#qPaymentPartySelect.PaymentPartyID#">Edit</a>
											
											
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