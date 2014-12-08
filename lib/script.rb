require 'matrix'
# Zwraca macierz Jakobiana
def Jakobian(x, y)
	a = 6*x^2
	b = -2*y
	c = y^3
	d = 3*x*(y^2)-1

	j = Matrix.columns([[a, c],[b, d]])

	return j
end

def FofX(x, y)
	a = 2*x^3 - y^2 - 1
	b = x*y^3 - y - 4

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

puts "Podaj początkowe wartości:"
puts "x0 = "
firstX = gets.chomp.to_i
puts "y0 = "
firstY = gets.chomp.to_i

w = GofX(firstX,firstY)

puts "#{w}"
