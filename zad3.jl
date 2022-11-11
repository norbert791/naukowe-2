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
    error("condition number  c of a matrix  should be >= 1.0")
  end
  (U,S,V)=svd(rand(n,n))
  return U*diagm(0 =>[LinRange(1.0,c,n);])*V'
end

function main()

end