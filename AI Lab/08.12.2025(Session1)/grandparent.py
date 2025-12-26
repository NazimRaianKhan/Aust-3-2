tupleList1=[('parent', 'Hasib', 'Rakib'),('parent', 'Rakib', 'Sohel'),
             		('parent', 'Rakib', 'Rebeka'),('parent', 'Rashid', 'Hasib')]
x = str(input("Grandchildren: "))
print("Grandparent: ")
i = 0
while(i<=3):
    if((tupleList1[i][0]=='parent') & (tupleList1[i][2]==x)):
        for j in range(4):
            if((tupleList1[j][0]=='parent') & (tupleList1[i][1]==tupleList1[j][2])):
                print(tupleList1[j][1])
    i=i+1
