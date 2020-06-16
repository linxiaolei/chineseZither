package com.system.controller;

import com.system.exception.CustomException;
import com.system.po.*;
import com.system.service.*;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import java.util.List;


/**
 * Created by Jacey on 2017/6/30.
 */
@Controller
@RequestMapping("/admin")
public class AdminController {

    @Resource(name = "studentServiceImpl")
    private StudentService studentService;
    
    @Resource(name = "orderServiceImpl")
    private OrderService orderService;

    @Resource(name = "teacherServiceImpl")
    private TeacherService teacherService;

    @Resource(name = "courseServiceImpl")
    private CourseService courseService;

    @Resource(name = "collegeServiceImpl")
    private CollegeService collegeService;

    @Resource(name = "userloginServiceImpl")
    private UserloginService userloginService;
    
    @Resource(name = "productServiceImpl")
    private ProductService productService;
    
    @Resource(name = "workspaceServiceImpl")
    private WorkspaceService workspaceService;


    @RequestMapping("/showStudent")
    public String showStudent(Model model, Integer page) throws Exception {

        List<StudentCustom> list = null;

        PagingVO pagingVO = new PagingVO();
   
        pagingVO.setTotalCount(studentService.getCountStudent());
        if (page == null || page == 0) {
            pagingVO.setToPageNo(1);
            list = studentService.findByPaging(1);
        } else {
            pagingVO.setToPageNo(page);
            list = studentService.findByPaging(page);
        }
     StudentCustom s=list.get(0);
     System.out.println(s.getteacherName());
        model.addAttribute("studentList", list);
        model.addAttribute("pagingVO", pagingVO);

        return "admin/showStudent";

    }

    @RequestMapping("/showOrder")
    public String showOrder(Model model, Integer page) throws Exception {

    	List<Order> list = null;
       
        list=orderService.findAll();

        model.addAttribute("orderList", list);
   

        return "admin/showOrder";


    }
    
    @RequestMapping("/deleteOrder")
    public String deleteOrder(Integer id) throws Exception {
        orderService.deleteById(id);
        return "redirect:/admin/showOrder";


    }
    

    @RequestMapping(value = "/addStudent", method = {RequestMethod.GET})
    public String addStudentUI(Model model) throws Exception {

        List<College> list = collegeService.finAll();
        List<TeacherCustom> teacher=teacherService.findAll();
        model.addAttribute("collegeList", list);
        model.addAttribute("teacherList",teacher);

        return "admin/addStudent";
    }

  
    @RequestMapping(value = "/addStudent", method = {RequestMethod.POST})
    public String addStudent(StudentCustom studentCustom, Model model) throws Exception {

        Boolean result = studentService.save(studentCustom);

        if (!result) {
            model.addAttribute("message", "失败");
            return "error";
        }
 
        Userlogin userlogin = new Userlogin();
        userlogin.setUsername(studentCustom.getUserid().toString());
        userlogin.setPassword("123");
        userlogin.setRole(2);
        userloginService.save(userlogin);

  
        return "redirect:/admin/showStudent";
    }

    
    @RequestMapping(value = "/editStudent", method = {RequestMethod.GET})
    public String editStudentUI(String id, Model model) throws Exception {
        if (id == null) {
           
            return "redirect:/admin/showStudent";
        }
        StudentCustom studentCustom = studentService.findById(id);
        if (studentCustom == null) {
            throw new CustomException("error");
        }
        List<College> list = collegeService.finAll();
        List<TeacherCustom> teacher = teacherService.findAll();
        model.addAttribute("collegeList", list);
        model.addAttribute("teacherList", teacher);
        model.addAttribute("student", studentCustom);


        return "admin/editStudent";
    }


    @RequestMapping(value = "/editStudent", method = {RequestMethod.POST})
    public String editStudent(StudentCustom studentCustom) throws Exception {

        studentService.updataById(studentCustom.getUserid(), studentCustom);

   
        return "redirect:/admin/showStudent";
    }

 
    @RequestMapping(value = "/removeStudent", method = {RequestMethod.GET} )
    private String removeStudent(String id) throws Exception {
        if (id == null) {
            
            return "admin/showStudent";
        }
       StudentCustom studentcustom= null;
       studentcustom=studentService.findStudentAndSelectCourseListByName(id);
        if(studentcustom==null) {
        	studentService.removeById(id);
            userloginService.removeByName(id.toString());
        } else {
        	 throw new CustomException("该学生已经选课，不能再删除");
        }
        

        return "redirect:/admin/showStudent";
    }

    @RequestMapping(value = "selectStudent", method = {RequestMethod.POST})
    private String selectStudent(String findByName, Model model) throws Exception {

        List<StudentCustom> list = studentService.findByName(findByName);

        model.addAttribute("studentList", list);
        return "admin/showStudent";
    }

