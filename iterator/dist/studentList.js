"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
class StudentList {
    constructor(studentCount) {
        this.students = [];
        this.__last = 0;
    }
    add(student) {
        this.students[this.__last++] = student;
    }
    getStudentAt(index) {
        return this.students[index];
    }
    get last() {
        return this.__last;
    }
}
