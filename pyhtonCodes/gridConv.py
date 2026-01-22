import matplotlib.pyplot as plt

meshSize = []
cD = []
flag = 0

while flag == 0:

    m = float(input("\n Insert the Mesh size: "))
    dragcoeff = float(input("\n Insert the corresponding value of cD: "))
    meshSize.append(m)
    cD.append(dragcoeff)
    procede = input("\n Do you want to insert other data? [Y/n]: ")

    if procede == 'y' or procede == 'Y':
        print("\n \n")
        print("\n Let's continue...")
        flag = 0
    else: 
        print("\n \n")
        print("\n Let's plot the data...")
        flag = 1 

print(f"\n These are the Mesh sizes: {meshSize}")
print(f"\n These are the drag coefficient: {cD} ")

fig, ax = plt.subplots()
ax.plot(meshSize, cD, 'o-', color = 'red', label = 'cD')
ax.set_xlabel('Mesh Size')
ax.set_ylabel('cD')
ax.set_title('Grid convergence analysis for a Cybertruck in standard configuration')
plt.grid(True)
plt.legend()
plt.show()