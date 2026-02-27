<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%> <%@page
contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%><%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>Sản Phẩm</title>
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

    <style>
      .page-link.disable {
        color: var(--bs-pagination-disabled-color);
        pointer-events: none;
        background-color: var(--bs-pagination-disabled-bg);
      }
    </style>
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

    <!-- Fruits Shop Start-->
    <div class="container-fluid fruite py-5">
      <div class="container py-5">
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb mb-5 mt-5">
            <li class="breadcrumb-item"><a href="/">Home</a></li>
            <li class="breadcrumb-item active" aria-current="page">
              Chi Tiết Sản Phẩm
            </li>
          </ol>
        </nav>
        <div class="row g-4">
          <div class="col-lg-12">
            <div class="row g-4">
              <div class="col-lg-3">
                <div class="row">
                  <p>Hãng sản xuất</p>
                </div>
                <div class="row ms-2" id="factoryFilter">
                  <div class="form-check">
                    <input
                      class="form-check-input"
                      type="checkbox"
                      value="APPLE"
                      id="factory-1"
                    />
                    <label class="form-check-label" for="flexCheckDefault">
                      Apple
                    </label>
                  </div>
                  <div class="form-check">
                    <input
                      class="form-check-input"
                      type="checkbox"
                      value="ASUS"
                      id="factory-2"
                    />
                    <label class="form-check-label" for="flexCheckDefault">
                      Asus
                    </label>
                  </div>
                  <div class="form-check">
                    <input
                      class="form-check-input"
                      type="checkbox"
                      value="LENOVO"
                      id="factory-3"
                    />
                    <label class="form-check-label" for="flexCheckDefault">
                      Lenovo
                    </label>
                  </div>
                  <div class="form-check">
                    <input
                      class="form-check-input"
                      type="checkbox"
                      value="DELL"
                      id="factory-4"
                    />
                    <label class="form-check-label" for="flexCheckDefault">
                      Dell
                    </label>
                  </div>
                  <div class="form-check">
                    <input
                      class="form-check-input"
                      type="checkbox"
                      value="LG"
                      id="factory-5"
                    />
                    <label class="form-check-label" for="flexCheckDefault">
                      LG
                    </label>
                  </div>
                  <div class="form-check">
                    <input
                      class="form-check-input"
                      type="checkbox"
                      value="ACER"
                      id="factory-6"
                    />
                    <label class="form-check-label" for="flexCheckDefault">
                      Acer
                    </label>
                  </div>
                </div>
                <div class="row mt-4">
                  <p>Mục đích sử dụng</p>
                </div>
                <div class="row ms-2" id="targetFilter">
                  <div class="form-check">
                    <input
                      class="form-check-input"
                      type="checkbox"
                      value="GAMING"
                      id="target-1"
                    />
                    <label class="form-check-label" for="flexCheckDefault">
                      Gaming
                    </label>
                  </div>
                  <div class="form-check">
                    <input
                      class="form-check-input"
                      type="checkbox"
                      value="SINHVIEN-VANPHONG"
                      id="target-2"
                    />
                    <label class="form-check-label" for="flexCheckDefault">
                      Sinh viên - Văn phòng
                    </label>
                  </div>
                  <div class="form-check">
                    <input
                      class="form-check-input"
                      type="checkbox"
                      value="THIETKEDOHOA"
                      id="target-3"
                    />
                    <label class="form-check-label" for="flexCheckDefault">
                      Thiết kế đồ họa
                    </label>
                  </div>
                  <div class="form-check">
                    <input
                      class="form-check-input"
                      type="checkbox"
                      value="MONGNHE"
                      id="target-4"
                    />
                    <label class="form-check-label" for="flexCheckDefault">
                      Mỏng nhẹ
                    </label>
                  </div>
                  <div class="form-check">
                    <input
                      class="form-check-input"
                      type="checkbox"
                      value="DOANHNHAN"
                      id="target-5"
                    />
                    <label class="form-check-label" for="flexCheckDefault">
                      Doanh nhân
                    </label>
                  </div>
                </div>
                <div class="row mt-4">
                  <p>Mức giá</p>
                </div>
                <div class="row ms-2" id="priceFilter">
                  <div class="form-check">
                    <input
                      class="form-check-input"
                      type="checkbox"
                      value="DUOI-10-TRIEU"
                      id="price-1"
                    />
                    <label class="form-check-label" for="flexCheckDefault">
                      Dưới 10 triệu
                    </label>
                  </div>
                  <div class="form-check">
                    <input
                      class="form-check-input"
                      type="checkbox"
                      value="10-15-trieu"
                      id="price-2"
                    />
                    <label class="form-check-label" for="flexCheckDefault">
                      Từ 10 - 15 Triệu
                    </label>
                  </div>
                  <div class="form-check">
                    <input
                      class="form-check-input"
                      type="checkbox"
                      value="15-20-trieu"
                      id="price-3"
                    />
                    <label class="form-check-label" for="flexCheckDefault">
                      Từ 15 - 20 Triệu
                    </label>
                  </div>
                  <div class="form-check">
                    <input
                      class="form-check-input"
                      type="checkbox"
                      value="tren-20-trieu"
                      id="price-4"
                    />
                    <label class="form-check-label" for="flexCheckDefault">
                      Trên 20 triệu
                    </label>
                  </div>
                </div>
                <div class="row mt-4">
                  <p>Sắp xếp</p>
                </div>
                <div class="row ms-2">
                  <div class="form-check">
                    <input
                      class="form-check-input"
                      type="radio"
                      name="radio-sort"
                      value="gia-tang-dan"
                      id="sort-1"
                    />
                    <label class="form-check-label" for="flexRadioDefault1">
                      Giá tăng dần
                    </label>
                  </div>
                  <div class="form-check">
                    <input
                      class="form-check-input"
                      type="radio"
                      name="radio-sort"
                      value="gia-giam-dan"
                      id="sort-2"
                    />
                    <label class="form-check-label" for="flexRadioDefault2">
                      Giá giảm dần
                    </label>
                  </div>
                  <div class="form-check">
                    <input
                      class="form-check-input"
                      type="radio"
                      name="radio-sort"
                      value="khong-sap-xep"
                      id="sort-3"
                      checked
                    />
                    <label class="form-check-label" for="sort-1">
                      Không sắp xếp
                    </label>
                  </div>
                  <button
                    class="btn border border-secondary rounded-pill px-4 py-2 mt-4 text-primary"
                    id="btnFilter"
                  >
                    lọc sản phẩm
                  </button>
                </div>
              </div>
              <div class="col-lg-9">
                <div class="container-fluid fruite py-5">
                  <div class="container">
                    <div class="tab-class text-center">
                      <div class="tab-content">
                        <div id="tab-1" class="tab-pane fade show p-0 active">
                          <div class="row g-4">
                            <c:if test="${totalPage == 0}">
                              <div>Khong tim thay sang pham</div>
                            </c:if>
                            <div class="col-lg-12">
                              <div class="row g-4">
                                <c:forEach var="product" items="${products}">
                                  <div class="col-md-6 col-lg-4">
                                    <div
                                      class="rounded position-relative fruite-item"
                                    >
                                      <div class="fruite-img">
                                        <img
                                          src="/images/product/${product.image}"
                                          class="img-fluid w-100 rounded-top"
                                          alt=""
                                        />
                                      </div>
                                      <div
                                        class="text-white bg-secondary px-3 py-1 rounded position-absolute"
                                        style="top: 10px; left: 10px"
                                      >
                                        Laptop
                                      </div>
                                      <div
                                        class="p-4 border border-secondary border-top-0 rounded-bottom"
                                      >
                                        <h4 style="font-size: 20px">
                                          <a
                                            href="/product/detail/${product.id}"
                                          >
                                            ${product.name}
                                          </a>
                                        </h4>
                                        <p style="font-size: 13px">
                                          ${product.shortDesc}
                                        </p>
                                        <div
                                          class="d-flex flex-lg-wrap justify-content-center"
                                        >
                                          <p
                                            style="
                                              font-size: 15px;
                                              text-align: center;
                                              width: 100%;
                                            "
                                            class="text-dark fw-bold mb-3"
                                          >
                                            <fmt:formatNumber
                                              type="number"
                                              value="${product.price}"
                                            />đ
                                          </p>
                                          <form
                                            action="/add-product-to-cart/${product.id}"
                                            method="post"
                                          >
                                            <input
                                              type="hidden"
                                              name="${_csrf.parameterName}"
                                              value="${_csrf.token}"
                                            />
                                            <button
                                              href="#"
                                              class="mx-auto btn border border-secondary rounded-pill px-3 text-primary"
                                            >
                                              <i
                                                class="fa fa-shopping-bag me-2 text-primary"
                                              ></i>
                                              Add to cart
                                            </button>
                                          </form>
                                        </div>
                                      </div>
                                    </div>
                                  </div>
                                </c:forEach>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>

                      <c:if test="${totalPage > 0}">
                        <div class="my-pagination">

                          <!-- Prev -->
                          <c:if test="${currPage > 1}">
                            <a href="/product?page=${currPage-1}${queryString}">&laquo;</a>
                          </c:if>

                          <!-- Page number -->
                          <c:forEach begin="1" end="${totalPage}" var="i">
                            <a class="${i == currPage ? 'active' : ''}"
                               href="/product?page=${i}${queryString}">
                                ${i}
                            </a>
                          </c:forEach>

                          <!-- Next -->
                          <c:if test="${currPage < totalPage}">
                            <a href="/product?page=${currPage+1}${queryString}">&raquo;</a>
                          </c:if>

                        </div>
                      </c:if>

                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- Fruits Shop End-->

    <!-- Footer Start -->
    <div class="container-fluid bg-dark text-white-50 footer pt-5 mt-5">
      <div class="container py-5">
        <div
          class="pb-4 mb-4"
          style="border-bottom: 1px solid rgba(226, 175, 24, 0.5)"
        >
          <div class="row g-4">
            <div class="col-lg-3">
              <a href="#">
                <h1 class="text-primary mb-0">Fruitables</h1>
                <p class="text-secondary mb-0">Fresh products</p>
              </a>
            </div>
            <div class="col-lg-6">
              <div class="position-relative mx-auto">
                <input
                  class="form-control border-0 w-100 py-3 px-4 rounded-pill"
                  type="number"
                  placeholder="Your Email"
                />
                <button
                  type="submit"
                  class="btn btn-primary border-0 border-secondary py-3 px-4 position-absolute rounded-pill text-white"
                  style="top: 0; right: 0"
                >
                  Subscribe Now
                </button>
              </div>
            </div>
            <div class="col-lg-3">
              <div class="d-flex justify-content-end pt-3">
                <a
                  class="btn btn-outline-secondary me-2 btn-md-square rounded-circle"
                  href=""
                  ><i class="fab fa-twitter"></i
                ></a>
                <a
                  class="btn btn-outline-secondary me-2 btn-md-square rounded-circle"
                  href=""
                  ><i class="fab fa-facebook-f"></i
                ></a>
                <a
                  class="btn btn-outline-secondary me-2 btn-md-square rounded-circle"
                  href=""
                  ><i class="fab fa-youtube"></i
                ></a>
                <a
                  class="btn btn-outline-secondary btn-md-square rounded-circle"
                  href=""
                  ><i class="fab fa-linkedin-in"></i
                ></a>
              </div>
            </div>
          </div>
        </div>
        <div class="row g-5">
          <div class="col-lg-3 col-md-6">
            <div class="footer-item">
              <h4 class="text-light mb-3">Why People Like us!</h4>
              <p class="mb-4">
                typesetting, remaining essentially unchanged. It was popularised
                in the 1960s with the like Aldus PageMaker including of Lorem
                Ipsum.
              </p>
              <a
                href=""
                class="btn border-secondary py-2 px-4 rounded-pill text-primary"
                >Read More</a
              >
            </div>
          </div>
          <div class="col-lg-3 col-md-6">
            <div class="d-flex flex-column text-start footer-item">
              <h4 class="text-light mb-3">Shop Info</h4>
              <a class="btn-link" href="">About Us</a>
              <a class="btn-link" href="">Contact Us</a>
              <a class="btn-link" href="">Privacy Policy</a>
              <a class="btn-link" href="">Terms & Condition</a>
              <a class="btn-link" href="">Return Policy</a>
              <a class="btn-link" href="">FAQs & Help</a>
            </div>
          </div>
          <div class="col-lg-3 col-md-6">
            <div class="d-flex flex-column text-start footer-item">
              <h4 class="text-light mb-3">Account</h4>
              <a class="btn-link" href="">My Account</a>
              <a class="btn-link" href="">Shop details</a>
              <a class="btn-link" href="">Shopping Cart</a>
              <a class="btn-link" href="">Wishlist</a>
              <a class="btn-link" href="">Order History</a>
              <a class="btn-link" href="">International Orders</a>
            </div>
          </div>
          <div class="col-lg-3 col-md-6">
            <div class="footer-item">
              <h4 class="text-light mb-3">Contact</h4>
              <p>Address: 1429 Netus Rd, NY 48247</p>
              <p>Email: Example@gmail.com</p>
              <p>Phone: +0123 4567 8910</p>
              <p>Payment Accepted</p>
              <img src="/client/img/payment.png" class="img-fluid" alt="" />
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- Footer End -->

    <!-- Copyright Start -->
    <div class="container-fluid copyright bg-dark py-4">
      <div class="container">
        <div class="row">
          <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
            <span class="text-light"
              ><a href="#"
                ><i class="fas fa-copyright text-light me-2"></i>Your Site
                Name</a
              >, All right reserved.</span
            >
          </div>
          <div class="col-md-6 my-auto text-center text-md-end text-white">
            <!--/*** This template is free as long as you keep the below author’s credit link/attribution link/backlink. ***/-->
            <!--/*** If you'd like to use the template without the below author’s credit link/attribution link/backlink, ***/-->
            <!--/*** you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". ***/-->
            Designed By
            <a class="border-bottom" href="https://htmlcodex.com">HTML Codex</a>
            Distributed By
            <a class="border-bottom" href="https://themewagon.com"
              >ThemeWagon</a
            >
          </div>
        </div>
      </div>
    </div>
    <!-- Copyright End -->

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
