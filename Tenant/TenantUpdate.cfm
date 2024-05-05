<cfquery datasource="#request.dsnameReader#" name="qTenantSelect"> 
    SELECT *
    FROM Tenant 
</cfquery>

<div class="row">
  <div class="col-12">
      <div class="page-title-box">
          <h4 class="page-title">Update Tenant</h4>
          <div class="page-title-right">
              <ol class="breadcrumb p-0 m-0">
                  <li class="breadcrumb-item"><a href="index.cfm?area=dashboard&action=index">Home</a></li>
                  <li class="breadcrumb-item active">Update Tenant</li>
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
              <h3 class="card-title">Update Tenant</h3>
          </div>
          <div class="card-body">

              <div class="row">
                  <div class="col-12">
                      <cfoutput>
                          <div class="container">
                            <div class="row"> 
                                <div class="col-md-6">
                                    <form action="/partialIndex.cfm?area=Tenant&action=TenantUpdateAction" method="post" target="formpost" id="myForm">
                                        <div class="form-group">
                                            <label for="TenantName">Tenant Name *</label>
                                            <input type="text" name="TenantName" id="TenantName" class="form-control required" value="#qTenantSelect.TenantName#">
                                        </div>
                                        <div class="form-group">
                                            <label for="Phone">Phone</label>
                                            <input type="text" name="Phone" id="Phone" class="form-control" value="#qTenantSelect.Phone#">
                                        </div>
                                        <div class="form-group">
                                            <label for="Email">Email</label>
                                            <input type="email" name="Email" id="Email" class="form-control" value="#qTenantSelect.Email#">
                                        </div>
                                        
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="Sex">Sex </label>
                                            <select class="form-control" name="Sex">
                                                <option value="">Choose a Sex</option>
                                                <option value="Male" <cfif qTenantSelect.Sex eq "Male">selected</cfif>>Male</option>
                                                <option value="Female" <cfif qTenantSelect.Sex eq "Female">selected</cfif>>Female</option>
                                                <option value="Others" <cfif qTenantSelect.Sex eq "Others">selected</cfif>>Others</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label for="Status">Status </label>
                                            <select class="form-control" name="isActive">
                                                <option value="">Choose a Status</option>
                                                <option value="1" <cfif qTenantSelect.isActive eq 1>selected</cfif>>Active</option>
                                                <option value="0" <cfif qTenantSelect.isActive eq 0>selected</cfif>>Deactive</option>
                                            </select>
                                        </div>
                                        <div class="float-right">
                                            <input type="hidden" name="TenantID" value="#url.TenantID#" />
                                            <a href="index.cfm?area=Tenant&action=TenantSelect" class="btn btn-danger waves-effect waves-light">Cancel</a>
                                            <button type="reset" class="btn btn-pink waves-effect waves-light">Reset</button>
                                            <button type="submit" class="btn btn-purple waves-effect waves-light">Update Tenant</button>

                                        </div>
                                    
                                    </form>
                                </div>
                            </div>
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






