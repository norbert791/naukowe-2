using Plots
gr()

f(x) = exp(x) * log(1 + exp(-x))

x = 1:100

Plots.savefig(Plots.plot(f, x),"zad21.png")

plotlyjs()

x = 1:100

Plots.savefig(Plots.plot(f, x),"zad22.png")