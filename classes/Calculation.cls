public class Calculation {
    public static Integer sum(Integer num1, Integer num2) {
        system.debug('num1@@@@@@'+num1);
        Integer resultOfSum = num1 + num2;
        system.debug('resultOfSum@@@@@@@'+resultOfSum);
        return resultOfSum;
    }

    public static Integer subtract() {
        Integer num1;
        Integer num2;
        num1=50;
        num2=20;
        Integer resultOfSubtract = num1 - num2;
        system.debug('resultOfSubtract@@@@@@@'+resultOfSubtract);
        return resultOfSubtract;
    }

    public static Integer multiply() {
        Integer num1;
        Integer num2;
        num1=20;
        num2=10;
        Integer resultOfMultiply = num1 * num2;
        system.debug('resultOfMultiply@@@@@@@'+resultOfMultiply);
        return resultOfMultiply;
    }

    public static Decimal divide() {
        Integer num1;
        Integer num2;
        num1=12;
        num2=6;
        Decimal resultOfDivide = num1 / num2;
        system.debug('resultOfDivide@@@@@@@'+resultOfDivide);
        return resultOfDivide;
    }

}