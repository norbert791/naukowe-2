#author Norbert Jaśniewicz
using Plots
gr()

f(x) = exp(x) * log(1 + exp(-x))

Plots.savefig(Plots.plot(f, 1, 100),"zad21.png")

plotlyjs()

Plots.savefig(Plots.plot(f, 1, 100),"zad22.png")