import numpy as np
import matplotlib.pyplot as plt  # <-- corrección importante
from scipy.stats import linregress

data = [[]]
i = 0
file_path = "simulations/"
file_name = "ao_sweep_l.raw"
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
Ao = []

for dataset in data:
    arr = np.array(dataset)
    if arr.shape[0] > 0:  # evita errores por listas vacías
        VGS.append(arr[:, 0])
        Ao.append(arr[:, 1])

# Ejemplo: graficar curvas Id vs Vgs
# j=0
valor = 0
for i in range(len(VGS)):
    valor = i * 10 + 233
    plt.plot(VGS[i], Ao[i], label=f"L= {float(valor)/100} µ")
    # j+=1

plt.xlabel("VGS [V]")
plt.ylabel("Ao")
# plt.title("NMOS Id vs Vgs para diferentes Vds")
plt.legend()
plt.grid(True)
plt.show()
