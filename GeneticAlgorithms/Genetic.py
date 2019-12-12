from pyevolve import G1DList
from pyevolve import GSimpleGA

def eval_func(chromosome):
	sum = 0.0
	score = 0.0
	for value in chromosome:
		sum += value
	# if sum = 50/ 100/ 150 then score must have highest value i.e. 2.0 else lower value
	if sum == x:
		score = 2.0
	else:
		score = 1/abs(sum - x)
	return score

def Genetic():
	genome = G1DList.G1DList(20)
	genome.evaluator.set(eval_func)
	ga = GSimpleGA.GSimpleGA(genome)
	ga.evolve(freq_stats=10)
	print ga.bestIndividual()

if __name__ == "__main__":
	global x
	print "Enter the sum :"
	x = int(raw_input())
	Genetic()