    @RequestMapping("/showTeacher")
    public String showTeacher(Model model, Integer page) throws Exception {

        List<TeacherCustom> list = null;
        PagingVO pagingVO = new PagingVO();
        pagingVO.setTotalCount(teacherService.getCountTeacher());
        if (page == null || page == 0) {
            pagingVO.setToPageNo(1);
            list = teacherService.findByPaging(1);
        } else {
            pagingVO.setToPageNo(page);
            list = teacherService.findByPaging(page);
        }

        model.addAttribute("teacherList", list);
        model.addAttribute("pagingVO", pagingVO);

        return "admin/showTeacher";

    }


    @RequestMapping(value = "/addTeacher", method = {RequestMethod.GET})
    public String addTeacherUI(Model model) throws Exception {

        List<College> list = collegeService.finAll();

        model.addAttribute("collegeList", list);

        return "admin/addTeacher";
    }

   
    @RequestMapping(value = "/addTeacher", method = {RequestMethod.POST})
    public String addTeacher(TeacherCustom teacherCustom, Model model) throws Exception {

        Boolean result = teacherService.save(teacherCustom);

        if (!result) {
            model.addAttribute("message", "添加失败");
            return "error";
        }
        Userlogin userlogin = new Userlogin();
        userlogin.setUsername(teacherCustom.getUserid().toString());
        userlogin.setPassword("123");
        userlogin.setRole(1);
        userloginService.save(userlogin);

        return "redirect:/admin/showTeacher";
    }

    
    @RequestMapping(value = "/editTeacher", method = {RequestMethod.GET})
    public String editTeacherUI(Integer id, Model model) throws Exception {
        if (id == null) {
            return "redirect:/admin/showTeacher";
        }
        TeacherCustom teacherCustom = teacherService.findById(id);
        if (teacherCustom == null) {
            throw new CustomException("error");
        }
        List<College> list = collegeService.finAll();
        model.addAttribute("collegeList", list);
        model.addAttribute("teacher", teacherCustom);


        return "admin/editTeacher";
    }


    @RequestMapping(value = "/editTeacher", method = {RequestMethod.POST})
    public String editTeacher(TeacherCustom teacherCustom) throws Exception {

        teacherService.updateById(teacherCustom.getUserid(), teacherCustom);

   
        return "redirect:/admin/showTeacher";
    }


    @RequestMapping("/removeTeacher")
    public String removeTeacher(Integer id) throws Exception {
        if (id == null) {
           
            return "admin/showTeacher";
        }
        teacherService.removeById(id);
        userloginService.removeByName(id.toString());

        return "redirect:/admin/showTeacher";
    }


    @RequestMapping(value = "selectTeacher", method = {RequestMethod.POST})
    private String selectTeacher(String findByName, Model model) throws Exception {

        List<TeacherCustom> list = teacherService.findByName(findByName);

        model.addAttribute("teacherList", list);
        return "admin/showTeacher";
    }


    @RequestMapping("/showCourse")
    public String showCourse(Model model, Integer page) throws Exception {

        List<CourseCustom> list = null;
    
        PagingVO pagingVO = new PagingVO();
 
        pagingVO.setTotalCount(courseService.getCountCouse());
        if (page == null || page == 0) {
            pagingVO.setToPageNo(1);
            list = courseService.findByPaging(1);
        } else {
            pagingVO.setToPageNo(page);
            list = courseService.findByPaging(page);
        }

        model.addAttribute("courseList", list);
        model.addAttribute("pagingVO", pagingVO);

        return "admin/showCourse";

    }


    @RequestMapping(value = "/addCourse", method = {RequestMethod.GET})
    public String addCourseUI(Model model) throws Exception {

        List<TeacherCustom> list = teacherService.findAll();
        List<College> collegeList = collegeService.finAll();

        model.addAttribute("collegeList", collegeList);
        model.addAttribute("teacherList", list);

        return "admin/addCourse";
    }


    @RequestMapping(value = "/addCourse", method = {RequestMethod.POST})
    public String addCourse(CourseCustom courseCustom, Model model) throws Exception {

        Boolean result = courseService.save(courseCustom);

        if (!result) {
            model.addAttribute("message", "璇剧▼鍙烽噸澶�");
            return "error";
        }


        return "redirect:/admin/showCourse";
    }

