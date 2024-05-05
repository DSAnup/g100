<cfquery datasource="#request.dsnameReader#" name="qPropertySelect"> 
	SELECT *
	FROM Property 
</cfquery>
					
<div class="row">
	<div class="col-12">
		<div class="page-title-box">
			<h4 class="page-title">Property</h4>
			<div class="page-title-right">
				<ol class="breadcrumb p-0 m-0">
					<li class="breadcrumb-item"><a href="#">Property</a></li>
					<li class="breadcrumb-item active">Property</li>
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
				<h3 class="card-title">Property Details</h3>
                <a href="index.cfm?area=Property&action=PropertyInsert" style="width: auto;" class="btn btn-success custom-btn floatright">Add Property</a>
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
											<th>Property</th>											
											<th>Action</th>
										</tr>
									</thead>
                                  
									<tfoot>
										<tr>
											<th>ID</th>
											<th>Property</th>											
											<th>Action</th>
										</tr>
									</tfoot>
									<tbody>
										
									<cfloop query="qPropertySelect">
									<tr>
										<td>#qPropertySelect.PropertyID#</td>
										<td>#qPropertySelect.PropertyName#</td>										
										<td>
											
										<a href="#cgi.script_name#?area=#url.area#&action=PropertyUpdate&PropertyID=#qPropertySelect.PropertyID#">Edit</a>
											
											
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