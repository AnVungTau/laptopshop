<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%> <%@page
contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
            <h1 class="mt-4">Manage Orders</h1>
            <ol class="breadcrumb mb-4">
              <li class="breadcrumb-item active">
                <a href="/admin"> Dashboard</a> / <a href="/admin"> Orders</a> /
                Orders detail
              </li>
            </ol>

            <div>
              <div class="d-flex">
                <h3>Table orders</h3>
              </div>
              <hr />
              <table class="table table-bordered table-hover">
                <thead>
                  <tr>
                    <th scope="col">Sản Phẩm</th>
                    <th scope="col">Tên</th>
                    <th scope="col">Giá</th>
                    <th scope="col">Số lượng</th>
                    <th scope="col">Thành tiền</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="order" items="${orderDetails}">
                    <tr>
                      <th scope="row">
                        <div class="d-flex align-items-center">
                          <img
                            src="/images/product/${order.product.image}"
                            class="img-fluid me-5 rounded-circle"
                            style="width: 80px; height: 80px"
                            alt=""
                          />
                        </div>
                      </th>
                      <td>
                        <p class="mt-4">
                          <a href="/product/${order.product.id}"
                            >${order.product.name}</a
                          >
                        </p>
                      </td>
                      <td>
                        <p class="mt-4">
                          <fmt:formatNumber
                            type="number"
                            value="${order.product.price}"
                          />đ
                        </p>
                      </td>
                      <td>
                        <div class="mt-4">
                          <p>${order.quantity}</p>
                        </div>
                      </td>
                      <td>
                        <p class="mt-4" data-cart-detail-id="${order.id}">
                          <fmt:formatNumber
                            type="number"
                            value="${order.price * order.quantity}"
                          />đ
                        </p>
                      </td>
                    </tr></c:forEach
                  >
                </tbody>
              </table>
              <a href="/admin/order" class="btn btn-success">Back</a>
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
