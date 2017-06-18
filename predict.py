#!/usr/bin/python2

from __future__ import print_function
import sys
import fileinput
import numpy as np
np.random.seed(1410)

from keras.utils import np_utils
from keras.models import Sequential
from keras.layers import Dense, Dropout, Activation
from keras.models import model_from_json
import numpy as np
import cPickle as pickle
import ast

from train import input_size


def fl_format(fl):
    return ("%.4f" % fl)

np.set_printoptions(formatter={'float_kind': fl_format})

model = model_from_json(open('model_architecture.json').read())
print("Loading tokenizer")
model.load_weights('model_weights.h5')
print("Tokenizer loaded")
model.compile(loss='mse',
              optimizer='rmsprop',
              metrics=['accuracy'])

print("Model loaded")

for line in fileinput.input():
    test  = np.array([ast.literal_eval(line)])
    # print(test)
    result = (model.predict(test, batch_size=1)).ravel()
    print(result, file=sys.stderr)
