
<cfquery name="qAccountSelect" datasource="#request.dsnameReader#"> 
    SELECT AccountID, AccountName
    FROM Account
</cfquery>

<cfquery name="qPaymentPartySelect" datasource="#request.dsnameReader#"> 
    SELECT PaymentPartyID, PaymentPartyName
    FROM PaymentParty
</cfquery>


<!--- Modal Template --->
<div id="formModal" class="modal bs-example-modal-xl" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true" style="display: none;">
	<div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header d-flex justify-content-between">
                <h5 class="modal-title"></h5>
                <div class="action">
                    <button type="button" class="btn btn-secondary waves-effect" data-dismiss="modal">Close</button>                    
                </div>
            </div>
            <div class="modal-body text-center">
                <div class="spinner-border" style="width: 3rem; height: 3rem;" role="status">
                    <span class="sr-only">Loading...</span>
                </div>
            </div>
            <div class="modal-footer"></div>
        </div>
    </div>
</div>


<div class="row">
	<div class="col-12">
		<div class="page-title-box">
			<h4 class="page-title">Rent History</h4>
			<div class="page-title-right">
				<ol class="breadcrumb p-0 m-0">
					<li class="breadcrumb-item"><a href="#">Rent</a></li>
					<li class="breadcrumb-item active">Rent</li>
				</ol>
			</div>
			<div class="clearfix"></div>
		</div>
	</div>
</div>
<div class="row">
    <div class="col-md-12">
        <div class="card">
            <!--- <div class="card-header">
                <h3 class="card-title">Rent Manager</h3>
                <a href="index.cfm?area=Rent&action=AddRentSelect" style="width:auto;" class="btn btn-success custom-btn floatright">Add New Rent Manager</a>
            </div> --->
            <div class="card-body">
                <div class="row">
                    <div class="col-12">

                        <cfoutput>
                            <div class="container">                                  
                                <form id="formRentSelect" action="/gate.cfm?area=Rent&action=RentSelectAction" method="post" target="formpost">
                                    <div class="row">

                                        <!--- Account: AccountID --->
                                        <div class="col-md-2">
                                            <div class="form-group row">
                                                <label for="AccountID" class="col-form-label col-lg-12 sholwlog-label datasent">Account</label>
                                                <div class="col-lg-12">												
                                                    <select class="form-control required" name="AccountID" id="AccountID">
                                                        <option value="">Show All</option>													
                                                        <cfloop query="qAccountSelect">
                                                            <option value="#qAccountSelect.AccountID#">#qAccountSelect.AccountName#</option>
                                                        </cfloop>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>                                     

                                        <!--- Payment Party: PaymentPartyID --->
                                        <div class="col-md-2">
                                            <div class="form-group row">
                                                <label for="PaymentPartyID" class="col-form-label col-lg-12 sholwlog-label datasent">Payment Party *</label>
                                                <div class="col-lg-12">
                                                    <select class="form-control required" name="PaymentPartyID" id="PaymentPartyID" title="Select State ...">
                                                        <option value="">Show All</option>
                                                        <cfloop query="qPaymentPartySelect">
                                                            <option value="#qPaymentPartySelect.PaymentPartyID#">#qPaymentPartySelect.PaymentPartyName#</option>	
                                                        </cfloop>
                                                    </select>
                                                </div>
                                            </div>
                                        </div> 

                                        <!--- Payment Status: PaymentPartyID --->
                                        <div class="col-md-2">
                                            <div class="form-group row">
                                                <label for="PaymentStatus" class="col-form-label col-lg-12 sholwlog-label datasent">Payment Status *</label>
                                                <div class="col-lg-12">
                                                    <select class="form-control required" name="PaymentStatus" id="PaymentStatus" title="Select State ...">
                                                        <option value="">Show All</option>
                                                        <option value="0">Paid</option>
                                                        <option value="1">Due in 7 Days</option>
                                                        <option value="2">Already Due</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div> 
                                       
                                        
                                        <cfset lastmonth= #dateadd("M", -1, now())#>
                                        <cfset nextmonth= #dateadd("M", 1, now())#>

                                        <!--- Due Date From: dueDateFrom --->
                                        <div class="col-md-2">
                                            <div class="form-group row">
                                                <label for="dateFrom" class="col-form-label col-lg-12">Due Date From</label>
                                                <div class="col-lg-12">
                                                    <input class="form-control" id="dueDateFrom" name="dueDateFrom" type="text" value="#dateformat(lastmonth, "mm/dd/yyyy")#" aria-required="true">
                                                </div>
                                            </div>
                                        </div>

                                        <!--- Due Date To: dueDateTo --->
                                        <div class="col-md-2">
                                            <div class="form-group row">
                                                <label for="dateTo" class="col-form-label col-lg-12">Due Date To</label>
                                                <div class="col-lg-12">
                                                    <input class="form-control DateSent" id="dueDateTo" name="dueDateTo" type="text" value="#dateformat(nextmonth, "mm/dd/yyyy")#" aria-required="true">
                                                </div>
                                            </div>
                                        </div>


                                        <!--- Action Button --->
                                        <div class="col-md-12">
                                            <div class="form-group row">
                                                <div class="col-form-label col-lg-12">&nbsp;</div>
                                                <div class="col-lg-12 d-flex justify-content-end">
                                                    <button type="submit" class="btn btn-purple waves-effect waves-light" style="min-width: 150px;">Search</button>
                                                    <a href="index.cfm?area=Rent&action=RentInsert" class="btn btn-success ml-2" style="min-width: 150px;" >
                                                        <i class="fa fa-plus-circle"></i> Add Rent
                                                    </a>
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
      var table = $('#Resultdatatable').dataTable({"aaSorting": []});
  }

  window.addEventListener('load', (event) => {
        $('#dueDateFrom')
            .datepicker({
                format: 'mm/dd/yyyy',
                autoclose: true,
                orientation: 'bottom',
                immediateUpdates: true,
                todayHighlight: true, 
                todayBtn: true,
            });

        $('#dueDateTo')
            .datepicker({
                format: 'mm/dd/yyyy',
                autoclose: true,
                orientation: 'bottom',
                immediateUpdates: true,
                todayHighlight: true, 
                todayBtn: true,
            });

      formRentSelect.submit();
  });
</script>
                      