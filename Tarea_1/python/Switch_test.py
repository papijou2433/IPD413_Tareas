import numpy as np
import matplotlib.pyplot as plt  # <-- corrección importante
from scipy.stats import linregress

data = []
i = 0
file_path = "simulations/"
file_name = "switch_test.raw"
file = file_path + file_name

with open(file, "r") as f:
    for line in f:
        try:
            numbers = [float(x) for x in line.strip().split()]
            if len(numbers) >= 4:
                data.append(numbers[:8])
        except ValueError:
            continue
Tim = []
Vc1 = []
Id1 = []
Vc2 = []
Id2 = []

for dataset in data:
    Vc1.append(dataset[1])
    Tim.append(dataset[2])
    Id1.append(dataset[3])
    Vc2.append(dataset[5])
    Id2.append(dataset[7])

fig, ax1 = plt.subplots(figsize=(8, 5))

ax1.set_xlabel("Time [s]")
ax1.set_ylabel("$Voltage$ [V]", color="b")
ax1.plot(
    Tim,
    Vc1,
    color="b",
    label="$V_{c1}$",  ##marker='o',
    linewidth=1,
)
ax1.plot(
    Tim,
    Vc2,
    color="r",
    label="$V_{c2}$",
    linewidth=1,
)
fig.tight_layout()
plt.legend()
plt.show()

plt.figure()

fig, ax1 = plt.subplots(figsize=(8, 5))
color1 = "tab:blue"

ax1.plot(
    Tim,
    Id1,
    color=color1,
    label="$I_{d2}$",  ##marker='o',
    linewidth=1,
)
ax1.plot(
    Tim,
    Id2,
    color="r",
    label="$I_{d2}$",  ##marker='o',
    linewidth=1,
)
ax1.set_xlabel("Time [s]")
ax1.set_ylabel("$Current$ [A]", color=color1)
ax1.tick_params(axis="y", labelcolor=color1)
ax1.grid(True)

fig.tight_layout()
plt.legend()
plt.show()
