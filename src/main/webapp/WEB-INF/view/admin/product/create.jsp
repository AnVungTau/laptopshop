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
    <title>Create - An</title>

    <link href="/css/styles.css" rel="stylesheet" />
    <script
      src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
      crossorigin="anonymous"
    ></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <script>
        $(document).ready(() => {
            const avatarFile = $("#avatarFile");
            avatarFile.change(function (e) {
                const imgURL = URL.createObjectURL(e.target.files[0]);
                $("#avatarPreview").attr("src", imgURL);
                $("#avatarPreview").css({ "display": "block" });
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
            <h1 class="mt-4">Create Product</h1>
            <ol class="breadcrumb mb-4">
              <li class="breadcrumb-item active">
                <a href="/admin"> Dashboard</a> /
                <a href="/admin/product">product</a> / Create a product
              </li>
            </ol>
            <div class="container mt-5">
              <div class="row">
                <div class="col-md-6 mx-auto">
                  <h1>Create a product</h1>
                  <hr />
                  <!-- Form to create a new user -->
                  <form:form
                    method="POST"
                    action="/admin/product/create"
                    modelAttribute="newProduct"
                    enctype="multipart/form-data"
                  >
                    <div class="row">
                      <div class="col-md-6 mb-3">
                        <c:set var="errorName">
                          <form:errors path="name" cssClass="invalid-feedback"/>
                          </c:set>
                        <label for="name" class="form-label">Name:</label>
                        <form:input
                          type="text"
                          class="form-control ${not empty errorName ? 'is-invalid': ''}"
                          path="name"
                        />${errorName}
                      </div>
                      <div class="col-md-6 mb-3">
                        <c:set var="errorPrice">
                          <form:errors path="price" cssClass="invalid-feedback"/>
                          </c:set>
                        <label for="price" class="form-label"
                          >Price:</label
                        >
                        <form:input
                          type="text"
                          class="form-control ${not empty errorPrice ? 'is-invalid' : ''}"
                          path="price"
                        />${errorPrice}
                      </div>
                    </div>
                      <div class="col-md-12 mb-3 ">
                        <c:set var="errorDes">
                          <form:errors path="detailDesc" cssClass="invalid-feedback"/>
                          </c:set>
                        <label for="description" class="form-label"
                          >Description:</label
                        >
                        <form:input
                          type="text"
                          class="form-control ${not empty errorDes ? 'is-invalid' : '' }"
                          path="detailDesc"
                          style="width: 100%; height: 65px;"
                        />${errorDes}
                      </div>
                    <div class="row">
                      <div class="col-md-6 mb-3">
                        <c:set var="errorShortDes">
                          <form:errors path="shortDesc" cssClass="invalid-feedback"/>
                          </c:set>
                        <label for="shortdesc" class="form-label"
                          >short Description:</label
                        >
                        <form:input
                          type="text"
                          class="form-control ${not empty errorShortDes ? 'is-invalid' : ''}"
                          path="shortDesc"
                        />${errorShortDes}
                      </div>
                      <div class="col mb-3">
                        <c:set var="errorQuantity">
                          <form:errors path="quantity" cssClass="invalid-feedback"/>
                          </c:set>
                        <label for="address" class="form-label">Quantity:</label>
                        <form:input
                          type="text"
                          class="form-control ${not empty errorQuantity ? 'is-invalid' : ''}"
                          path="quantity"
                        />${errorQuantity}
                    </div>
                    </div>

                    <div class="row">
                      <div class="col-md-6 mb-3">
                        <label for="email" class="form-label">Factory:</label>
                        <form:select
                          class="form-select" path="factory"
                        >
                        <form:option value="APPLE">Apple (MacBook)</form:option>
                        <form:option value="ASUS">Asus</form:option>
                        <form:option value="LENOVO">Lenovo</form:option>
                        <form:option value="DELL">Dell</form:option>
                        <form:option value="LG">LG</form:option>
                        <form:option value="ACER">Acer</form:option>
                        </form:select>
                      </div>
                      <div class="col-md-6 mb-3">
                        <label for="email" class="form-label">Target:</label>
                        <form:select
                          class="form-select" path="target"
                        >
                          <form:option value="GAMING">Gaming</form:option>
                          <form:option value="SINH_VIEN_VAN_PHONG">Sinh viên - Văn phòng</form:option>
                          <form:option value="THIET_KE_DO_HOA">Thiết kế đồ họa</form:option>
                          <form:option value="MONG_NHE">Mỏng nhẹ</form:option>
                          <form:option value="DOANH_NHAN">Doanh nhân</form:option>

                        </form:select>
                      </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="avatar" class="form-label">Avatar:</label>
                        <input class="form-control" type="file" id="avatarFile" accept=".jpg, .png, .jpeg" name="file"/>
                      </div>
                    <div class="mb-3"><img style="max-height: 250px; display: none;" alt="avatar preview" id="avatarPreview"></div>
                    <button type="submit" class="btn btn-primary">
                      Create
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
