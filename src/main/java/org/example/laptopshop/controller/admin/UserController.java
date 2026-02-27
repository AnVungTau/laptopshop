package org.example.laptopshop.controller.admin;


import jakarta.validation.Valid;
import org.example.laptopshop.domain.User;
import org.example.laptopshop.service.UserService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Optional;

@Controller
public class UserController {

    private final UserService userService;
    //    private final UploadService uploadService;
    private final PasswordEncoder passwordEncoder;

    public UserController(UserService userService,
                          PasswordEncoder passwordEncoder) {
        this.userService = userService;
//        this.uploadService = uploadService;
        this.passwordEncoder = passwordEncoder;
    }

    @RequestMapping("/")
    public String getHomePage(Model model) {
        List<User> arrUsers = this.userService.getAllUserByEmail("an@gmail.com");
        System.out.println(arrUsers);
        model.addAttribute("service", "test");
        model.addAttribute("helu", "tu model va controller");
        return "hello.jsp";
    }

    @RequestMapping("/admin/user")
    public String getTableUser(Model model, @RequestParam("page") Optional<String> userOptional) {
        int page = 1;

        try {
            if (userOptional.isPresent()) {
                page = Integer.parseInt(userOptional.get());
            }
        } catch (Exception e) {
        }
        Pageable pageable = PageRequest.of(page - 1, 1);

        Page<User> prs = this.userService.getAllUsers(pageable);
        List<User> users = prs.getContent();
        model.addAttribute("users", users);
        model.addAttribute("currPage", page);
        model.addAttribute("totalPage", prs.getTotalPages());
        return "admin/user/show.jsp";
    }

    @RequestMapping("/admin/user/{id}")
    public String getUserDetailPage(Model model, @PathVariable long id) {
        User user = this.userService.getUserById(id);
        model.addAttribute("user", user);
        model.addAttribute("id", id);
        return "admin/user/detail.jsp";
    }

    @RequestMapping("/admin/user/update/{id}")
    public String getUpdateUserPage(Model model, @PathVariable long id) {
        User user = this.userService.getUserById(id);
        model.addAttribute("newUser", user);
        // model.addAttribute("newUser", new User());
        return "admin/user/update.jsp";
    }

    @PostMapping("/admin/user/update")
    public String postUpdateUser(Model model, @ModelAttribute("newUser") @Valid User anUser,
                                 BindingResult userBindingResult) {
        List<FieldError> errors = userBindingResult.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println(">>>" + error.getField() + " - " + error.getDefaultMessage());
        }
        // valid
        if (userBindingResult.hasErrors()) {
            return "admin/user/update.jsp";
        }

        //
        User curruser = this.userService.getUserById(anUser.getId());
        if (curruser != null) {
            curruser.setAddress(anUser.getAddress());
            curruser.setFullName(anUser.getFullName());
            curruser.setPhone(anUser.getPhone());
            this.userService.handleSaveUser(curruser);
        }
        return "redirect:/admin/user";
    }

    @GetMapping("/admin/user/delete/{id}")
    public String deleteUser(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        User user = new User();
        // user.setId(id);
        model.addAttribute("newUser", user);
        return "admin/user/delete.jsp";
    }

    @PostMapping("/admin/user/delete")
    public String postDeleteUser(Model model, @ModelAttribute("newUser") User anUser) {
        this.userService.deleteUser(anUser.getId());
        return "redirect:/admin/user";
    }

    @GetMapping("/admin/user/create")
    public String getCreateUserPage(Model model) {
        model.addAttribute("newUser", new User());
        return "admin/user/create.jsp";
    }

    @PostMapping(value = "/admin/user/create")
    public String createUser(Model model, @ModelAttribute("newUser") @Valid User anUser,
                             BindingResult newUserBindingResult,
                             @RequestParam("file") MultipartFile file) {
        List<FieldError> errors = newUserBindingResult.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println(">>>" + error.getField() + " - " + error.getDefaultMessage());
        }
        // valid
        if (newUserBindingResult.hasErrors()) {
            return "admin/user/create.jsp";
        }

        //
//        String avatar = this.uploadService.handleSaveUploadFile(file, "avatar");
        String hashPassword = this.passwordEncoder.encode(anUser.getPassword());
//        anUser.setAvatar(avatar);
        anUser.setPassword(hashPassword);
        anUser.setRole(this.userService.getRoleByName(anUser.getRole().getName()));
        this.userService.handleSaveUser(anUser);
        return "redirect:/admin/user";
    }

}