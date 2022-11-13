#author: Norbert Jaśniewicz



function generate_population_sequence(r :: T, p_0 :: T) where T <: Union{Float32, Float64}
  function p(n :: Unsigned)
    result :: T = p_0
    while n > 0
      result = result + r * result * (1.0 - result)
      n -= 1
    end
    return result
  end

  return p
end

function generate_truncated_population_sequence(r :: T, p_0 :: T) where T <: Union{Float32, Float64}
  function p(n :: Unsigned)
    result :: T = p_0
    for i in 1:n
      result = result + r * result * (1.0 - result)
      if i == 10
        result = floor(result, digits=3)
      end
    end
    return result
  end

  return p
end

function main()
  r :: Float32 = 3.0
  p_0 :: Float32 = 0.01
  r64 :: Float64 = 3.0
  p_064 :: Float64 = 0.01
  number_of_iterations :: Unsigned = 40

  fun32 = generate_population_sequence(r, p_0)
  fun64 = generate_population_sequence(r64, p_064)
  fun_trun32 = generate_truncated_population_sequence(r, p_0)

  n :: Unsigned = 5
  println("Float32,Float32 truncated,Float64")
  println("$(fun32(number_of_iterations)),$(fun_trun32(number_of_iterations)),$(fun64(number_of_iterations))")

end

main()