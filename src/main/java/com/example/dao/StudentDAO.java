package com.example.dao;

import com.example.models.Student;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.List;

@Transactional
@Repository
public class StudentDAO {

    @Autowired
    private SessionFactory sessionFactory;

    public void saveStudent(Student student){
        Session session = sessionFactory.getCurrentSession();
        session.save(student);
    }

    public List<Student> searchStudents(String first_name, String last_name, String gender, boolean getAllStudents) {
        Session session = sessionFactory.getCurrentSession();
        String hql;
        if (getAllStudents){
            hql = "FROM Student";
        } else {
            hql = "FROM Student s WHERE s.firstName LIKE :first_name AND s.lastName LIKE :last_name";
            if (!gender.isEmpty()){
                hql += " AND s.gender = :gender";
            }
        }

        Query query = session.createQuery(hql);

        if(getAllStudents){
            return query.list();
        }
        query.setString("first_name", "%" + first_name + "%");
        query.setString("last_name", "%" + last_name + "%");

        if (!gender.isEmpty()){
            query.setString("gender", gender);
        }

        return query.list();
    }

    public Student getStudentById(int id){
        Session session = sessionFactory.getCurrentSession();
        String hql;
        hql = "FROM Student s where s.id = :id";
        Query query = session.createQuery(hql);
        query.setInteger("id", id);
        return (Student) query.uniqueResult();
    }

    public void modifyField(String fieldName, String newValue, int id){
        Session session = sessionFactory.getCurrentSession();
        String hql;
        hql = "UPDATE Student SET "+fieldName+ " = :newValue where id = :id";
        Query query = session.createQuery(hql);
        query.setParameter("id", id);
        query.setParameter("newValue", newValue);
        query.executeUpdate();
    }

}
