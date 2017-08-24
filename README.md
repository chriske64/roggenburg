# roggenburg

This will be a basic neural network to classify handwritten digits from the [MNIST dataset](http://yann.lecun.com/exdb/mnist/). This project is part of a one-week summer academy about 'convex optimisation' organised by the [German Academic Scholarship Foundation](https://www.studienstiftung.de/en/) at [Kloster Roggenburg](https://de.wikipedia.org/wiki/Kloster_Roggenburg).

###  Matlab functions

* The softmax function \\(mathrm{softmax}: \mathbb{R}^N \to \mathbb{R}^N,\; x\mapsto \left( \frac{\exp(x_i)}{\sum_{j=1}^N \exp(x_j)} \right)_{1\leq i \leq N}\\) is implemented in Matlab via the command 
```matlab
softmax
```
