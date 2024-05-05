
<cfquery datasource="#request.dsnameReader#" name="qAccountSelect"> 
    SELECT AccountID, AccountName
    FROM Account
</cfquery>
<cfquery datasource="#request.dsnameReader#" name="qPaymentPartySelect"> 
    SELECT PaymentPartyID, PaymentPartyName
    FROM PaymentParty
</cfquery>
<div class="row">
  <div class="col-12">
      <div class="page-title-box">
          <h4 class="page-title">Add Rent</h4>
          <div class="page-title-right">
              <ol class="breadcrumb p-0 m-0">
                  <li class="breadcrumb-item"><a href="#">Rent</a></li>
                  <li class="breadcrumb-item active">Add Rent</li>
              </ol>
          </div>
          <div class="clearfix"></div>
      </div>
  </div>
</div>
<div class="row">
  <div class="col-md-12">
      <div class="card">
          <div class="card-body">

              <div class="row">
                  <div class="col-12">
                      <cfoutput>
                          <div class="container">
	
                            <form name="formRent" id="formRent" action="/gate.cfm?area=Rent&action=RentInsertAction" method="post" target="formpost" enctype="multipart/form-data">

                                <div class="row">

                                    <!--- Account Name: AccountID--->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="SourceAccountID">Account Name *</label>
                                            <select required class="form-control required" name="AccountID" id="AccountID" title="Select State ...">
                                                <option value="">Select Account</option>
                                                <cfloop query="qAccountSelect">
                                                    <option value="#qAccountSelect.AccountID#">#qAccountSelect.AccountName#</option>	
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>

                                    <!--- Customer: PaymentPartyID --->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="PaymentPartyID">Customer *</label>
                                            <select  required class="form-control required" name="PaymentPartyID" id="PaymentPartyID" title="Select State ...">
                                                <option value="">Select Payment Party</option>
                                                <cfloop query="qPaymentPartySelect">
                                                    <option value="#qPaymentPartySelect.PaymentPartyID#" <cfif qPaymentPartySelect.PaymentPartyID eq 4>selected</cfif>>#qPaymentPartySelect.PaymentPartyName#</option>	
                                                </cfloop>
                                            </select>
                                        </div>
                                    </div>

                                    <!--- Room No.: RoomNumber --->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="RoomNumber">Room Number *</label>
                                            <input required type="text" name="RoomNumber" id="RoomNumber" class="form-control required">
                                        </div>
                                    </div>                                    

                                    <!--- Rent Due Date: RentDueDate --->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="RentDueDate">Rent Due Date *</label>
                                            <input required class="form-control" id="RentDueDate" name="RentDueDate" type="text" value="#DateFormat(now(), 'mm/dd/yyyy')#">
                                        </div>
                                    </div>

                                    <!--- Rent Amount: RentAmount --->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="RentAmount">Rent Amount *</label>
                                            <input required type="number" name="RentAmount" id="RentAmount" class="form-control required">
                                        </div>
                                    </div>

                                    <!--- NOte --->
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="RentNote">Tenant name/note</label>
                                            <textarea class="form-control" name="RentNote" id="RentNote"></textarea>
                                        </div>
                                    </div>
                                    
                                </div>
                                <div class="row">  
                                    <div class="col-md-12">
                                        <button type="submit" class="btn btn-success waves-effect waves-light btn-standard"> Submit</button>
                                        <a class="btn btn-purple waves-effect waves-light btn-standard" href="#cgi.script_name#?area=#url.area#&action=RentSelect"> Back</a>
                                    </div>                                  
                                </div>
                                <!--- <a class="btn btn-purple waves-effect waves-light" href="#cgi.script_name#?area=#url.area#&action=RentCategorySelect">Back</a> --->
                                <!--- <button type="submit" class="btn btn-success waves-effect waves-light">Submit</button> --->
                                
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
<script>

    $('#RentDueDate')
        .datepicker({
            format: 'mm/dd/yyyy',
            autoclose: true,
            orientation: 'bottom',
            immediateUpdates: true,
            todayHighlight: true, 
            todayBtn: true,
        });

</script>								
                          
                          




