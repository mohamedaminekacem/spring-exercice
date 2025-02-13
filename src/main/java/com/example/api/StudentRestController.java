package com.example.api;

import com.example.models.Student;
import com.example.services.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;


@RestController
public class StudentRestController {

    @Autowired
    private StudentService studentService;

    @RequestMapping(value = "updateField", method = RequestMethod.POST)
    public void updateField(@RequestParam String fieldName, @RequestParam String newValue, @RequestParam int id) {
        studentService.modifyField(fieldName, newValue, id);
    }




}
