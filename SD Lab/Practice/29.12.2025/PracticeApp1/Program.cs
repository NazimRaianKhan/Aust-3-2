using System.Runtime.CompilerServices;

namespace PracticeApp1
{
    public interface IEnrollable
    {
        void EnrollInCourse(Course course);
    }
    public class Person
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public int Id { get; set; }
        public Person()
        {

        }
        public Person(String a, string b,int c)
        {
            FirstName = a;
            LastName = b;
            Id = c;
        }

        public virtual string GetRoleDescription()
        {
            return "This is from Base Class";
        }

    }

    public class Course
    {
        private int credits;
        public string CourseCode { get; set; }
        public string Title { get; set; }
        public int Credits 
        {
            get { return credits; } 
            set
            {
                if(value >= 1)
                {
                    credits = value;
                }
                else
                {
                    Console.WriteLine("Credits cant be less than 1");
                }
            }
        }
    }

    public class Student : Person
    {
        private string major;
        public string Major { get; set; }
        public Student(String a, String b, int c, string d):base(a, b, c)
        {
            Major = d;
        }
        public override string GetRoleDescription()
        {
            return $"This is {FirstName} {LastName}, ID is {Id} and a STUDENT in {Major} ";
        }
    }

    public class Professor : Person
    {
        private string department;
        public string Department { get; set; }
        public Professor(String a, String b, int c, string d) : base(a, b, c)
        {
            Department = d;
        }
        public override string GetRoleDescription()
        {
            return $"This is {FirstName} {LastName}, ID is {Id} and a Professor from {Department} department. ";
        }
    }

    internal class Program
    {
        static void Main(string[] args)
        {
            Person p1 = new Student("John", "Doe", 101, "Computer Science");
            Person p2 = new Professor("Jane", "Smith", 202, "Mathematics");
            Console.WriteLine(p1.GetRoleDescription());
            Console.WriteLine(p2.GetRoleDescription()); 
        }
    }
}