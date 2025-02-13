package com.example.services;

import com.example.dao.StudentDAO;
import com.example.models.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
public class StudentService {

    @Autowired
    private StudentDAO studentDAO;

    @Transactional
    public void addStudent(Student student){
        studentDAO.saveStudent(student);
    }

    @Transactional
    public List<Student> getSearchResults(String firstname, String lastname, String gender, boolean getAllStudents){
        return studentDAO.searchStudents(firstname, lastname, gender, getAllStudents);
    }
    @Transactional
    public Student getStudentById(int id){
        return studentDAO.getStudentById(id);
    }

    @Transactional
    public void modifyField(String fieldName, String newValue, int id){
        studentDAO.modifyField(fieldName, newValue, id);
    }
}
