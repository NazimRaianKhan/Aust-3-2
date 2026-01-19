
def readWriteFile():
    filename = "students.txt"
    student_dict = {}

    try:
        f = open(filename, "r")
        for line in f:
            name, dept, cgpa = line.strip().split("\t")
            student_dict[name] = [dept, float(cgpa)]
        f.close()
        print("Data loaded successfully.")
    except FileNotFoundError:
        print("Error: The file 'students.txt' was not found.")
        return

    name_to_change = input("Enter student name to update: ")
    if name_to_change in student_dict:
        new_val = input("Enter new CGPA: ")
        student_dict[name_to_change][1] = float(new_val)
        print("Record updated in memory.")
    else:
        print("Student not found.")

    f = open(filename, "w") 
    for name in student_dict:
        dept = student_dict[name][0]
        cgpa = student_dict[name][1]
        
        f.write(name + "\t" + dept + "\t" + str(cgpa) + "\n")
    f.close()
    print("File saved.")

#MAIN
readWriteFile()
