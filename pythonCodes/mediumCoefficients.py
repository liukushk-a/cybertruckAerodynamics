from numpy import *
import pandas as pd
df = pd.read_csv(
    'forceCoeffs/2220/forceCoeffs.dat', sep = "\s+", skiprows = 9,
    names = ['Time', 'CL', 'CD', 'CM', 'CL (f)', 'CL (r)']
)

a = int(input("Enter the number of last iterations to average with: "))

meanCD = df.loc[-a:, 'CD'].mean()

print(f"The mean drag coefficient is: {meanCD}")
