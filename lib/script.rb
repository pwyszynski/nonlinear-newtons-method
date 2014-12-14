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
puts "Podaj ilość miejsc po przecinku (sugerowane max. 5):"
precision = gets.chomp.to_i

results[0] = GofX(firstX,firstY)

for i in (1...n) do
	results[i] = GofX(results[i-1].element(0,0), results[i-1].element(1,0))
end


pomX = 0.0
pomY = 0.0
i = 0

#drukowanie pierwszego elementu
pomX = results[0].element(0,0).to_f.round(precision)
pomY = results[0].element(1,0).to_f.round(precision)

puts "x#{i} = " + "#{pomX}"
puts "y#{i} = " + "#{pomY}"
puts "\n"



for i in (1...results.length) do
	pomXp = results[i-1].element(0,0).to_f.round(precision)
	pomYp = results[i-1].element(1,0).to_f.round(precision)

	pomX = results[i].element(0,0).to_f.round(precision)
	pomY = results[i].element(1,0).to_f.round(precision)

	deltaX = pomX - pomXp
	deltaX = deltaX.abs.round(2)
	deltaY = pomY - pomYp
	deltaY = deltaY.abs.round(2)

	puts "x#{i} = " + "\t#{pomX}"
	puts "y#{i} = " + "\t#{pomY}"
	puts "DeX#{i} = \t#{deltaX}"
	puts "DeY#{i} = \t#{deltaY}"
	puts "\n"

	if(deltaX == 0.0 || deltaY == 0)
		puts "Rozwiązania tego układu równań są zbieżne."
		break
	end
	
end
