<cfquery datasource="#request.dsnameReader#" name="qPropertySelect"> 
	SELECT *
	FROM Property 
    WHERE PropertyID = <cfqueryparam cfsqltype="cf_sql_integer" value="#val(URL.PropertyID)#">
</cfquery>
				
<div class="row">
  <div class="col-12">
      <div class="page-title-box">
          <h4 class="page-title">Update Property </h4>
          <div class="page-title-right">
              <ol class="breadcrumb p-0 m-0">
                  <li class="breadcrumb-item"><a href="#">Property</a></li>
                  <li class="breadcrumb-item active">Update Property </li>
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
              <h3 class="card-title">Update Property  Information</h3>
          </div>
          <div class="card-body">

              <div class="row">
                  <div class="col-12">
                      <cfoutput>
                          <div class="container">
	
                            <form action="/gate.cfm?area=Property&action=PropertyUpdateAction" method="post" target="formpost" enctype="multipart/form-data">
          							
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label for="AddressLine1">Property</label>
											<input type="text" name="propertyName" id="propertyName" class="form-control required" value="#qPropertySelect.propertyName#">
										</div>
									</div>									
								</div>
                                <input type="hidden" name="PropertyID" id="PropertyID" value="#qPropertySelect.PropertyID#">
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
                          
                          






