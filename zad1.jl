#=
/**
 * @author Norbert Jaśniewicz
 */
=#

function scalarProductA(v1 :: Vector{T}, v2 :: Vector{T}) :: Union{T, Nothing} where {T <: Union{Float64, Float32}}
  if length(v1) != length(v2)
      return Nothing
  end

  acc :: T = 0.0

  for i in 1:length(v1)
      acc += v1[i] * v2[i]
  end

  return acc
end

function scalarProductB(v1 :: Vector{T}, v2 :: Vector{T}) :: Union{T, Nothing} where {T <: Union{Float64, Float32}}
  if length(v1) != length(v2)
      return Nothing
  end

  acc :: T = 0.0

  for i in length(v1):-1:1
      acc += v1[i] * v2[i]
  end

  return acc
end

function scalarProductC(v1 :: Vector{T}, v2 :: Vector{T}) :: Union{T, Nothing} where {T <: Union{Float64, Float32}}
  if length(v1) != length(v2)
      return Nothing
  end

  prodVector :: Vector{T} = map(i -> v1[i] * v2[i], 1:length(v1))
  nonNegativeVector :: Vector{T} = filter(x -> x >= 0.0, prodVector)
  negativeVector :: Vector{T} = filter(x -> x < 0.0, prodVector)
  sort!(nonNegativeVector, rev=true)
  sort!(negativeVector)

  acc1 :: T = reduce(+, nonNegativeVector)
  acc2 :: T = reduce(+, negativeVector)

  result :: T = acc1 + acc2

  return result
end

function scalarProductD(v1 :: Vector{T}, v2 :: Vector{T}) :: Union{T, Nothing} where {T <: Union{Float64, Float32}}
  if length(v1) != length(v2)
      return Nothing
  end

  prodVector :: Vector{T} = map(i -> v1[i] * v2[i], 1:length(v1))
  nonNegativeVector :: Vector{T} = filter(x -> x >= 0.0, prodVector)
  negativeVector :: Vector{T} = filter(x -> x < 0.0, prodVector)
  sort!(nonNegativeVector)
  sort!(negativeVector, rev=true)

  acc1 :: T = reduce(+, nonNegativeVector)
  acc2 :: T = reduce(+, negativeVector)
  result :: T = acc1 + acc2

  return result
end

function main()
  #=
  v32 :: Vector{Float32} = [2.718281828, -3.141592654, 1.414213562, 0.5772156649, 0.3010299957] 
  w32 :: Vector{Float32} = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]
  v64 :: Vector{Float64} = [2.718281828, -3.141592654, 1.414213562, 0.5772156649, 0.3010299957]
  w64 :: Vector{Float64} = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]
  =#
  v32 :: Vector{Float32} = [2.718281828, -3.141592654, 1.414213562, 0.577215664, 0.301029995] 
  w32 :: Vector{Float32} = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]
  v64 :: Vector{Float64} = [2.718281828, -3.141592654, 1.414213562, 0.577215664, 0.301029995]
  w64 :: Vector{Float64} = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]

  a32 :: Float32 = scalarProductA(v32, w32)
  a64 :: Float64 = scalarProductA(v64, w64)

  b32 :: Float32 = scalarProductB(v32, w32)
  b64 :: Float64 = scalarProductB(v64, w64)

  c32 :: Float32 = scalarProductC(v32, w32)
  c64 :: Float64 = scalarProductC(v64, w64)

  d32 :: Float32 = scalarProductD(v32, w32)
  d64 :: Float64 = scalarProductD(v64, w64)

  println("""Metoda,Typ float (l. bitów),Wynik
              A,32,$a32
              A,64,$a64
              B,32,$b32
              B,64,$b64
              C,32,$c32
              C,64,$c64
              D,32,$d32
              D,64,$d64""")
end

main()