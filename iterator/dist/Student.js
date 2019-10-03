"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
class Student {
    constructor(name, sex) {
        this.__name = name;
        this.__sex = sex;
    }
    get name() {
        return this.__name;
    }
    get sex() {
        return this.__sex;
    }
}
exports.default = Student;
