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
  </head>

  <body class="sb-nav-fixed">
    <jsp:include page="../layout/header.jsp" />
    <div id="layoutSidenav">
      <jsp:include page="../layout/sidebar.jsp" />
      <div id="layoutSidenav_content">
        <main>
          <div class="container-fluid px-4">
            <h1 class="mt-4">Manage Users</h1>
            <ol class="breadcrumb mb-4">
              <li class="breadcrumb-item active">
                <a href="/admin"> Dashboard</a> /
                <a href="/admin/user">Users</a> / Update User
              </li>
            </ol>
            <div class="container mt-5">
              <div class="row">
                <div class="col-md-6 mx-auto">
                  <h1>Update a User</h1>
                  <hr />
                  <!-- Form to create a new user -->
                  <form:form
                    method="POST"
                    action="/admin/user/update"
                    modelAttribute="newUser"
                  >
                    <div class="mb-3" style="display: none">
                      <label for="email" class="form-label">Id: </label>
                      <form:input type="text" class="form-control" path="id" />
                    </div>
                    <div class="mb-3">
                      <label for="password" class="form-label">Email:</label>
                      <form:input
                        type="email"
                        class="form-control"
                        path="Email"
                        disabled="true"
                      />
                    </div>
                    <div class="mb-3">
                      <c:set var="errorPhone">
                        <form:errors path="phone" cssClass="invalid-feedback" />
                      </c:set>
                      <label for="phone" class="form-label"
                        >Phone number:</label
                      >
                      <form:input
                        type="text"
                        class="form-control ${not empty errorPhone ? 'is-invalid' : ''}"
                        path="phone"
                      />${errorPhone}
                    </div>
                    <div class="mb-3">
                      <c:set var="errorFullName">
                        <form:errors
                          path="fullName"
                          cssClass="invalid-feedback"
                        />
                      </c:set>
                      <label for="fullName" class="form-label"
                        >Full name:</label
                      >
                      <form:input
                        type="text"
                        class="form-control ${not empty errorFullName ? 'is-invalid' : ''}"
                        path="fullName"
                      />${errorFullName}
                    </div>
                    <div class="mb-3">
                      <label for="address" class="form-label">Address:</label>
                      <form:input
                        type="text"
                        class="form-control"
                        path="address"
                      />
                    </div>
                    <button type="submit" class="btn btn-warning">
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
