<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%> <%@page
contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>Fruitables - Vegetable Website Template</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <meta content="" name="keywords" />
    <meta content="" name="description" />

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
      rel="stylesheet"
    />

    <!-- Icon Font Stylesheet -->
    <link
      rel="stylesheet"
      href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"
    />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
      rel="stylesheet"
    />

    <!-- Libraries Stylesheet -->
    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet" />
    <link
      href="/client/lib/owlcarousel/assets/owl.carousel.min.css"
      rel="stylesheet"
    />

    <!-- Customized Bootstrap Stylesheet -->
    <link href="/client/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Template Stylesheet -->
    <link href="/client/css/style.css" rel="stylesheet" />
  </head>

  <body>
    <!-- Spinner Start -->
    <div
      id="spinner"
      class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center"
    >
      <div class="spinner-grow text-primary" role="status"></div>
    </div>
    <!-- Spinner End -->

    <!-- Navbar start -->
    <div class="container-fluid fixed-top">
      <!-- <div class="container topbar bg-primary d-none d-lg-block">
        <div class="d-flex justify-content-between">
          <div class="top-info ps-2">
            <small class="me-3"
              ><i class="fas fa-map-marker-alt me-2 text-secondary"></i>
              <a href="#" class="text-white">123 Street, New York</a></small
            >
            <small class="me-3"
              ><i class="fas fa-envelope me-2 text-secondary"></i
              ><a href="#" class="text-white">Email@Example.com</a></small
            >
          </div>
          <div class="top-link pe-2">
            <a href="#" class="text-white"
              ><small class="text-white mx-2">Privacy Policy</small>/</a
            >
            <a href="#" class="text-white"
              ><small class="text-white mx-2">Terms of Use</small>/</a
            >
            <a href="#" class="text-white"
              ><small class="text-white ms-2">Sales and Refunds</small></a
            >
          </div>
        </div>
      </div> -->
      <jsp:include page="../layout/header.jsp" />
    </div>
    <!-- Navbar End -->

    <!-- Modal Search Start -->

    <!-- Modal Search End -->






    <div class="container-fluid py-5">
        <div class="container py-5">
          <div>
            <ol class="breadcrumb mb-4">
              <li class="breadcrumb-item"><a href="/">Home</a></li>
              <li class="breadcrumb-item active"><a href="/cart">Chi Tiết Giỏ Hàng</a></li>
              <li class="breadcrumb-item active">Thanh Toán</li>
            </ol>
          </div>
            <table class="table">
                <thead>
                    <tr>
                        <th scope="col">Sản phẩm</th>
                        <th scope="col">Tên</th>
                        <th scope="col">Giá cả </th>
                        <th scope="col">Số lượng</th>
                        <th scope="col">Thành tiền</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="cartDetail" items="${cartDetails}">
                    <tr>
                        <th scope="row">
                            <div class="d-flex align-items-center mt-2">
                                <img src="/images/product/${cartDetail.product.image}" class="img-fluid rounded" style="width: 90px; height: 90px;" alt="">
                            </div>
                        </th>
                        <td class="py-5 fs-4">
                            <a href="/product/${cartDetail.product.id}"
                        >${cartDetail.product.name}</a>
                        </td>
                        <td class="py-5">
                            <fmt:formatNumber
                        type="number"
                        value="${cartDetail.product.price}"/>đ
                        </td>
                        <td class="py-5">
                            <p  data-cart-detail-id="${cartDetail.id}" data-cart-detail-price="${cartDetail.price}">${cartDetail.quantity}</p>
                        </td>
                        <td class="py-5 text-danger"><fmt:formatNumber
                            type="number"
                            value="${cartDetail.price * cartDetail.quantity}"
                          />đ</td>
                    </tr>

                    </c:forEach>
                </tbody>
            </table>
        </div>


        <div class="container-fluid col-12">
            <div class="container py-5">
                <h1 class="mb-4">Thông Tin Người Nhận</h1>
                <form:form action="/place-order" method="post" modelAttribute="cart">
                    <input
                    type="hidden"
                    name="${_csrf.parameterName}"
                    value="${_csrf.token}"
                  />

                    <div class="row g-5">
                        <div class="col-md-12 col-lg-6 col-xl-6">
                            <div class="form-item">
                                <label class="form-label ">Tên người nhận</label>
                                <input type="text" class="form-control" name="receiverName" required>
                            </div>
                            <div class="form-item">
                                <label class="form-label ">Địa chỉ người nhận</label>
                                <input type="text" class="form-control" name="receiverAddress" required>
                            </div>
                            <div class="form-item">
                                <label class="form-label ">Số điện thoại</label>
                                <input type="text" class="form-control" name="receiverPhone" required>
                            </div>
                        </div>
                        <div class="col-md-12 col-lg-6 col-xl-6">
                            <div class="table-responsive">
                                <div class="bg-light rounded">
                                    <div class="p-4">
                                      <h1 class="display-6 mb-4">
                                        <span class="fw-normal">Thông Tin Thanh Toán</span>
                                      </h1>
                                      <div class="d-flex justify-content-between mb-4">
                                        <h5 class="mb-0 me-4">Phí vận chuyển</h5>
                                        <p class="mb-0" data-cart-total-price="${total}">
                                          <fmt:formatNumber type="number" value="" />0đ
                                        </p>
                                      </div>
                                      <div class="d-flex justify-content-between">
                                        <h5 class="mb-0 me-4">Hình thức</h5>
                                        <div class="">
                                          <p class="mb-0">Thanh toán khi nhận hàng (COD)</p>
                                        </div>
                                      </div>
                                    </div>
                                    <div
                                      class="py-4 mb-4 border-top border-bottom d-flex justify-content-between"
                                    >
                                      <h5 class="mb-0 ps-4 me-4">Tổng số tiền</h5>
                                      <p class="mb-0 pe-4" data-cart-total-price="${total}">
                                        <fmt:formatNumber type="number" value="${total}" />đ
                                      </p>
                                    </div>
                                    <button
                                      class="btn border-secondary rounded-pill px-4 py-3 text-primary text-uppercase mb-4 ms-4"
                                      type="submit"
                                    >
                                      XÁC NHẬN THANH TOÁN
                                    </button>
                                  </div>

                            </div>

                        </div>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
    <jsp:include page="../layout/footer.jsp" />


    <!-- Back to Top -->
    <a
      href="#"
      class="btn btn-primary border-3 border-primary rounded-circle back-to-top"
      ><i class="fa fa-arrow-up"></i
    ></a>

    <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/client/lib/easing/easing.min.js"></script>
    <script src="/client/lib/waypoints/waypoints.min.js"></script>
    <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="/client/js/main.js"></script>
  </body>
</html>
