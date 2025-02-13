package com.example.controllers;

import com.example.models.Student;
import com.example.services.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;
import java.util.List;
import java.util.stream.Collectors;


@Controller
public class StudentController {

    @Autowired
    private StudentService studentService;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public ModelAndView getAddingForm(){
        ModelAndView model = new ModelAndView("StudentForm");
        model.addObject("student", new Student());
        return model;
    }




    // method called when the details of students are required
    @RequestMapping(value = "/studentDetails.html", method = RequestMethod.GET)
    public ModelAndView getStudentDetails(@RequestParam int id){
        ModelAndView model = new ModelAndView("StudentDetails");
        Student student = studentService.getStudentById(id);
        model.addObject("student", student);
        return model;
    }

    // method called when a search is made
    @RequestMapping(value = "/search.html", method = RequestMethod.GET)
    public ModelAndView getSearchResult(@RequestParam String first_name, @RequestParam String last_name, @RequestParam String gender){
        boolean getAllStudents = last_name.isEmpty() && first_name.isEmpty() && gender.isEmpty();
        List<Student> searchResult = studentService.getSearchResults(first_name, last_name, gender, getAllStudents);
        ModelAndView model = new ModelAndView("SearchResults");
        model.addObject("students", searchResult);
        model.addObject("first_name", first_name);
        model.addObject("last_name", last_name);
        model.addObject("gender",gender);
        model.addObject("getAllStudents", getAllStudents);
        return model;

    }

    // method called when a student is added
    @RequestMapping(value = "/submitStudent.html", method = RequestMethod.POST)
    public ModelAndView submitNewStudent(@Valid @ModelAttribute("student") Student student, BindingResult result){
        ModelAndView model = new ModelAndView("StudentForm");
        if (result.hasErrors()){
            model.addObject("student", student);
            List<String> errorMessages = result.getAllErrors()
                    .stream()
                    .map(error -> error.getDefaultMessage())
                    .collect(Collectors.toList());

            model.addObject("errorMessages", errorMessages);
            // model.addObject("message", result.getAllErrors());
            return model;
        }
        studentService.addStudent(student);
        model.addObject("student", new Student());
        model.addObject("successMessage", "Student added successfully");
        return model;
    }


}
