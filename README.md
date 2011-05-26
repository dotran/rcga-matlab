# Real-Coded Genetic Algorithms (RCGA)

This repository includes my implementation of the RCGA in MATLAB.

This work was carried out during my graduate study at Korea Maritime University in Busan, South Korea during 2008-2010.

## On the selection process (for generational GAs)

1. Offspring population *completely replaces* the parent population. This was used in my implementation here.

2. Offspring population and the *whole* parent population will be mixed to form an intermediate population. Then the selection operator will select individuals for the next generation from this population.

3. *Part* of the parent population will be selected, e.g. deterministically or stochastically based on fitness, and joined with the offspring population to form an intermediate population to be input to the selection process. In this case, the number of individuals going to the intermediate population is known as the *genetic gap* (?)
In strategies (2) and (3), strong individuals --- besides the fittest ones if an elitism strategy is employed --- from the last generation may have a chance to survive in the next generation.

