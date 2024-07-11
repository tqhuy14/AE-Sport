<style>
    body{
        margin-top:20px;
        background:#f8f8f8
    }
</style>
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
<div class="container">
    <div class="row flex-lg-nowrap">
        <div class="col-12 col-lg-auto mb-3" style="width: 200px;">
            <div class="card p-3">
                <div class="e-navlist e-navlist--active-bg">
                    <ul class="nav">
                        <li class="nav-item"><a class="nav-link px-2 active" href="../Order?action=myOrder"><i class="fa fa-fw fa-bar-chart mr-1"></i><span>My Order</span></a></li>
                        <li class="nav-item"><a class="nav-link px-2 active" href="../Order?action=list"><i class="fa fa-fw fa-bar-chart mr-1"></i><span>Order List</span></a></li>
                        <li class="nav-item"><a class="nav-link px-2" href="${pageContext.request.contextPath}/report?action=registrationReport&period=week" target="__blank"><i class="fa fa-fw fa-cog mr-1"></i><span>Report</span></a></li>
                    </ul>
                </div>
            </div>
        </div>s

        <div class="col">
            <div class="row">
                <div class="col mb-3">
                    <div class="card">
                        <div class="card-body">
                            <div class="e-profile">
                                <div class="row">
                                    <div class="col-12 col-sm-auto mb-3">
                                        <div class="mx-auto" style="width: 140px;">
                                            <div class="d-flex justify-content-center align-items-center rounded" style="height: 140px; background-color: rgb(233, 236, 239);">
                                                <span style="color: rgb(166, 168, 170); font: bold 8pt Arial;">140x140</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col d-flex flex-column flex-sm-row justify-content-between mb-3">
                                        <div class="text-center text-sm-left mb-2 mb-sm-0">
                                            <h4 class="pt-sm-2 pb-1 mb-0 text-nowrap">${sessionScope.CRRAccount.full_Name}</h4>
                                            <p class="mb-0">@${sessionScope.CRRAccount.userName}</p>
                                            <div class="text-muted"><small>Last seen 2 hours ago</small></div>
                                            <div class="mt-2">
                                                <button class="btn btn-primary" type="button">
                                                    <i class="fa fa-fw fa-camera"></i>
                                                    <span>Change Photo</span>
                                                </button>
                                            </div>
                                        </div>                  
                                    </div>
                                </div>
                                <ul class="nav nav-tabs">
                                    <li class="nav-item"><a href="" class="active nav-link">Settings</a></li>
                                </ul>
                                <div class="tab-content pt-3">
                                    <div class="tab-pane active">
                                        <form class="form" novalidate="">
                                            <div class="row">
                                                <div class="col">
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Full Name</label>
                                                                <input id="fullName" class="form-control" value="${sessionScope.CRRAccount.full_Name}" >
                                                            </div>
                                                        </div>
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Username</label>
                                                                <input class="form-control" value="${sessionScope.CRRAccount.userName}" disabled="true">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Email</label>
                                                                <input id="email" class="form-control" value="${sessionScope.CRRAccount.email}" >
                                                            </div>
                                                        </div>
                                                    </div>
                                                   
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Phone</label>
                                                                <input id="phone" class="form-control" value="${sessionScope.CRRAccount.phone_number}" >
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                              <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label>Address</label>
                                                                <input id="phone" class="form-control" value="${sessionScope.CRRAccount.address}" >
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>               
                                                               
                                                    
                                            <div class="col-sm-7">
                                                <div class="row mb-3 fade bg-success" id="profileMessageBox">
                                                    <div class="col-sm-12 text-secondary">
                                                        <p class="text-white text-center" id="profileMessage">Update success</p>
                                                    </div>
                                                </div>
                                            </div>
                                                            
                                            <div class="row">
                                                <div class="col d-flex justify-content-end">
                                                    <button class="btn btn-primary" onclick="updateProfile()" type="button">Save Changes</button>
                                                </div>
                                            </div>
                                        </form>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-md-3 mb-3">
                   
                        <div class="card-body">
                            <div class="px-xl-3">
                                <form action="${pageContext.request.contextPath}/Logout" method="post">
                                    <button type="submit" class="btn btn-block btn-secondary">
                                        <i class="fa fa-sign-out"></i>
                                        <span>Logout</span>
                                    </button>
                                </form>
                            </div>
                        </div>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-body">
                            <h6 class="card-title font-weight-bold">Support</h6>
                            <p class="card-text">Get fast, free help from our friendly assistants.</p>
                            <button type="button" class="btn btn-primary">Contact Us</button>
                        </div>
                    </div>
                </div>
            </div>
            <link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap@4.1.1/dist/css/bootstrap.min.css'>
            <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
            <script src='https://cdn.jsdelivr.net/npm/bootstrap@4.1.1/dist/js/bootstrap.bundle.min.js'></script>
            <script src="../Asset/js/Profile.js"></script>
        </div>
    </div>
</div>