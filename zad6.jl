using Plots
plotlyjs()

generate_function(c :: Float64) = (x :: Float64) -> x * x + c
id_x(x :: Float64) = x

function generate_points(rec_fun, starting_point :: Float64, iterations :: Unsigned)
  x_vector = zeros(iterations)
  y_vector = zeros(iterations)
  x_vector[1] = starting_point
  y_vector[1] = rec_fun(starting_point)
  for i in 2:iterations
    x_vector[i] = y_vector[i - 1]
    y_vector[i] = rec_fun(x_vector[i])
  end

  return x_vector, y_vector
end

function main()
  #(c, x_0)
  data_array = [(-2, 1), (-2, 2), (-2, 1.99999999999999), (-1, 1), (-1, -1), (-1, 0.75), (-1, 0.25)]
  len = length(data_array)
  for i in 1:len
    c, x_0 = data_array[i]
    fun = generate_function(Float64(c))
    x_vector, y_vector = generate_points(fun, Float64(x_0), UInt64(40))
    fig = plot([fun, id_x], -2.5, 2.5, title="c = $(c); x_0 = $(x_0)", label=["y = x^2 + c" "Id_x"])
    scatter!(x_vector, y_vector, label="x(n+1) = x(n)^2 + c")
    Plots.savefig(fig, "zad6$(i).png")

    open("zad6$(i).csv", "w") do file
      write(file, "x(n),x(n+1)\n")
      for j in 1:length(x_vector)
        write(file, "$(x_vector[j]),$(y_vector[j])\n")
      end
    end
  end
end

main()