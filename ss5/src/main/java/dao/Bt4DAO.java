package dao;

import Model.bt4_bt5.Sv;

import java.util.*;

public class Bt4DAO {
    private static List<Sv> students = new ArrayList<>();

    // Initialize sample data
    static {
        students.add(new Sv(1, "Nguyễn Văn An", 20, "Hà Nội"));
        students.add(new Sv(2, "Trần Thị Bình", 21, "Hồ Chí Minh"));
        students.add(new Sv(3, "Lê Văn Cường", 19, "Đà Nẵng"));
        students.add(new Sv(4, "Phạm Thị Dung", 22, "Hải Phòng"));
        students.add(new Sv(5, "Hoàng Văn Em", 20, "Cần Thơ"));
    }

    // Get all students
    public List<Sv> getAllStudents() {
        return new ArrayList<>(students);
    }

    // Get student by ID
    public Sv getStudentById(int id) {
        return students.stream()
                .filter(student -> student.getId() == id)
                .findFirst()
                .orElse(null);
    }

    // Update student
    public boolean updateStudent(Sv student) {
        for (int i = 0; i < students.size(); i++) {
            if (students.get(i).getId() == student.getId()) {
                students.set(i, student);
                return true;
            }
        }
        return false;
    }

    // Add new student
    public void addStudent(Sv student) {
        students.add(student);
    }

    // Delete student
    public boolean deleteStudent(int id) {
        return students.removeIf(student -> student.getId() == id);
    }
}
