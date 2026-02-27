<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%> <%@page
contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />
    <meta name="description" content="Dự án laptopshop" />
    <meta name="author" content="" />
    <title>Dashboard - An</title>

    <link href="/css/styles.css" rel="stylesheet" />
    <script
      src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
      crossorigin="anonymous"
    ></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <script>
      $(document).ready(() => {
        const avatarFile = $("#avatarFile");
        const urlOrg = "/images/product/${newProduct.image}";

        if (urlOrg) {
          $("#avatarPreview").attr("src", urlOrg);
          $("#avatarPreview").css({ display: "block" });
        }
        avatarFile.change(function (e) {
          const imgURL = URL.createObjectURL(e.target.files[0]);
          $("#avatarPreview").attr("src", imgURL);
          $("#avatarPreview").css({ display: "block" });
        });
      });
    </script>
  </head>

  <body class="sb-nav-fixed">
    <jsp:include page="../layout/header.jsp" />
    <div id="layoutSidenav">
      <jsp:include page="../layout/sidebar.jsp" />
      <div id="layoutSidenav_content">
        <main>
          <div class="container-fluid px-4">
            <h1 class="mt-4">Manage Orders</h1>
            <ol class="breadcrumb mb-4">
              <li class="breadcrumb-item active">
                <a href="/admin"> Dashboard</a> /
                <a href="/admin/order">Orders</a> / Update order
              </li>
            </ol>
            <div class="container mt-5">
              <div class="row">
                <div class="col-md-6 mx-auto">
                  <h1>Update a Order</h1>
                  <hr />
                  <form:form
                    method="POST"
                    action="/admin/order/update"
                    modelAttribute="newOrder"
                    enctype="multipart/form-data"
                  >
                    <div class="mb-3" style="display: none">
                      <label for="id" class="form-label">Id: </label>
                      <form:input type="text" class="form-control" path="id" />
                    </div>
                    <div class="row">
                      <div class="col-md-6 mb-3">
                        <label for="name" class="form-label">Id:</label>
                        <form:input
                          type="text"
                          class="form-control"
                          path="id"
                          value="${order.id}"
                          disabled="true"
                        />
                      </div>
                      <div class="col-md-6 mb-3">
                        <label for="price" class="form-label">Price:</label>
                        <form:input
                          type="text"
                          class="form-control"
                          path="totalPrice"
                          disabled="true"
                        />
                      </div>
                    </div>

                    <div class="row">
                      <div class="col-md-6 mb-3">
                        <label for="shortdesc" class="form-label">User:</label>
                        <form:input
                          type="text"
                          class="form-control"
                          path="user.fullName"
                          disabled="true"
                        />
                      </div>
                      <div class="col mb-3">
                        <label for="email" class="form-label">Status:</label>
                        <form:select class="form-select" path="status">
                          <form:option value="PENDING">PENDING</form:option>
                          <form:option value="SHIPPING">SHIPPING</form:option>
                          <form:option value="COMPLETE">COMPLETE</form:option>
                          <form:option value="CANCEL">CANCEL</form:option>
                        </form:select>
                      </div>
                    </div>

                    <button type="submit" class="btn btn-primary">
                      Update
                    </button>
                  </form:form>
                </div>
              </div>
            </div>
          </div>
        </main>
        <jsp:include page="../layout/footer.jsp" />
      </div>
    </div>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
      crossorigin="anonymous"
    ></script>
    <script src="/js/scripts.js"></script>
  </body>
</html>
