import Student from './Student';  
class StudentList{
    protected students: Array<Student>;
    private last_max: number;
    private __last: number;

    constructor(studentCount: number){
        this.students = [];
        this.__last = 0;
        this.last_max = studentCount;
    }

    add(student: Student): void{
        this.students[this.__last++] = student;
    }

    getStudentAt(index: number): Student{
        return this.students[index];
    }

    get last(): number{
        return this.__last;
    }
}
export default StudentList;