    @RequestMapping(value = "/editCourse", method = {RequestMethod.GET})
    public String editCourseUI(Integer id, Model model) throws Exception {
        if (id == null) {
            return "redirect:/admin/showCourse";
        }
        CourseCustom courseCustom = courseService.findById(id);
        if (courseCustom == null) {
            throw new CustomException("鏈壘鍒拌璇剧▼");
        }
        List<TeacherCustom> list = teacherService.findAll();
        List<College> collegeList = collegeService.finAll();

        model.addAttribute("teacherList", list);
        model.addAttribute("collegeList", collegeList);
        model.addAttribute("course", courseCustom);


        return "admin/editCourse";
    }


    @RequestMapping(value = "/editCourse", method = {RequestMethod.POST})
    public String editCourse(CourseCustom courseCustom) throws Exception {

        courseService.upadteById(courseCustom.getCourseid(), courseCustom);

 
        return "redirect:/admin/showCourse";
    }


    @RequestMapping("/removeCourse")
    public String removeCourse(Integer id) throws Exception {
    
        if (id == null) {
            return "admin/showCourse";
        }
        courseService.removeById(id);

        return "redirect:/admin/showCourse";
    }


    @RequestMapping(value = "selectCourse", method = {RequestMethod.POST})
    private String selectCourse(String findByName, Model model) throws Exception {

        List<CourseCustom> list = courseService.findByName(findByName);

        model.addAttribute("courseList", list);
        return "admin/showCourse";
    }

  
    @RequestMapping("/userPasswordRest")
    public String userPasswordRestUI() throws Exception {
        return "admin/userPasswordRest";
    }

    
    @RequestMapping(value = "/userPasswordRest", method = {RequestMethod.POST})
    public String userPasswordRest(Userlogin userlogin) throws Exception {

        Userlogin u = userloginService.findByName(userlogin.getUsername());

        if (u != null) {
            if (u.getRole() == 0) {
                throw new CustomException("璇ヨ处鎴蜂负绠＄悊鍛樿处鎴凤紝娌℃硶淇敼");
            }
            u.setPassword(userlogin.getPassword());
            userloginService.updateByName(userlogin.getUsername(), u);
        } else {
            throw new CustomException("娌℃壘鍒拌鐢ㄦ埛");
        }

        return "admin/userPasswordRest";
    }

 
    @RequestMapping("/passwordRest")
    public String passwordRestUI() throws Exception {
        return "admin/passwordRest";
    }

    
    @RequestMapping(value="/showWork",method = {RequestMethod.GET})
    public String showWork(Model model, Integer page) throws Exception {

    	Workspace workspace = workspaceService.findById(1); 
        model.addAttribute("workspace", workspace);
        return "admin/showWork";


    }
    @RequestMapping("/showMessage")
    public String showMessage(Model model, Integer page) throws Exception {
    	List<CourseCustom> list = null;
        PagingVO pagingVO = new PagingVO();
   
        pagingVO.setTotalCount(courseService.getCountCouse());
        if (page == null || page == 0) {
            pagingVO.setToPageNo(1);
            list = courseService.findByPaging(1);
        } else {
            pagingVO.setToPageNo(page);
            list = courseService.findByPaging(page);
        }

        model.addAttribute("courseList", list);
        model.addAttribute("pagingVO", pagingVO);

        return "admin/showMessage";


    }
    
    @RequestMapping("/showProduct")
    public String showProduct(Model model) throws Exception {
    	List<Product> list = null;
       
         list = productService.findAll();


        model.addAttribute("productList", list);
        

        return "admin/showProduct";


    }
    @RequestMapping(value="/addProduct",method = {RequestMethod.GET})
    public String addProduct(Product product) throws Exception {
    	


        return "admin/addProduct";


    }
    @RequestMapping(value="/addProduct",method = {RequestMethod.POST})
    public String addproduct(Product product) throws Exception {
    	Boolean result = productService.save(product);

        return "redirect:/admin/showProduct";


    }
    
    @RequestMapping(value="/editProduct",method = {RequestMethod.GET})
    public String editProduct(Integer id,Model model) throws Exception {
    	Product product=productService.findById(id);

        model.addAttribute("product",product);
        return "admin/editProduct";


    }
    
    @RequestMapping(value="/editProduct",method = {RequestMethod.POST})
    public String editProduct2(Product product) throws Exception {
    	productService.updateById(product);

        
    	return "redirect:/admin/showProduct";


    }
    
    @RequestMapping(value="/removeProduct")
    public String deleteProduct(Integer id) throws Exception {

    	productService.deleteById(id);

        
    	return "redirect:/admin/showProduct";
    }
    
    
    @RequestMapping(value="/showWork",method = {RequestMethod.POST})
    public String editWorkspace(Workspace workspace) throws Exception {
    	System.out.println(workspace.getwSchema());
    	System.out.println(workspace.getgContent());
    	workspaceService.updateById(workspace);
    	return "redirect:/admin/showWork";
    }

}
