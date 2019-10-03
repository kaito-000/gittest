class Student{
    private __name: string;
    private __sex: number;

    constructor(name: string, sex: number){
        this.__name = name;
        this.__sex = sex;
    }

    get name(): string{
        return this.__name;
    }

    get sex(): number{
        return this.__sex;
    }
}
export default Student;