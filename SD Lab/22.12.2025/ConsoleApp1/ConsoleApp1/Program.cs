using System.Runtime.InteropServices;
using System.Security.Cryptography;
using ClassLibrary1;
using ClassLibrary2;

namespace ConsoleApp1
{
    public class Result
    {
        public bool Success { get; set; }
        public int Sum { get; set; }
    }

    public class EmployeeBase     //parent
    {
        public virtual void Print()
        {
            Console.WriteLine("From EmployeeBase");
        }
    }

    public class Employee:EmployeeBase     //child
    {
        public override void Print()
        {
            Console.WriteLine("From Employee");
        }
    }


    internal class Program
    {

        public static void increment(ref int num )
        {
            num++;
        }

        public static Result sum(int num1, int num2)
        {
            Result obj = new Result()
            {
                Success = true,
                Sum = num1 + num2,
            };

            return obj;
        }

        public static bool sum(int num1, int num2, out int result, out int result2)
        {
            result = num1 + num2;

            return result > 10 ? true : false;
        }

        static void Main(string[] args)
        {
            Employee employee = new Employee();
            employee.Print();

            ClassLibrary2.Class1 obj = new ClassLibrary2.Class1();

            int a = 1;
            increment(ref a);

            Console.WriteLine(a);

            var res = sum(11,10, out int b);
            var res2 = sum(11, 10, out int b2);

            Console.WriteLine(b);

        }
    }
}
