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
                            <div class="container">                                  
                                <form id="formTransactionSelect" action="/partialIndex.cfm?area=RentPayment&action=RentPaymentSelectAction" method="post" target="formpost">
                                    <div class="row">

                                        <div class="col-md-4">
                                            <div class="form-group row">
                                                <label for="PropertyID" class="col-form-label col-lg-12 sholwlog-label datasent">Property</label>
                                                <div class="col-lg-12">	
                                                    <cfparam name="session.PropertyID"	 default="">										
                                                    <select class="form-control required" name="PropertyID" id="PropertyID">
                                                        <option value="">Show All</option>													
                                                        <cfloop query="qPropertySelect">
                                                            <option value="#qPropertySelect.PropertyID#" <cfif session.PropertyID eq qPropertySelect.PropertyID>selected</cfif>>#qPropertySelect.PropertyName#</option>
                                                        </cfloop>
                                                        
                                                    </select>
                                                </div>
                                            </div>
                                        </div>        
                                            <cfset currentDate = Now()>
                                            <cfset currentYear = Year(currentDate)>
                                            <cfset currentMonth = Month(currentDate)>
                                            <cfset firstDayOfMonth = CreateDate(currentYear, currentMonth, 1)>

                                        <!--- Date From --->
                                        <div class="col-md-4">
                                            <div class="form-group row">
                                                <label for="dateFrom" class="col-form-label col-lg-12">Date From</label>
                                                <div class="col-lg-12">
                                                    <input class="form-control" id="dateFrom" name="dateFrom" type="text" value="#dateformat(firstDayOfMonth, "mm/dd/yyyy")#" aria-required="true">
                                                </div>
                                            </div>
                                        </div>

                                        <!--- Date To --->
                                        <div class="col-md-4">
                                            <div class="form-group row">
                                                <label for="dateTo" class="col-form-label col-lg-12">Date To</label>
                                                <div class="col-lg-12">
                                                    <input class="form-control DateSent" id="dateTo" name="dateTo" type="text" value="#dateformat(Now(), "mm/dd/yyyy")#" aria-required="true">
                                                </div>
                                            </div>
                                        </div>


                                        <!--- Action Button --->
                                        <div class="col-md-4" id="balance">
                                        </div>
                                        <div class="col-md-4" id="clientbalance">
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group row">
                                                <div class="col-lg-12 d-flex justify-content-end">
                                                    <button type="submit" class="btn btn-purple waves-effect waves-light" style="min-width: 150px;">Search</button>
                                        
                                                </div>
                                            </div>
                                        </div>
                                  </div>                               
                              </form>
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

<!--- alert goes here --->
<div id="alert"></div>

  <!---start search result here --->
  <div id="searchResultContainer">					
  
</div>
<!-- End Row -->
<!--- end search result here --->

<script>
	function loadTable(){
		var table = $('#Resultdatatable').dataTable( { aaSorting : [[0, 'desc']] } );
	}
  
	window.addEventListener('load', (event) => {
		  $('#dateFrom')
			  .datepicker({
				  format: 'mm/dd/yyyy',
				  autoclose: true,
				  orientation: 'bottom',
				  immediateUpdates: true,
				  todayHighlight: true, 
				  todayBtn: true,
			  });
  
		  $('#dateTo')
			  .datepicker({
				  format: 'mm/dd/yyyy',
				  autoclose: true,
				  orientation: 'bottom',
				  immediateUpdates: true,
				  todayHighlight: true, 
				  todayBtn: true,
			  });
  
		formTransactionSelect.submit();
        
	});
  </script>