import numpy as np
import pandas as pd


a = [2/8, 0/8, 4/8, 2/8]

def entropy(probs):
    entropy = 0
    for i in probs:
        if(i!=0):
            entropy+= -i*np.log2(i)
    return entropy

print(entropy(a))