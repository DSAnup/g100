

<div class="topbar-menu">
    <div class="container-fluid">
        <div id="navigation">
            <!-- Navigation Menu-->
            <ul class="navigation-menu">
            	
            	
            	<cfif session.Profile.isLoggedIn eq true>
	
		                <li class="has-submenu">
	                        <a href="index.cfm?area=dashboard&action=index">
	                            <i class="mdi mdi-book"></i> Dashboard </a>
	                    </li>
						<!--- 	
		                <li class="has-submenu">
	                        <a href="index.cfm?area=Property&action=PropertySelect">
	                            <i class="mdi mdi-book"></i> Property </a>
	                    </li> --->
	
		                <li class="has-submenu">
	                        <a href="index.cfm?area=Property&action=PropertySelect">
	                            <i class="mdi mdi-account-badge-outline"></i> Property </a>
	                    </li>
	
		                
	
						<!--- <li class="has-submenu">
	                        <a href="##"><i class="mdi mdi-bank"></i> Expense </a>
	                        <ul class="submenu">
								<li><a href="index.cfm?area=Expense&action=ExpenseInsert"><i class="mdi mdi-account-cash-outline"></i>  Add Expense</a></li>
								<li><a href="index.cfm?area=Expense&action=ExpenseSelect"><i class="mdi mdi-account-cash-outline"></i>  Expense History</a></li>
	                        	<li><a href="index.cfm?area=Expense&action=ExpenseCategorySelect"><i class="mdi mdi-bank-plus"></i> Expense Categories</a></li>
	                        </ul>
	                    </li> ---> 

						<li class="has-submenu">
	                        <a href="index.cfm?area=Tenant&action=TenantSelect">
	                            <i class="mdi mdi-account-cash-outline"></i> Tenants</a>
	                    </li>
	
						
						<li class="has-submenu">
	                        <a href="index.cfm?area=RentPayment&action=RentPaymentInsert">
	                            <i class="mdi mdi-account-cash-outline"></i> Add Rent Payment</a>
	                    </li>

						<li class="has-submenu">
	                        <a href="index.cfm?area=RentPayment&action=RentPaymentSelect">
	                            <i class="mdi mdi-account-cash-outline"></i>  View Rent Payments</a>
	                    </li>

						<li class="has-submenu">
	                        <a href="index.cfm?area=RentPayment&action=RentPaymentReview">
	                            <i class="mdi mdi-account-cash-outline"></i>  Rent Review</a>
	                    </li>
						
						<li class="has-submenu">
							<a href="index.cfm?area=Transaction&action=TransactionSelect">
							<i class="mdi mdi-equalizer"></i> Expense </a>
						</li>

                <cfelse>

	                <li class="has-submenu">
	                    <a href="index.cfm?area=login&action=login"> <i class="mdi mdi-lock"></i> Log In </a>	                    
	                </li>                
                </cfif>                

            </ul>
            <!-- End navigation menu -->

            <div class="clearfix"></div>
        </div>
        <!-- end #navigation -->
    </div>
    <!-- end container -->
</div>
<!-- end navbar-custom -->