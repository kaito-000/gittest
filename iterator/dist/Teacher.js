"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const StudentList_1 = __importDefault(require("./StudentList"));
const Student_1 = __importDefault(require("./Student"));
class MyTeacher {
    constructor() {
        this.size = 0;
        this.studentList = new StudentList_1.default(0);
    }
    createStudentList() {
        this.studentList = new StudentList_1.default(5);
        this.studentList.add(new Student_1.default('ash', 2));
        this.studentList.add(new Student_1.default('zofia', 2));
        this.studentList.add(new Student_1.default('ela', 2));
    }
    callStudents() {
        this.size = this.studentList.last;
        for (let i = 0; i < this.size; i++) {
            console.log(this.studentList.getStudentAt(i).name);
        }
    }
}
class Main {
    static main() {
        this.you.createStudentList();
        this.you.callStudents();
    }
}
Main.you = new MyTeacher();
Main.main();
