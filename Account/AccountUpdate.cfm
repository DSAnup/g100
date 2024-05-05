<cfquery datasource="#request.dsnameReader#" name="qAccountSelect"> 
	SELECT *
	FROM Account 
    WHERE AccountID = <cfqueryparam cfsqltype="cf_sql_integer" value="#val(URL.AccountID)#">
</cfquery>

<div class="row">
  <div class="col-12">
      <div class="page-title-box">
          <h4 class="page-title">Update Account</h4>
          <div class="page-title-right">
              <ol class="breadcrumb p-0 m-0">
                  <li class="breadcrumb-item"><a href="#">Account</a></li>
                  <li class="breadcrumb-item active">Update Account</li>
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
              <h3 class="card-title">Update Account</h3>
          </div>
          <div class="card-body">

              <div class="row">
                  <div class="col-12">
                      <cfoutput>
                          <div class="container">
	
                            <form action="/gate.cfm?area=Account&action=AccountUpdateAction" method="post" target="formpost" enctype="multipart/form-data">

								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label for="AccountName">Account Name</label>
											<input type="text" name="AccountName" id="AccountName" class="form-control required" value="#qAccountSelect.AccountName#">
										</div>
		
									</div>
								</div>
											
                                <input type="hidden" name="AccountID" id="AccountID" value="#qAccountSelect.AccountID#">
                                <button type="submit" class="btn btn-purple waves-effect waves-light">Submit</button>
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
                          
                          






