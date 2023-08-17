# Labs for Quantitative Decsion Making for Engineers and Scientists

This repository holds the lab notebooks for the [Quantitive Decisions for Scientists and Engineers course at Cornell](https://varnerlab.github.io/CHEME-5760-Decisions-Book/landing.html).

### Overview
Decision-making is essential to almost everything facet of life. However, are you making the best possible decisions? This course introduces quantitative decision-making tools and strategies that will give students a framework to make the best possible decisions in life, love, and finance. Students will be introduced to concepts such as utility maximization using personalized happiness functions. Students will also be introduced to modern machine learning and artificial intelligence approaches to decision-making, such as Markov Decisions Processes (MDP), Reinforcement Learning (RL), Imitation Learning (IL), and Multiagent decision-making tools and methods. 

#### Lab topics
* [Lab 1c: HelloWorld. Installation of course packages and tools](CHEME-5760-L1c-HelloWorld.ipynb)
* [Lab 2c: Utility Functions and Indifference Curves](CHEME-5760-L2c-UtilityIndifferenceCurves.ipynb)
* [Lab 3c: What role does Income and Information play in our Decisions?](CHEME-5760-L3c-IncomeInformationChoices.ipynb)
* [Lab 5c: We are not alone. Simple games and decision making.](CHEME-5760-L5c-MultiAgentsAndGames.ipynb)
* [Lab 6c: Does it make sense to cooperate?](CHEME-5760-L6c-CooperationAndInformation.ipynb)
* [Lab 7c: How risk averse are you?](CHEME-5760-L7c-RiskAversionParameter.ipynb)
* [Lab 8c: Stationary Markov Decision Processes](CHEME-5760-L8c-StationaryMDP.ipynb)
* [Lab 9c: Policy and Value Iteration](CHEME-5760-L9c-PolicyAndValueIteration.ipynb)
* [Lab 10c: Monte-Carlo Tree Search](CHEME-5760-L10c-MonteCarloTreeSearch.ipynb)
* [Lab 11c: Bandit Problems and Thompson Sampling](CHEME-5760-L11c-BanditProblemsAndThompsonSampling.ipynb)
* [Lab 12c: Model Based Reinforcement Learning](CHEME-5760-L12c-RLModelBased.ipynb)
* [Lab 13c: Model Free Reinforcement Learning](CHEME-5760-L13c-RLModelFreeLavaWorld.ipynb)
* [Lab 14c: Introduction to Bayesian Decision Rules](CHEME-5760-L14c-BayesianDecisionRules.ipynb)

### Installing Julia
This course uses the [Julia](https://julialang.org) programming language. You can find the installation instructions for Julia [here](https://julialang.org/downloads/).

### Installing Jupyter
The labs are provided as [Jupyter notebooks](https://jupyter.org); you can find the installation instruction for installing Jupyter [here](https://jupyter.org/install).  For the labs, we use [Julia](https://julialang.org) as our Jupyter notebook kernel; this requires the installation of the [IJulia](https://github.com/JuliaLang/IJulia.jl) package. 

To install [IJulia](https://github.com/JuliaLang/IJulia.jl) from the [Julia REPL](https://docs.julialang.org/en/v1/stdlib/REPL/) press the `]` key to enter [pkg mode](https://pkgdocs.julialang.org/v1/repl/) and the issue the command:

```
add IJulia
```

This will install the [IJulia](https://github.com/JuliaLang/IJulia.jl) package. If you already have Python/Jupyter installed on your machine, this process will also install a
[kernel specification](https://jupyter-client.readthedocs.io/en/latest/kernels.html#kernelspecs)
that tells [Jupyter](https://jupyter.org) how to launch [Julia](https://julialang.org) so we can use it in the notebook. You can then launch the [Jupyter notebook](https://jupyter.org) server the usual
way by running `jupyter notebook` in the terminal.

If you do NOT already have a python installation on your machine, we recommmed that you install [Anaconda](https://www.anaconda.com/products/individual) on your machine.  This will install a python distribution on your machine that includes [Jupyter](https://jupyter.org).  Once you have installed [Anaconda](https://www.anaconda.com/products/individual), you can install the [IJulia](https://github.com/JuliaLang/IJulia.jl) package. 
