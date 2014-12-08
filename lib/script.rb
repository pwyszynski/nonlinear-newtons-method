require 'matrix'
# Zwraca macierz Jakobiana
def Jakobian(x, y)
	a = 6*x*x
	b = -2*y
	c = y*y*y
	d = 3*x*(y*y)-1

	j = Matrix.columns([[a, c],[b, d]])

	return j
end

def FofX(x, y)
	a = 2*x*x*x - y*y - 1
	b = x*y*y*y - y - 4

	f = Matrix.column_vector([a, b])

	return f
end

def matX(x, y)
	a = x
	b = y

	vectorX = Matrix.column_vector([a, b])

	return vectorX
end

def GofX(startX, startY)
	g = matX(startX,startY) - (Jakobian(startX, startY).inverse * FofX(startX, startY))

	return g
end



#MAIN
results = Array.new

puts "Podaj początkowe wartości:"
puts "x0 = "
firstX = gets.chomp.to_i
puts "y0 = "
firstY = gets.chomp.to_i
puts "Podaj ilość iteracji"
n = gets.chomp.to_i

results[0] = GofX(firstX,firstY)

for i in (1...n) do
	results[i] = GofX(results[i-1].element(0,0), results[i-1].element(1,0))
end

print results