using Plots
pyplot()

  g = 1
  dx = .05
  dt = .0025
  xf = 9
  tf = 6
  h = 1

  J = Int(xf/dx)
  N = Int(tf/dt)
  P = Float64[]
  K = linspace(0.1, 100, 10)

  for k in K
	M1 = eye(J-2)
	M2 = spzeros(Float64, J-2, J-2)
	M3 = spzeros(Float64, J-2, J-2)
	
	for i = 1:J-3
	  M2[i,i+1] = k*g*h
	  M2[i+1,i] = -k*g*h
	  M3[i,i+1] = k
	  M3[i+1,i] = -k
	end
	C = inv([M1 M2; M3 M1])
	push!(P, maximum(svdvals(C)))
  end

 p=plot(K, P, ylim=(0,2), xlabel="k", ylabel="|||C|||", title="Implicit")