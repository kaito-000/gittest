import StudentList from './StudentList'
import Student from './Student';
interface Teacher {
    studentList: StudentList;
    createStudentList(): void;
    callStudents(): void;
}

class MyTeacher implements Teacher {
    size: number;
    studentList: StudentList;

    constructor() {
        this.size = 0;
        this.studentList = new StudentList(0);
    }

    createStudentList(): void {
        this.studentList = new StudentList(5);
        this.studentList.add(new Student('ash', 2));
        this.studentList.add(new Student('zofia', 2));
        this.studentList.add(new Student('ela', 2));
    }
    callStudents() {
        this.size = this.studentList.last;
        for (let i = 0; i < this.size; i++) {
            console.log(this.studentList.getStudentAt(i).name)
        }
    }
}

class Main {
    static you: Teacher = new MyTeacher();
    static main() {
        this.you.createStudentList();
        this.you.callStudents();
    }
}

Main.main();