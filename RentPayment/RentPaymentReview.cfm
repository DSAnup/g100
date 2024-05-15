
<cfparam name="session.rentReview.selectedMonthYear" default="#DateFormat(now(), 'mmm, yyyy')#">

<cfquery datasource="#request.dsnameReader#" name="qPropertySelect"> 
    SELECT P.PropertyName, P.PropertyID
    FROM  Property AS P
</cfquery>

<div class="row">
	<div class="col-12">
		<div class="page-title-box">
			<!--- <h4 class="page-title">Client's Cluster</h4> --->
			<div class="page-title-right">
				<ol class="breadcrumb p-0 m-0">
					<li class="breadcrumb-item"><a href="#">Home</a></li>
					<li class="breadcrumb-item active">Rent Review</li>
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
				<h3 class="card-title floatleft">Rent Review</h3>
			</div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-12">

                        <cfoutput>
                            <form action="/gate.cfm?area=rentPayment&action=rentPaymentReviewAction" id="formPaymentReview" method="POST" target="formpost">
								<div class="row">
									<div class="col-md-3">
										<div class="input-group ">
											<label for="PropertyID" style="padding-right:10px;">Property</label>
											<cfparam name="session.PropertyID"	 default="">										
											<select class="form-control required" name="PropertyID" id="PropertyID" onchange="formPaymentReview.submit()">
												<option value="">Show All</option>													
												<cfloop query="qPropertySelect">
													<option value="#qPropertySelect.PropertyID#" <cfif session.PropertyID eq qPropertySelect.PropertyID>selected</cfif>>#qPropertySelect.PropertyName#</option>
												</cfloop>
											</select>
										</div>
									</div>
									<div class="col-md-3">
										<div class="input-group date">
											<input type="text" class="form-control" id="rentMonth" name="rentMonth" value="#session.rentReview.selectedMonthYear#" onchange="formPaymentReview.submit()">
											<div class="input-group-addon">
												<span class="glyphicon glyphicon-th"></span>
											</div>
										</div>
									</div>
								</div>
							</form>
                        </cfoutput>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<!--- alert goes here --->
<div id="alert"></div>
                
<!---start search result here --->
<div id="searchResultContainer"></div>
<!-- End Row -->
<!--- end search result here --->	

<script>
	let intervalID;

	function loadTable(){
		$('#Resultdatatable').dataTable({
			paging: false,
            order: [[0, 'desc']],
		});
	}

	window.addEventListener('load', (event) => {
		$('#rentMonth')
			.datepicker({
				format: 'M, yyyy',
				startDate: '-1y',
				endDate: '+12m',
				autoclose: true,
				defaultViewDate: 'month',
				minViewMode: 1,
				maxViewMode: 2,
				orientation: 'bottom',
				immediateUpdates: true,
			});

		
            formPaymentReview.submit();

		if (!intervalID) {
			intervalID = setInterval(()=>{
				formPaymentReview.submit();
			}, 5*60*1000)
		}
	})

</script>