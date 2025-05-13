import numpy as np
import matplotlib.pyplot as plt  # <-- corrección importante
from scipy.stats import linregress

data = [[]]
i = 0
file_path = "simulations/"
file_name = "nmos_char_idn.raw"
file = file_path + file_name

with open(file, "r") as f:
    for line in f:
        try:
            numbers = [float(x) for x in line.strip().split()]
            if len(numbers) >= 2:
                data[i].append(numbers[:2])
                if numbers[0] > 1.79:
                    i += 1
                    data.append([])
        except ValueError:
            continue

# Convert to numpy arrays
VGS = []
IDS = []

for dataset in data:
    arr = np.array(dataset)
    if arr.shape[0] > 0:  # evita errores por listas vacías
        VGS.append(arr[:, 0])
        IDS.append(arr[:, 1])

# Ejemplo: graficar curvas Id vs Vgs

valor = 0
for i in range(len(VGS)):
    valor = i * 5 + 40
    if (valor == 45) | (valor == 90) | (valor == 135):
        plt.plot(VGS[i], IDS[i] * 1000, label=f"VDS= {float(valor)/100}V")

plt.xlabel("VGS [V]")
plt.ylabel("IDS [mA]")
# plt.title("NMOS Id vs Vgs para diferentes Vds")
plt.legend()
plt.grid(True)
plt.show()

plt.figure()
valor = 0
for i in range(len(VGS)):
    valor = i * 5 + 40
    if (valor == 45) | (valor == 90) | (valor == 135):
        plt.plot(VGS[i], IDS[i] * 1000, label=f"VDS= {float(valor)/100}V")

plt.xlabel("VGS [V]")
plt.ylabel("IDS [mA]")
plt.yscale("log")
# plt.title("NMOS Id vs Vgs para diferentes Vds")
plt.legend()
plt.grid(True, which="both", linestyle="--")
plt.show()

plt.figure()
valor = 0
for i in range(len(VGS)):
    valor = i * 5 + 40
    # print(i)
    if valor == 75:
        plt.plot(VGS[i], IDS[i] * 1000, label=f"VDS= {float(valor)/100} V")
    # j+=1

plt.xlabel("VGS [V]")
plt.ylabel("IDS [mA]")
# plt.title("NMOS Id vs Vgs  Vds=0.75 V")
plt.legend()
plt.grid(True)
plt.show()
