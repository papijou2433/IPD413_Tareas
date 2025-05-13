import numpy as np
import matplotlib.pyplot as plt  # <-- corrección importante
from scipy.stats import linregress

data = [[]]
i = 0
file_path = "simulations/"
file_name = "nmos_char_vds.raw"
file = file_path + file_name

with open(file, "r") as f:
    for line in f:
        try:
            numbers = [float(x) for x in line.strip().split()]
            if len(numbers) >= 2:
                data[i].append(numbers[:2])
                if numbers[0] > 1.34:
                    i += 1
                    data.append([])
        except ValueError:
            continue

# Convert to numpy arrays
VDS = []
IDS = []

for dataset in data:
    arr = np.array(dataset)
    if arr.shape[0] > 0:  # evita errores por listas vacías
        VDS.append(arr[:, 0])
        IDS.append(arr[:, 1])

# Ejemplo: graficar curvas Id vs Vgs
# j=0
valor = 0
for i in range(len(VDS)):
    valor = i * 10 + 40
    # print(i)
    if (valor == 40) | (valor == 80) | (valor == 150):
        plt.plot(VDS[i], IDS[i] * 1000, label=f"VGS= {float(valor)/100}V")
    # j+=1

plt.xlabel("VDS [V]")
plt.ylabel("IDS [mA]")
# plt.title("NMOS Id vs Vds para diferentes Vds")
plt.legend()
plt.grid(True)
plt.show()
