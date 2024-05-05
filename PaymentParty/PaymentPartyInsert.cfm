

<div class="row">
  <div class="col-12">
      <div class="page-title-box">
          <h4 class="page-title">Insert Payment Party</h4>
          <div class="page-title-right">
              <ol class="breadcrumb p-0 m-0">
                  <li class="breadcrumb-item"><a href="#">Payment Party</a></li>
                  <li class="breadcrumb-item active">Insert Payment Party</li>
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
              <h3 class="card-title">Insert Payment Party</h3>
          </div>
          <div class="card-body">

              <div class="row">
                  <div class="col-12">
                      <cfoutput>
                          <div class="container">
	
                            <form action="/gate.cfm?area=PaymentParty&action=PaymentPartyInsertAction" method="post" target="formpost" enctype="multipart/form-data">

								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label for="PaymentPartyName">Payment Party Name</label>
											<input type="text" name="PaymentPartyName" id="PaymentPartyName" class="form-control required">
										</div>
										<div class="form-group">
											<label for="Phone">Phone</label>
											<input type="text" name="Phone" id="Phone" class="form-control required">
										</div>
										<div class="form-group">
											<label for="Email">Email</label>
											<input type="text" name="Email" id="Email" class="form-control required">
										</div>
									</div>
                                    <div class="col-md-6">
                                    
										<div class="form-group">
											<label for="Address">Address</label>
                                            <textarea name="Address" id="Address" class="form-control required" style="height: 205px;"></textarea>
										</div>
                                    </div>
								</div>

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
                          
                          






