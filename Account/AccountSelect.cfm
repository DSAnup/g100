<cfquery datasource="#request.dsnameReader#" name="qHomeSelect"> 
	SELECT *
	FROM Account 
	-- SELECT Account.*,
	-- State.StateName
	-- FROM Account 
	-- LEFT JOIN State ON State.StateID = Account.StateID

</cfquery>
					
<div class="row">
	<div class="col-12">
		<div class="page-title-box">
			<h4 class="page-title">Account</h4>
			<div class="page-title-right">
				<ol class="breadcrumb p-0 m-0">
					<li class="breadcrumb-item"><a href="#">Account</a></li>
					<li class="breadcrumb-item active">Account</li>
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
				<h3 class="card-title">Account List</h3>
                <a href="index.cfm?area=Account&action=AccountInsert" style="width: auto;" class="btn btn-success custom-btn floatright">Add Account</a>
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
											<th>Account Name</th>
											<th>Action</th>
										</tr>
									</thead>

									<tfoot>
										<tr>
											<th>ID</th>
											<th>Account Name</th>
											<th>Action</th>
										</tr>
									</tfoot>
									<tbody>

									<cfloop query="qHomeSelect">
									<tr>
										<td>#qHomeSelect.CurrentRow#</td>
										<td>#qHomeSelect.AccountName#</td>
										<td>
											
										<a href="#cgi.script_name#?area=#url.area#&action=AccountUpdate&AccountID=#qHomeSelect.AccountID#">Edit</a>
											
											
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