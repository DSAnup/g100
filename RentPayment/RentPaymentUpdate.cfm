<cfquery datasource="#request.dsnameReader#" name="qRentPaymentSelect"> 
    SELECT *
    FROM RentPayment 
        WHERE RentPaymentID = <cfqueryparam cfsqltype="cf_sql_integer" value="#RentPaymentID#"> 
</cfquery>

<cfquery datasource="#request.dsnameReader#" name="qTenantSelect"> 
    SELECT *
    FROM  Tenant    
</cfquery>

<cfquery datasource="#request.dsnameReader#" name="qRoomSelect"> 
    SELECT Room.RoomID, Room.RoomName, Property.PropertyName
    FROM  Room   
        join Property on Property.PropertyID = Room.PropertyID 
    order by Property.propertyID, Room.RoomName
</cfquery>

<div class="row">
  <div class="col-12">
      <div class="page-title-box">
          <h4 class="page-title">Update RentPayment</h4>
          <div class="page-title-right">
              <ol class="breadcrumb p-0 m-0">
                  <li class="breadcrumb-item"><a href="index.cfm?area=dashboard&action=index">Home</a></li>
                  <li class="breadcrumb-item active">Update RentPayment</li>
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
              <h3 class="card-title">Update RentPayment</h3>
          </div>
          <div class="card-body">

              <div class="row">
                  <div class="col-12">
                      <cfoutput>
                          <div class="container">
                            <div class="row"> 
                                <div class="col-md-6">
                                    <form action="/partialIndex.cfm?area=RentPayment&action=RentPaymentUpdateAction" method="post" target="formpost" id="myForm">
                                        <div class="form-group">
                                            <label for="TenantID">Tenant *</label>
                                            <select class="form-control" name="TenantID">
                                                <option value="">Choose a Tenant</option>
                                                <cfloop query="qTenantSelect">
                                                    <option value="#qTenantSelect.TenantID#" <cfif qTenantSelect.TenantID eq qRentPaymentSelect.TenantID>selected</cfif>>#qTenantSelect.TenantName#</option>
                                                </cfloop>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label for="RoomID">Room *</label>
                                            <select class="form-control" name="RoomID">
                                                <option value="">Choose a Room</option>
                                                <cfloop query="qRoomSelect" group="PropertyName">
                                                    <optgroup label="#qRoomSelect.PropertyName# ">
                                                    <cfloop>
                                                    <option value="#qRoomSelect.RoomID#" <cfif qRoomSelect.RoomID eq qRentPaymentSelect.RoomID>selected</cfif>>Room No. #qRoomSelect.RoomName#</option>
                                                </cfloop>
                                                </optgroup> 
                                                </cfloop>
                                            </select>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="PaymentDate">Payment Date </label>
                                            <input class="form-control DateSent" id="dateTo" name="PaymentDate" type="text" value="#dateformat(qRentPaymentSelect.PaymentDate, "mm/dd/yyyy")#" aria-required="true">
                                        </div>
                                        
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="StartDate">Start Date </label>
                                            <input class="form-control DateSent" id="StartDate" name="StartDate" type="text" value="#dateformat(qRentPaymentSelect.StartDate, "mm/dd/yyyy")#" aria-required="true">
                                        </div>
                                        <div class="form-group">
                                            <label for="EndDate">End Date </label>
                                            <input class="form-control DateSent" id="EndDate" name="EndDate" type="text" value="#dateformat(qRentPaymentSelect.EndDate, "mm/dd/yyyy")#" aria-required="true">
                                        </div>
                                        <div class="form-group">
                                            <label for="PaymentAmount">Payment Amount </label>
                                            <input type="number" name="PaymentAmount" id="PaymentAmount" class="form-control required" value="#qRentPaymentSelect.PaymentAmount#">
                                        </div>
                                        <div class="float-right">
                                            <input type="hidden" name="RentPaymentID" value="#url.RentPaymentID#" />
                                            <a href="index.cfm?area=RentPayment&action=RentPaymentSelect" class="btn btn-danger waves-effect waves-light">Cancel</a>
                                            <button type="reset" class="btn btn-pink waves-effect waves-light">Reset</button>
                                            <button type="submit" class="btn btn-purple waves-effect waves-light">Update Rent Payment</button>

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

<script>
    $('#dateTo, #StartDate, #EndDate')
        .datepicker({
            format: 'mm/dd/yyyy',
            autoclose: true,
            orientation: 'bottom',
            immediateUpdates: true,
            todayHighlight: true, 
            todayBtn: true,
    });
</script>   





