tupleList1=[('parent', 'Hasib', 'Rakib'),('parent', 'Hasib', 'Rehana'),
            ('parent', 'Hasib', 'Hasina'),('parent', 'Rakib', 'Sohel'),
            ('parent', 'Rakib', 'Rebeka'),('parent', 'Rashid', 'Hasib'),
            ('parent', 'Hasina', 'Rasel'),('parent', 'Hasina', 'Mujib')]

male = ['Rashid','Hasib','Rakib','Sohel','Rasel','Mujib']

def findGc():
    x = str(input("Grandparent: "))
    print("Grandchildren: ")
    i = 0
    while(i<=7):
        if((tupleList1[i][0]=='parent') & (tupleList1[i][1]==x)):
            for j in range(8):
                if((tupleList1[j][0]=='parent') & (tupleList1[i][2]==tupleList1[j][1])):
                    print(tupleList1[j][2])
        i=i+1

def findGp():
    x = str(input("Grandchildren: "))
    print("Grandparent: ")
    i = 0
    while(i<=7):
        if((tupleList1[i][0]=='parent') & (tupleList1[i][2]==x)):
            for j in range(8):
                if((tupleList1[j][0]=='parent') & (tupleList1[i][1]==tupleList1[j][2])):
                    print(tupleList1[j][1])
        i=i+1

def findBrother():
    x = str(input("Sibling: "))
    print("Brother: ")
    i = 0
    while(i<=7):
        if((tupleList1[i][0]=='parent') & (tupleList1[i][2]==x)):
            for j in range(8):
                if((tupleList1[j][0]=='parent') & (tupleList1[i][1]==tupleList1[j][1]) & (tupleList1[j][2] in male) & (tupleList1[j][2]!=tupleList1[i][2])):
                    print(tupleList1[j][2])
        i=i+1

def findSister():
    x = str(input("Sibling: "))
    print("Sister: ")
    i = 0
    while(i<=7):
        if((tupleList1[i][0]=='parent') & (tupleList1[i][2]==x)):
            for j in range(8):
                if((tupleList1[j][0]=='parent') & (tupleList1[i][1]==tupleList1[j][1]) & (tupleList1[j][2] not in male) & (tupleList1[j][2]!=tupleList1[i][2])):
                    print(tupleList1[j][2])
        i=i+1

def findUncle():
    x = str(input("Nephew or Niece: "))
    print("Uncle: ")
    i = 0
    while(i<=7):
        if((tupleList1[i][0]=='parent') & (tupleList1[i][2]==x)):
            #print(tupleList1[i][1])
            for j in range(8):
                if((tupleList1[j][0]=='parent') & (tupleList1[i][1]==tupleList1[j][2])):
                    #print(tupleList1[j][1])
                    for k in range(8):
                        if((tupleList1[k][0]=='parent') & (tupleList1[j][1]==tupleList1[k][1]) & (tupleList1[k][2] in male) & (tupleList1[j][2]!=tupleList1[k][2])):
                            print(tupleList1[k][2])
        i=i+1

def findAunt():
    x = str(input("Nephew or Niece: "))
    print("Aunt: ")
    i = 0
    while(i<=7):
        if((tupleList1[i][0]=='parent') & (tupleList1[i][2]==x)):
            #print(tupleList1[i][1])
            for j in range(8):
                if((tupleList1[j][0]=='parent') & (tupleList1[i][1]==tupleList1[j][2])):
                    #print(tupleList1[j][1])
                    for k in range(8):
                        if((tupleList1[k][0]=='parent') & (tupleList1[j][1]==tupleList1[k][1]) & (tupleList1[k][2] not in male) & (tupleList1[j][2]!=tupleList1[k][2])):
                            print(tupleList1[k][2])
        i=i+1

#Main

findGc()
findGp()
findBrother()
findSister()
findUncle()
findAunt()
