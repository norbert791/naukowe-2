#author Norbert Jaśniewicz

function hilb(n::Int)
  #source:https://cs.pwr.edu.pl/zielinski/lectures/scna/hilb.jl
  # Function generates the Hilbert matrix  A of size n,
  #  A (i, j) = 1 / (i + j - 1)
  # Inputs:
  #	n: size of matrix A, n>=1
  #
  #
  # Usage: hilb(10)
  #
  # Pawel Zielinski
    if n < 1
      error("size n should be >= 1")
    end
    return [1 / (i + j - 1) for i in 1:n, j in 1:n]
  end

  using LinearAlgebra

function matcond(n::Int, c::Float64)
#source: https://cs.pwr.edu.pl/zielinski/lectures/scna/matcond.jl
# Function generates a random square matrix A of size n with
# a given condition number c.
# Inputs:
#	n: size of matrix A, n>1
#	c: condition of matrix A, c>= 1.0
#
# Usage: matcond(10, 100.0)
#
# Pawel Zielinski
  if n < 2
    error("size n should be > 1")
  end
  if c< 1.0
    error("condition number c of a matrix should be >= 1.0")
  end
  (U,S,V)=svd(rand(n,n))
  return U*diagm(0 =>[LinRange(1.0,c,n);])*V'
end  

function experiment(n, matrix_generator)
  A = matrix_generator(n)
  x = ones(n)
  b = A * x
  x1 = inv(A) * b
  x2 = A \ b
  er1 = norm(x - x1) / norm(x)
  er2 = norm(x - x2) / norm(x)
  return x1, x2, er1, er2
end

function main()
  hilb_dom = 2:20
  hilb_err = map((n) -> experiment(n, hilb), hilb_dom)
  hilb_err = map(p -> (p[3],p[4]), hilb_err)
  open("hilbert.csv", "w") do file
    write(file, "N,Inversion,Gauss\n")
    index = 1
    for n in hilb_dom
      write(file, "$(n),$(hilb_err[index][1]),$(hilb_err[index][2])\n")
      index += 1
    end
  end

  cond_array = [1, 10, 10e3, 10e7, 10e12, 10e16]
  for n in [5, 10, 20]
    open("R$(n).csv", "w") do file
      write(file, "C,Inversion,Gauss\n")
      temp = map((var) -> experiment(n, (var2) -> matcond(var2, var)), cond_array)
      temp = map(p -> (p[3],p[4]), temp)
      for i in 1:length(cond_array)[1]
        write(file, "$(cond_array[i]),$(temp[i][1]),$(temp[i][2])\n")
      end
    end
  end

end

main()